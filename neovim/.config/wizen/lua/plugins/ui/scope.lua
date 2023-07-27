local anyline = false
local mau = vim.api.nvim_create_augroup("murmur_au", { clear = true })

return {
  {
    "echasnovski/mini.indentscope",
    name = "mini.indentscope",
    lazy = true,
    enabled = not anyline,
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup({
        options = {
          -- border = "bottom",
          try_as_border = true,
        },
        mappings = {
          goto_top = "",
          goto_bottom = "",
          object_scope = "",
          object_scope_with_border = "",
        },
      })
      local disabled = {
        "harpoon",
        "help",
        "terminal",
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          if disabled[vim.bo.filetype] ~= nil or vim.bo.buftype ~= "" then
            vim.b.miniindentscope_disable = true
          end
        end,
      })
    end,
  },
  {
    "willothy/anyline.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    enabled = anyline,
    event = "VeryLazy",
    config = function()
      require("anyline").setup({
        highlight = "WinSeparator",
        context_highlight = "Function",
        ft_ignore = {
          "NvimTree",
          "TelescopePrompt",
          "Trouble",
          "SidebarNvim",
          "neo-tree",
          "noice",
          "terminal",
        },
      })
      local au = vim.api.nvim_create_augroup("anyline_au", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach", "CursorHold" }, {
        group = au,
        pattern = "*",
        once = true,
        callback = vim.schedule_wrap(function()
          local tab = vim.api.nvim_get_current_tabpage()
          local curwin = vim.api.nvim_get_current_win()
          local visited = {}
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
            local bufnr = vim.api.nvim_win_get_buf(win)
            vim.api.nvim_win_call(win, function()
              visited[bufnr] = true
              require("anyline.cache").get_cache(bufnr)
              require("anyline.markager").remove_all_marks(bufnr)
              require("anyline.setter").set_marks(bufnr)
              if win == curwin then
                require("anyline.context").show_context(bufnr)
              end
            end)
          end
        end),
      })
    end,
  },
  {
    "nyngwang/murmur.lua",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("murmur").setup({
        exclude_filetypes = {
          "harpoon",
          "neo-tree",
          "noice",
          "SidebarNvim",
          "terminal",
          "Trouble",
        },
                cursor_rgb = {
          guibg = "#89dceb",
          guifg = "#000000",
          gui=bold,
        },
      cursor_rgb_always_use_config = true, -- if set to `true`, then always use `cursor_rgb`.
      yank_blink = {
        enabled = true,
        on_yank = nil, -- Can be customized. See `:h on_yank`.
      },
        callbacks = {
          function()
            vim.api.nvim_exec_autocmds(
              "User",
              { pattern = "MurmurDiagnostics" }
            )
            vim.w.diag_shown = false
          end,
        },
      })
      -- To create IDE-like no blinking diagnostic message with `cursor` scope. (should be paired with the callback above)
      vim.api.nvim_create_autocmd("CursorHold", {
        group = mau,
        pattern = "*",
        callback = function()
          -- skip when a float-win already exists.
          if vim.w.diag_shown then return end

          -- open float-win when hovering on a cursor-word.
          if vim.w.cursor_word ~= "" then
            local buf = vim.diagnostic.open_float({
              scope = "cursor",
              close_events = {
                "InsertEnter",
                "User MurmurDiagnostics",
                "BufLeave",
              },
            })

            vim.api.nvim_create_autocmd({ "WinClosed" }, {
              group = mau,
              buffer = buf,
              once = true,
              callback = function() vim.w.diag_shown = false end,
            })
            vim.w.diag_shown = true
          else
            vim.w.diag_shown = false
          end
        end,
      })
    end,
  },
}
