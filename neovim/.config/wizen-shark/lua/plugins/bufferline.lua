return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    enabled = require("config.util").is_enabled("akinsho/bufferline.nvim"),
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<Tab>", "<Cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    config = function()
      require("bufferline").setup {
        options = {
          hover = {
            enabled = true,
            delay = 150,
            reveal = { "close" },
          },
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        diagnostics = "nvim_lsp",
          buffer_close_icon = "",
          modified_icon = "",
          close_icon = "",
          show_close_icon = false,
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 10,
          show_tab_indicators = true,
          indicator = {
            style = "underline",
          },

          view = "multiwindow",
          show_buffer_close_icons = true,
          separator_style = "slant",
          diagnostics_indicator = function(_, _, diag)
            local icons = require("config.icons").diagnostics
            local ret = (diag.error and icons.Error .. diag.error .. " " or "") .. (diag.warning and icons.Warn .. diag.warning or "")
            return vim.trim(ret)
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      }
    end,
  },
  -- scope buffers to tabs
  { "tiagovla/scope.nvim", event = "VeryLazy", opts = {} },
}
