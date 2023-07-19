return {

  {
    "arsham/arshlib.nvim",
    name = "arshlib.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    enabled = require("config.util").is_enabled "arsham/arshlib.nvim",
  },
  {
    "arsham/listish.nvim",
    name = "listish.nvim",
    dependencies = {
      "arshlib.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = {
      theme_list = true,
      clearqflist = "Clearquickfix", -- command
      clearloclist = "Clearloclist", -- command
      clear_notes = "ClearListNotes", -- command
      lists_close = "<leader>cc", -- closes both qf/local lists
      in_list_dd = "dd", -- delete current item in the list
      signs = { -- show signs on the signcolumn
        locallist = "", -- the icon/sigil/sign on the signcolumn
        qflist = "", -- the icon/sigil/sign on the signcolumn
        priority = 10,
      },
      extmarks = { -- annotate with extmarks
        locallist_text = " Locallist Note",
        qflist_text = " Quickfix Note",
      },
      quickfix = {
        open = "<leader>Loq",
        on_cursor = "<leader>Laq", -- add current position to the list
        add_note = "<leader>Lnq", -- add current position with your note to the list
        clear = "<leader>Ldq", -- clear all items
        close = "<leader>Lcq",
        next = "]q",
        prev = "[q",
      },
      locallist = {
        open = "<leader>Lol",
        on_cursor = "<leader>Lal",
        add_note = "<leader>Lnl",
        clear = "<leader>Ldl",
        close = "<leader>Lcl",
        next = "]w",
        prev = "[w",
      },
    },
    enabled = require("config.util").is_enabled "arsham/listish.nvim",
  },
}
