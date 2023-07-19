return {
  "nvim-pack/nvim-spectre",
  -- stylua: ignore
  enabled = require("config.util").is_enabled("nvim-pack/nvim-spectre"),
  keys = {
    { "<leader>S", "Replace (Spectre)" },
    { "<leader>Sr", mode="n", function() require("spectre").open() end, desc = "Replace in files"},
    { "<leader>Sf",mode="n", function() require("spectre").open_file_search({select_word=true}) end, desc = "Replace in file" },
    { "<leader>Sw",mode="n", function() require("spectre").open_visual({select_word=true}) end, desc = "Replace a word" },
    { "<leader>Sw",mode="v", function() require("spectre").open_visual() end, desc = "Replace a word" },
  },
}
