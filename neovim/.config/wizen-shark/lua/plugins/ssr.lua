return {
    "cshuaimin/ssr.nvim",
    opts = {
      border = "rounded",
      min_width = 50,
      min_height = 5,
      max_width = 120,
      max_height = 25,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<cr>",
        replace_all = "<leader><cr>",
      },
    },
    --stylua: ignore
    keys = {
      { "<leader>sR", function() require("ssr").open() end, mode = {"n", "x"}, desc = "Search and Replace (SSR)" },
    },
  enabled = require("config.util").is_enabled("cshuaimin/ssr.nvim"),
}