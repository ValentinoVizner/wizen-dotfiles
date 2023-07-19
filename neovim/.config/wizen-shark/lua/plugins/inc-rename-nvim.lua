return {
  "smjonas/inc-rename.nvim",
  event = { "LspAttach" },
  config = function()
    require("inc_rename").setup {
      vim.keymap.set({"n", "v"}, "<leader>rw", ":IncRename ")
    }
  end,
  enabled = require("config.util").should_start("smjonas/inc-rename.nvim"),
}
