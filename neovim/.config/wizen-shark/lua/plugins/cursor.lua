return   
{
    "gen740/SmoothCursor.nvim",
    enabled = require("config.util").is_enabled("gen740/SmoothCursor.nvim"),
    event = { "BufReadPre" },
    config = function()
      require("smoothcursor").setup { fancy = { enable = true } }
    end,
  }