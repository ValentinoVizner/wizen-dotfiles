local icons = require("wizen.icons")

return {
  -- {
  --   "folke/neodev.nvim",
  --   ft = "lua",
  --   config = function()
  --     vim.api.nvim_create_autocmd("User VeryLazy", {
  --       once = true,
  --       callback = function()
  --         require("neodev").setup({
  --           library = {
  --             enabled = true,
  --             plugins = true,
  --             runtime = true,
  --             types = true,
  --           },
  --           lspconfig = false,
  --           pathStrict = true,
  --         })
  --         local lsp = require("wizen.lsp")
  --         require("lspconfig").lua_ls.setup({
  --           settings = lsp.lsp_settings["lua_ls"],
  --           attach = lsp.lsp_attach,
  --           before_init = require("neodev.lsp").before_init,
  --         })
  --       end,
  --     })
  --   end,
  -- },
  {
    "willothy/hollywood.nvim",
    dir = "~/projects/lua/hollywood.nvim",
  },
  {
    "aznhe21/actions-preview.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      backend = { "nui", "telescope" },
      nui = {
        layout = {
          relative = "cursor",
          size = {
            width = "auto",
            height = "auto",
          },
          -- position = "auto",
          min_width = 15,
          min_height = 5,
        },
        -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
        preview = {
          size = "80%",
          border = {
            style = "rounded",
            padding = { 0, 0 },
          },
        },
        -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
        select = {
          size = "20%",
          border = {
            style = "rounded",
            padding = { 0, 0 },
          },
        },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    enabled = true,
    branch = "legacy",
    opts = {
    text = {
      spinner = {
        "⊚∙∙∙∙",
        "∙⊚∙∙∙",
        "∙∙⊚∙∙",
        "∙∙∙⊚∙",
        "∙∙∙∙⊚",
        "∙∙∙⊚∙",
        "∙∙⊚∙∙",
        "∙⊚∙∙∙",
      },
      },
      done = "✔",
      commenced = "Started",
      completed = "Completed",
    },
      fmt = {
        stack_upwards = false,
      },
      align = {
        bottom = false,
        right = true,
      },
      window = {
        blend = 0,
        relative = "editor",
      },

    lazy = true,
    config = true,
    event = "LspAttach",
  },
  {
    "smjonas/inc-rename.nvim",
    config = true,
    event = "LspAttach",
  },
  {
    "lukas-reineke/lsp-format.nvim",
    lazy = true,
    event = "LSPAttach",
  },
  -- {
  --   -- "simrat39/rust-tools.nvim",
  --   "willothy/rust-tools.nvim",
  --   branch = "no-augment",
  --   ft = "rust",
  --   config = function()
  --     local l = require("wizen.lsp")
  --     l.setup_rust()
  --   end,
  -- },
  {
    "williamboman/mason.nvim",
    event = "User ExtraLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   lazy = true,
  --   event = "User ExtraLazy",
  --   config = function()
  --     local lsp = require("wizen.lsp")
  --     lsp.lsp_setup()
  --   end,
  -- },
  {
    "kevinhwang91/nvim-ufo",
    name = "ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    lazy = true,
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   lazy = true,
  --   event = "VeryLazy",
  --   config = function()
  --     local l = require("wizen.lsp")
  --     l.setup_null()
  --   end,
  -- },
  {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    event = "LspAttach",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "kosayoda/nvim-lightbulb",
    opts = {
      ignore = {
        ft = {
          "harpoon",
          "noice",
          "neo-tree",
          "SidebarNvim",
          "Trouble",
          "terminal",
        },
        clients = { "null-ls" },
      },
      autocmd = {
        enabled = true,
        updatetime = -1,
      },
      sign = {
        enabled = true,
        priority = 100,
        hl = "DiagnosticSignWarn",
        text = icons.lsp.action_hint,
      },
    },
    lazy = true,
    event = "LspAttach",
  },
  -- {
  --   "williamboman/warden.nvim",
  --   event = "UiEnter",
  -- },
}
