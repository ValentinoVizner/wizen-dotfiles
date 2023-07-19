return {
  "rbong/vim-flog",
  dependencies = { "tpope/vim-fugitive" },
  cmd = { "Flog", "Flogsplit" },
    keys = {
    { mode = "n", "<leader>gt", function() require("sj").run() end, { desc = "Git branch viewer" }},
  },
  init = function()
    vim.g.flog_default_opts = { max_count = 2000, all = true }
  end,
  enabled = require("config.util").is_enabled("rbong/vim-flog"),
}
