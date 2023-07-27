return {
  -- Color themes
  {
    "willothy/minimus",
    -- dir = "~/projects/lua/minimus/",
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  {
    "folke/tokyonight.nvim",
  },
  {
    "echasnovski/mini.colors",
  },
  {

    "catppuccin/nvim",
    name = "catppuccin",
    -- enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",
        term_colors = true,
        integrations = {
          lsp_saga = true,
          cmp = true,
          navic = {
            enabled = true,
            custom_bg = "#f34c04",
          },
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          hop = true,
          fidget = true,
          treesitter = true,
          mason = true,
          illuminate = true,
          notify = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          dap = {
            enabled = true,
            enable_ui = true,
          },
        },
        custom_highlights = function(colors)
          return {
            CmpItemAbbr = { fg = "#D9E0EE" },
            CmpItemAbbrMatch = { fg = colors.blue, bold = true },
            CmpDoc = { bg = "#000000" },
            CmpDocBorder = { fg = "#000000", bg = "#000000" },
            PmenuDocBorder = { fg = "#000000", bg = "#000000" },
            Pmenu = { bg = "#000000" },
            CmpPmenu = { bg = "#000000" },
            CmpItemMenu = { italic = true, bold = true },
            CmpSel = { bold = true, bg = colors.green, fg = "#000000" },
            PmenuSel = { bold = true, bg = colors.green },
          }
        end,
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    -- enabled = false,
    -- priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup {}
      vim.cmd "colorscheme nightfox"
    end,
  },
  }
