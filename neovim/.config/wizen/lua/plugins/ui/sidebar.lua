-- local crates_list = {}
--
-- local crates = {
-- 	title = "Crates",
-- 	icon = "📦",
-- 	update = function(ctx)
-- 		crates_list = require("crates").list()
-- 	end,
-- 	draw = function(ctx)
-- 		local str = ""
-- 		local hl = {}
--
-- 		local idx = 0
-- 		for name, version in pairs(crates_list) do
-- 			str = string.sub(string.format("%s\n%s: %s", str, name, version), 1, ctx.width)
-- 			table.insert(hl, { "SidebarNvimKeyword", idx, 0, string.len(name) - 1 })
-- 			idx = idx + 1
-- 		end
-- 		return {
-- 			lines = str,
-- 			hl = hl,
-- 		}
-- 	end,
-- }

return {
  {
    "sidebar-nvim/sidebar.nvim",
    cmd = "SidebarNvimOpen",
    opts = {
      side = "left",
      -- open = vim.o.columns >= 150, --vim.fn.argc() ~= 0,
      open = false,
      section_separator = { " ", " " },
      sections = {
        -- "git",
        "datetime",
        "files",
        -- "symbols",
        -- "diagnostics",
        -- "todos",
        "containers",
        -- crates,
      },
    },
  },

  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "willothy/nvim-window-picker",
      version = "v1.*",
      lazy = true,
      config = true,

    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", { silent = true, desc = "Toggle tree view" } },
    { "<leader>kf", "<cmd>Neotree reveal<CR>", { silent = true, desc = "Find file in tree view" } },
  },
  cmd = { "Neotree", "NeotreeLogs" },

  opts = {
    log_level = "error",
    log_to_file = true,
    close_if_last_window = true,
    popup_border_style = "rounded",

    default_component_configs = { -- {{{
      diagnostics = {
        symbols = {
          hint = "",
          info = " ",
          warn = " ",
          error = " ",
        },
        highlights = {
          hint = "DiagnosticSignHint",
          info = "DiagnosticSignInfo",
          warn = "DiagnosticSignWarn",
          error = "DiagnosticSignError",
        },
      },
      modified = {
        symbol = " ",
        highlight = "NeoTreeModified",
      },
      git_status = {
        symbols = {
          added = "",
          conflict = "",
          deleted = "",
          ignored = "◌",
          renamed = "➜",
          staged = "✓",
          unmerged = "",
          unstaged = "",
          untracked = "★",
        },
      },

      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        -- expander config, needed for nesting files
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "─",
        expander_expanded = "┐",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "ﰊ",
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
    }, -- }}}

    window = {
      mappings = { -- {{{
        ["<cr>"] = "open_drop",
        ["t"] = "open_tab_drop",
        ["<tab>"] = { "toggle_preview", config = { use_float = false } },

        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end,

        ["e"] = function()
          vim.api.nvim_exec("Neotree focus filesystem left", true)
        end,
        ["b"] = function()
          vim.api.nvim_exec("Neotree focus buffers left", true)
        end,
        ["g"] = function()
          vim.api.nvim_exec("Neotree focus git_status left", true)
        end,

        ["o"] = function(state)
          local node = state.tree:get_node()
          if node and node.type == "file" then
            local file_path = node:get_id()
            -- reuse built-in commands to open and clear filter
            local cmds = require "neo-tree.sources.filesystem.commands"
            cmds.open(state)
            cmds.clear_filter(state)
            -- reveal the selected file without focusing the tree
            require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
          end
        end,

        ["i"] = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.api.nvim_input(": " .. path .. "<Home>")
        end,
      }, -- }}}
    },

    event_handlers = { -- {{{
      {
        event = "neo_tree_window_after_open",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd "wincmd ="
          end
        end,
      },
      {
        event = "neo_tree_window_after_close",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd "wincmd ="
          end
        end,
      },
    }, -- }}}

    filesystem = { -- {{{
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          "node_modules",
          ".git",
          "target",
          "vendor",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
      find_args = {
        fd = {
          "-uu",
          "--exclude",
          ".git",
          "--exclude",
          "node_modules",
          "--exclude",
          "target",
        },
      },
      follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
      use_libuv_file_watcher = true,
    }, -- }}}
  },
},

-- vim: fdm=marker fdl=0
  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        default_direction = "left",
        placement = "edge",
      },
      attach_mode = "global",
    },
    lazy = true,
    cmd = "AerialToggle",
  },
}
