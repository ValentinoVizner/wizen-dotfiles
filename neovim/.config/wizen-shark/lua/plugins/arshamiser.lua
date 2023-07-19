return {
  {
    "arsham/arshamiser.nvim",
    name = "arshamiser.nvim",
    lazy = false,
    config = function()
      -- Defer setting the colorscheme until the UI loads.
      vim.api.nvim_create_autocmd("UIEnter", {
        callback = function()
          vim.cmd.colorscheme("catppuccin")
          -- selene: allow(global_usage)
          _G.custom_foldtext = require("arshamiser.folding").foldtext
          vim.opt.foldtext = "v:lua.custom_foldtext()"
        end,
      })
    end,
    enabled = require("config.util").is_enabled("arsham/arshamiser.nvim"),
  },
  {
    "arsham/arshamiser.nvim",
    name = "heirliniser.nvim",
    config = function()
      vim.schedule(function()
        require("arshamiser.heirliniser")
        vim.api.nvim_set_option_value("tabline", [[%{%v:lua.require("arshamiser.tabline").draw()%}]], {})
      end)
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "arshamiser.nvim",
      {
        "rebelot/heirline.nvim",
        branch = "master",
        dependencies = "nvim-tree/nvim-web-devicons",
      },
    },
    event = { "VeryLazy" },
  },
}
