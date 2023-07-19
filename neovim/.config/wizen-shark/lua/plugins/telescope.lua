return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "ahmedkhalf/project.nvim",
      "cljoly/telescope-repo.nvim",
      "stevearc/aerial.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "kkharji/sqlite.lua",
      "aaronhallaert/advanced-git-search.nvim",
      "benfowler/telescope-luasnip.nvim",
      "olacin/telescope-cc.nvim",
      "tsakirist/telescope-lazy.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      {
        "ecthelionvi/NeoComposer.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        enabled = false,
        opts = {},
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>gc", "<cmd>Telescope conventional_commits<cr>", desc = "Conventional Commits" },
      { "<leader>fT", require("utils").find_files, desc = "Find Files (🔭)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fd", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      { "<leader>fL", "<cmd>Telescope repo list<cr>", desc = "Search (🔭)" },
      { "<leader>fT", "<cmd>Telescope help_tags<cr>", desc = "Help tags (🔭)" },
      { "<leader>fs", "<cmd>Telescope symbols<cr>", desc = "Symbols, Emoji" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>sw", "<cmd>Telescope live_grep<cr>", desc = "Workspace" },
      { "<leader>ss", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
      {
        "<leader>sb",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Buffer",
      },
      {
        "<leader>ft",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Colorscheme",
      },
      {
        "<leader>ps",
        "<cmd>Telescope projects<cr>",
        desc = "Recent Projects",
      },
      {
        "<leader>fc",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Buffer",
      },
      { "<leader>fo", "<cmd>Telescope aerial<cr>", desc = "Aerial Outline (🔭)" },
    },
    config = function(_, _)
      local telescope = require("telescope")
      local icons = require("config.icons")
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")
      -- local u = require("utils")
      local mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["?"] = actions_layout.toggle_preview,
        },
      }
      local hl = vim.api.nvim_set_hl
      local mainColor = "#0F1211"
      hl(0, "TelescopeBorder", { fg = mainColor, bg = mainColor })
      hl(0, "TelescopeNormal", { bg = mainColor })

      hl(0, "TelescopePromptPrefix", { fg = "white", bg = mainColor })
      hl(0, "TelescopePromptNormal", { fg = "white", bg = mainColor })
      hl(0, "TelescopePromptBorder", { fg = mainColor, bg = mainColor })

      hl(0, "TelescopePreviewTitle", { fg = "black", bg = "#00FFC1" })
      hl(0, "TelescopeResultsTitle", { fg = "black", bg = "#FFEC00" })
      hl(0, "TelescopePromptTitle", { fg = "black", bg = "#FF2D00" })
      local opts = {
        defaults = {
          -- prompt_prefix = icons.ui.Telescope .. " ",
          -- selection_caret = icons.ui.Forward .. " ",
          mappings = mappings,
          sort_mru = true,
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          border = true,
          multi_icon = "",
          entry_prefix = "   ",
          hl_result_eol = true,
          color_devicons = true,
          results_title = "",
          winblend = 0,
          wrap_results = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          pickers = {
            find_files = {
              theme = "dropdown",
              previewer = false,
              hidden = true,
              find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
            },
            git_files = {
              theme = "dropdown",
              previewer = false,
            },
            buffers = {
              theme = "dropdown",
              previewer = false,
            },
          },
          extensions = {
            file_browser = {
              theme = "dropdown",
              previewer = false,
              hijack_netrw = true,
              mappings = mappings,
            },
            project = {
              hidden_files = false,
              theme = "dropdown",
            },
          },
        },
      }
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
      telescope.load_extension("projects")
      telescope.load_extension("aerial")
      telescope.load_extension("frecency")
      telescope.load_extension("luasnip")
      telescope.load_extension("conventional_commits")
      telescope.load_extension("lazy")
      telescope.load_extension("noice")
      telescope.load_extension("notify")
      telescope.load_extension("git_worktree")
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = true,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git" },
        ignore_lsp = { "null-ls" },
      })
    end,
  },
}
