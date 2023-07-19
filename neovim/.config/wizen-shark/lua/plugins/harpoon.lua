return {
  {
    "ThePrimeagen/harpoon",
    enabled = require("config.util").is_enabled("ThePrimeagen/harpoon"),
    --stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add File" },
      { "<leader>vm", function() require("harpoon.ui").toggle_quick_menu() end, desc = "File Menu" },
      { "<leader>vc", function() require("harpoon.cmd-ui").toggle_quick_menu() end, desc = "Command Menu" },
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "File 1" },
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "File 2" },
      { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "File 3" },
      { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "File 4" },
      { "<leader>5", function() require("harpoon.term").gotoTerminal(1) end, desc = "Terminal 1" },
      { "<leader>6", function() require("harpoon.term").gotoTerminal(2) end, desc = "Terminal 2" },
      { "<leader>7", function() require("harpoon.term").sendCommand(1,1) end, desc = "Command 1" },
      { "<leader>8", function() require("harpoon.term").sendCommand(1,2) end, desc = "Command 2" },
    },
    opts = {
      global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    },
  },
}
