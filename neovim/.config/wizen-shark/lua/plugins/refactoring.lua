return {
  {
    "ThePrimeagen/refactoring.nvim",
    enabled = require("config.util").is_enabled("ThePrimeagen/refactoring.nvim"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(_, opts)
      require("refactoring").setup(opts)
      require("telescope").load_extension "refactoring"
    end,
    -- stylua: ignore
    keys = { 
      { "<leader>rc", function() require("telescope").extensions.refactoring.refactors() end, mode = { "v" }, desc = "Refactor", },
    },
  },
}
