return {
  {
    "mrjones2014/legendary.nvim",
    keys = {
      { "<C-S-p>", "<cmd>Legendary<cr>", desc = "Legendary" },
      { "<leader>hc", "<cmd>Legendary<cr>", desc = "Command Palette" },
    },
    opts = {
      which_key = { auto_register = true },
    },
  },
  {
    "folke/which-key.nvim",
    dependencies = {
      "mrjones2014/legendary.nvim",
    },
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        show_help = true,
        plugins = { spelling = true },
        key_labels = { ["<leader>"] = "SPC" },
        triggers = "auto",
      })
      wk.register({
        w = { "<cmd>update!<CR>", "Save" },
        Q = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
        b = { name = "﬘ Buffer" },
        C = { name = "📦 Crates/Packages" },
        d = { name = "🐞 Debug" },
        f = { name = "🔭 Telescope" },
        n = { name = "🦄 Neorg" },
        m = { name = "🎬 Manage" },
        h = { name = "🏥 Help" },
        r = { name = "🔁 Replace" },
        o = { name = "Open" },
        p = { name = "📽️Project" },
        v = { name = "👀 View" },
        z = { name = "💤 Plugin Manager" },
        l = {
          name = "  LSP",
          i = { "<cmd>LspInfo<cr>", "Info" },
        },
        ["sn"] = { name = "+Noice" },
        s = {
          name = " Search",
          c = {
            function()
              require("utils.cht").cht()
            end,
            "Cheatsheets",
          },
          o = {
            function()
              require("utils.cht").stack_overflow()
            end,
            " Stack Overflow",
          },
        },
        c = {
          name = "  Code",
          x = {
            name = "Swap Next",
            f = "Function",
            p = "Parameter",
            c = "Class",
          },
          R = {
            name = "󰌝 Rest 󱂛"
          },
          X = {
            name = "Swap Previous",
            f = "Function",
            p = "Parameter",
            c = "Class",
          },
        },
        g = {
            name = "  Git",
            a = { '<cmd>!git add %:p<CR>',                                              'add current' },
            A = { '<cmd>!git add .<CR>',                                                'add all' },
            b = { '<cmd>lua require("internal.blame").open()<CR>',                      'blame' },
            B = { '<cmd>Telescope git_branches<CR>',                                    'branches' },
            c = {
              name = 'Conflict',
              b = {'<cmd>GitConflictChooseBoth<CR>',                                    'choose both'},
              n = {'<cmd>GitConflictNextConflict<CR>',                                  'move to next conflict'},
              o = {'<cmd>GitConflictChooseOurs<CR>',                                    'choose ours'},
              p = {'<cmd>GitConflictPrevConflict<CR>',                                  'move to prev conflict'},
              t = {'<cmd>GitConflictChooseTheirs<CR>',                                  'choose theirs'},
            },
            d = { '<cmd>lua require("plugins.git.diffview").toggle_file_history()<CR>', 'diff file' },
            g = { '<cmd>LazyGit<CR>',                                                   'lazygit' },
            h = {
              name = 'Hunk',
              d = 'diff hunk',
              p = 'preview',
              R = 'reset buffer',
              r = 'reset hunk',
              s = 'stage hunk',
              S = 'stage buffer',
              t = 'toggle deleted',
              u = 'undo stage',
            },
            l = {
              name = 'Log',
              A = {'<cmd>lua require("plugins.telescope").my_git_commits()<CR>',  'commits (Telescope)'},
              a = {'<cmd>LazyGitFilter<CR>',                                      'commits'},
              C = {'<cmd>lua require("plugins.telescope").my_git_bcommits()<CR>', 'buffer commits (Telescope)'},
              c = {'<cmd>LazyGitFilterCurrentFile<CR>',                           'buffer commits'},
            },
            m = { 'blame line' },
            s = { '<cmd>lua require("plugins.git.diffview").toggle_status()<CR>', 'status' },
            S = { '<cmd>Telescope git_status<CR>',                                'telescope status' },
            w = {
              name = 'Worktree',
              w = 'worktrees',
              c = 'create worktree',
            }
          },
      }, { prefix = "<leader>" })
    end,
  },
}
