local function get_codelldb()
  local mason_registry = require "mason-registry"
  local codelldb = mason_registry.get_package "codelldb"
  local extension_path = codelldb:get_install_path() .. "/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  return codelldb_path, liblldb_path
end
-- correctly setup lspconfig for Rust 🚀
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      -- make sure mason installs the server
      servers = {
        rust_analyzer = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          require("plugins.lsp.utils").on_attach(function(client, buffer)
          -- stylua: ignore
          if client.name == "rust_analyzer" then
            vim.keymap.set("n", "K", "<cmd>RustHoverActions<cr>", { buffer = buffer, desc = "Hover Actions (Rust)" })
            vim.keymap.set("n", "<leader>cR", "<cmd>RustCodeAction<cr>", { buffer = buffer, desc = "Code Action (Rust)" })
            vim.keymap.set("n", "<leader>dr", "<cmd>RustDebuggables<cr>", { buffer = buffer, desc = "Run Debuggables (Rust)" })
          end
          end)
          local mason_registry = require "mason-registry"
          -- rust tools configuration for debugging support
          local codelldb = mason_registry.get_package "codelldb"
          local extension_path = codelldb:get_install_path() .. "/extension/"
          local codelldb_path = extension_path .. "adapter/codelldb"
          local liblldb_path = vim.fn.has "mac" == 1 and extension_path .. "lldb/lib/liblldb.dylib" or extension_path .. "lldb/lib/liblldb.so"
          local rust_tools_opts = vim.tbl_deep_extend("force", opts, {
            dap = {
              adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            tools = {
              on_initialized = function()
                vim.cmd [[
              augroup RustLSP
              autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
              autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
              augroup END
              ]]
              end,
            },
            server = {
              settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                  },
                  -- Add clippy lints for Rust.
                  checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                  },
                  procMacro = {
                    enable = true,
                    ignored = {
                      ["async-trait"] = { "async_trait" },
                      ["napi-derive"] = { "napi" },
                      ["async-recursion"] = { "async_recursion" },
                    },
                  },
                },
              },
            },
          })
          require("rust-tools").setup(rust_tools_opts)
          return true
        end,
        taplo = function(_, _)
          local function show_documentation()
            if vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
              require("crates").show_popup()
            else
              vim.lsp.buf.hover()
            end
          end
          require("plugins.lsp.utils").on_attach(function(client, buffer)
          -- stylua: ignore
          if client.name == "taplo" then
            vim.keymap.set("n", "K", show_documentation, { buffer = buffer, desc = "Show Crate Documentation" })
          end
          end)
          return false -- make sure the base implementation calls taplo.setup
        end,
      },
    },
  },
  {
    "saecki/crates.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = { "BufReadPre Cargo.toml" },
    opts = {
      popup = {
        autofocus = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = require("wizen.util").augroup "CmpSourceCargo",
        pattern = "Cargo.toml",
        callback = function()
          local crates = require "crates"
          local opts = { noremap = true, silent = true, buffer = true }

          vim.keymap.set("n", "<leader>Ct", crates.toggle, opts)
          vim.keymap.set("n", "<leader>Cr", crates.reload, opts)

          vim.keymap.set("n", "H", crates.show_popup, opts)
          vim.keymap.set("n", "<leader>Cv", crates.show_versions_popup, opts)
          vim.keymap.set("n", "<leader>Cf", crates.show_features_popup, opts)
          vim.keymap.set("n", "<leader>Cd", crates.show_dependencies_popup, opts)

          vim.keymap.set("n", "<leader>Cu", crates.update_crate, opts)
          vim.keymap.set("v", "<leader>Cu", crates.update_crates, opts)
          vim.keymap.set("n", "<leader>Ca", crates.update_all_crates, opts)
          vim.keymap.set("n", "<leader>CU", crates.upgrade_crate, opts)
          vim.keymap.set("v", "<leader>CU", crates.upgrade_crates, opts)
          vim.keymap.set("n", "<leader>CA", crates.upgrade_all_crates, opts)

          vim.keymap.set("n", "<leader>CH", crates.open_homepage, opts)
          vim.keymap.set("n", "<leader>CR", crates.open_repository, opts)
          vim.keymap.set("n", "<leader>CD", crates.open_documentation, opts)
          vim.keymap.set("n", "<leader>CC", crates.open_crates_io, opts)
        end,
      })
    end,

  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        codelldb = function()
          local codelldb_path, _ = get_codelldb()
          local dap = require "dap"
          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--port", "${port}" },

              -- On windows you may have to uncomment this:
              -- detached = false,
            },
          }
          dap.configurations.cpp = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
          }

          dap.configurations.c = dap.configurations.cpp
          dap.configurations.rust = dap.configurations.cpp
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require "neotest-rust",
      })
    end,
  },
}
