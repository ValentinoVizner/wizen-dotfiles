  return {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",

    keymaps = {
      ["<C-Tab>"] = function()
        require("dropbar.api").pick()
      end,
    },
    enabled = require("config.util").is_enabled "Bekaboo/dropbar.nvim",
  }