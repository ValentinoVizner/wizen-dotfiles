return {
  "mbbill/undotree",
  branch = "search",
  init = function()
    vim.g.undotree_CustomUndotreeCmd = "vertical 40 new"
    vim.g.undotree_CustomDiffpanelCmd = "botright 15 new"
  end,
  cmd = { "UndotreeShow", "UndotreeToggle" },
  keys = {
    { mode = "n", "<leader>gu", ":UndotreeToggle<CR>", { silent = true, desc = "Toggle Undotree" } },
  },
  enabled = require("config.util").is_enabled("mbbill/undotree"),
}
