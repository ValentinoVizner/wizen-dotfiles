if vim.g.minimal then return end

local keymap = vim.keymap.set
keymap("v", "<leader>rs", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "replace selection" })
keymap("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace word under cursor" })

local function register(modes, mappings, opts)
  require("which-key").register(
    mappings,
    vim.tbl_deep_extend("keep", { mode = modes }, opts or {})
  )
end

local function mkportal(title, items, callback, opts)
  opts = vim.tbl_deep_extend("keep", opts or {}, {
    max_results = 4,
  })
  local Content = require("portal.content")
  local Iterator = require("portal.iterator")
  local Portal = require("portal")

  local iter = Iterator:new(items)
  if opts.filter then iter = iter:filter(opts.filter) end
  if opts.map then iter = iter:map(opts.map) end
  iter = iter
    :map(
      function(v, _i)
        return Content:new({
          type = v.title or title,
          buffer = v.bufnr,
          cursor = { row = v.lnum, col = v.col },
          callback = callback,
        })
      end
    )
    :take(opts.max_results)

  local res = {
    source = iter,
    slots = opts.slots,
  }
  Portal.tunnel(res)
end

local function portal_diagnostics(opts)
  opts = vim.tbl_deep_extend("keep", opts or {}, {
    max_results = 4,
  })
  local diagnostics = vim.diagnostic.get(opts.buffer or nil)
  local Content = require("portal.content")
  local Iterator = require("portal.iterator")
  local Portal = require("portal")

  local iter = Iterator:new(diagnostics)
    :take(4)
    :map(function(v, _i)
      return Content:new({
        type = "diagnostics",
        buffer = v.bufnr,
        cursor = { row = v.lnum, col = 1 },
        extra = v.col,
        callback = function(content)
          local buf = content.buffer
          local cursor = content.cursor
          local win = vim.api.nvim_get_current_win()
          local bufnr = vim.api.nvim_win_get_buf(win)
          if buf ~= bufnr then vim.api.nvim_set_current_buf(buf) end
          vim.api.nvim_win_set_cursor(win, { cursor.row, content.extra })
        end,
      })
    end)
    :take(opts.max_results)
  local res = {
    source = iter,
    slots = nil,
  }
  Portal.tunnel(res)
end

local function portal_references(context)
  local params = vim.lsp.util.make_position_params()
  params.context = context or {
    includeDeclaration = true,
  }
  vim.lsp.buf_request(
    0,
    "textDocument/references",
    params,
    function(err, result)
      if err then
        vim.notify(err.message)
        return
      end
      if not result then
        vim.notify("no references found")
        return
      end
      local references = result
      mkportal("references", references, function(content)
        local buf = content.buffer
        local cursor = content.cursor
        local win = vim.api.nvim_get_current_win()
        local bufnr = vim.api.nvim_win_get_buf(win)
        if buf ~= bufnr then vim.api.nvim_set_current_buf(buf) end
        vim.api.nvim_win_set_cursor(win, { cursor.row + 1, cursor.col })
      end, {
        map = function(v)
          return {
            title = "references",
            bufnr = vim.uri_to_bufnr(v.uri),
            lnum = v.range.start.line,
            col = v.range.start.character,
          }
        end,
      })
    end
  )
end

vim.keymap.set(
  { "n", "i", "t" },
  "<C-Enter>",
  function() require("wizen.terminals").toggle() end
)

-- Dap
-- register({ "n" }, {})

-- Spider
register({ "n", "o", "x" }, {
  name = "spider",
  w = {
    function() require("spider").motion("w") end,
    "Spider-w",
  },
  e = {
    function() require("spider").motion("e") end,
    "Spider-e",
  },
  b = {
    function() require("spider").motion("b") end,
    "Spider-b",
  },
  ge = {
    function() require("spider").motion("ge") end,
    "Spider-ge",
  },
})

require("which-key").register({
  ["g"] = {
    a = { "<cmd>TSTextobjectSwapNext @parameter.inner<cr>", "Swap Arg Right" },
    A = { "<cmd>TSTextobjectSwapPrevious @parameter.inner<cr>", "Swap Arg Left" },
  },
  ["["] = {
    f = { "<cmd>TSTextobjectGotoPreviousStart @function.outer<cr>", "Previous Function Start" },
    c = { "<cmd>TSTextobjectGotoPreviousStart @class.outer<cr>", "Previous Class Start" },
    b = { "<cmd>TSTextobjectGotoPreviousStart @block.inner<cr>", "Previous Block Start" },
    F = { "<cmd>TSTextobjectGotoPreviousEnd @function.outer<cr>", "Previous Function End" },
    C = { "<cmd>TSTextobjectGotoPreviousEnd @class.outer<cr>", "Previous Class End" },
    B = { "<cmd>TSTextobjectGotoPreviousEnd @block.inner<cr>", "Previous Block End" },
  },
  ["]"] = {
    f = { "<cmd>TSTextobjectGotoNextStart @function.outer<cr>", "Next Function Start" },
    c = { "<cmd>TSTextobjectGotoNextStart @class.outer<cr>", "Next Class Start" },
    b = { "<cmd>TSTextobjectGotoNextStart @block.inner<cr>", "Next Block Start" },
    F = { "<cmd>TSTextobjectGotoNextEnd @function.outer<cr>", "Next Function End" },
    C = { "<cmd>TSTextobjectGotoNextEnd @class.outer<cr>", "Next Class End" },
    B = { "<cmd>TSTextobjectGotoNextEnd @block.inner<cr>", "Next Block End" },
  },
  ["<C-e>"] = {
    function() require("harpoon.ui").toggle_quick_menu() end,
    "Toggle harpoon quick menu",
  },
  -- ["<M-k>"] = {
  --   function() require("moveline").up() end,
  --   "Move line up",
  -- },
  -- ["<M-j>"] = {
  --   function() require("moveline").down() end,
  --   "Move line down",
  -- },
  ["<F1>"] = {
    function() require("cokeline.mappings").pick("focus") end,
    "Pick buffer",
  },
  ["<C-s>"] = {
    function() vim.cmd("write") end,
    "Save",
  },
}, { mode = { "n", "i" } })

register("n", {
  ["<Tab>"] = { "V>", "Indent line" },
  ["<S-Tab>"] = { "V<", "Unindent line" },
})

require("which-key").register({
  ["<C-Up>"] = {
    function() require("smart-splits").move_cursor_up() end,
    "which_key_ignore",
  },
  ["<C-Down>"] = {
    function() require("smart-splits").move_cursor_down() end,
    "which_key_ignore",
  },
  ["<C-Left>"] = {
    function() require("smart-splits").move_cursor_left() end,
    "which_key_ignore",
  },
  ["<C-Right>"] = {
    function() require("smart-splits").move_cursor_right() end,
    "which_key_ignore",
  },
  ["<M-Up>"] = {
    function() require("smart-splits").resize_up() end,
    "which_key_ignore",
  },
  ["<M-Down>"] = {
    function() require("smart-splits").resize_down() end,
    "which_key_ignore",
  },
  ["<M-Left>"] = {
    function() require("smart-splits").resize_left() end,

    "which_key_ignore",
  },
  ["<M-Right>"] = {
    function() require("smart-splits").resize_right() end,
    "which_key_ignore",
  },
  ["<C-k>"] = {
    function() require("smart-splits").move_cursor_up() end,
    "which_key_ignore",
  },
  ["<C-j>"] = {
    function() require("smart-splits").move_cursor_down() end,
    "which_key_ignore",
  },
  ["<C-h>"] = {
    function() require("smart-splits").move_cursor_left() end,
    "which_key_ignore",
  },
  ["<C-l>"] = {
    function() require("smart-splits").move_cursor_right() end,
    "which_key_ignore",
  },
}, { mode = { "n", "t" } })

register({ "n", "t" }, {
  ["<C-w>"] = {
    name = "window",
    ["<Up>"] = {
      function() require("smart-splits").move_cursor_up() end,
      "which_key_ignore",
    },
    ["<Down>"] = {
      function() require("smart-splits").move_cursor_down() end,
      "which_key_ignore",
    },
    ["<Left>"] = {
      function() require("smart-splits").move_cursor_left() end,
      "which_key_ignore",
    },
    ["<Right>"] = {
      function() require("smart-splits").move_cursor_right() end,
      "which_key_ignore",
    },
    ["k"] = {
      function() require("smart-splits").move_cursor_up() end,
      "which_key_ignore",
    },
    ["j"] = {
      function() require("smart-splits").move_cursor_down() end,
      "which_key_ignore",
    },
    ["h"] = {
      function() require("smart-splits").move_cursor_left() end,
      "which_key_ignore",
    },
    ["l"] = {
      function() require("smart-splits").move_cursor_right() end,
      "which_key_ignore",
    },
    ["="] = {
      function() require("focus").focus_equalise() end,
      "equalize",
    },
    ["|"] = {
      function() require("focus").focus_maximise() end,
      "maximize",
    },
    ["\\"] = {
      function() require("focus").focus_max_or_equal() end,
      "max or equal",
    },
    ["+"] = {
      function()
        require("focus").focus_disable()
        require("focus").focus_enable()
        require("focus").resize()
      end,
      "golden ratio",
    },
    v = { "split vertically" },
    s = { "split horizontally" },
    T = { "move to new tab" },
    H = { "swap left" },
    J = { "swap down" },
    K = { "swap up" },
    L = { "swap right" },
    f = {
      function()
        local win = require("window-picker").pick_window()
        if not win then return end
        vim.api.nvim_set_current_win(win)
      end,
      "pick - focus",
    },
    x = {
      function()
        local win = require("window-picker").pick_window()
        if not win then return end

        local buf = vim.api.nvim_win_get_buf(win)
        local curbuf = vim.api.nvim_get_current_buf()
        local curwin = vim.api.nvim_get_current_win()
        if buf == curbuf or win == curwin then return end

        vim.api.nvim_win_set_buf(win, curbuf)
        vim.api.nvim_win_set_buf(curwin, buf)
      end,
      "pick - swap",
    },
    q = {
      function()
        local win = require("window-picker").pick_window({
          filter_rules = {
            include_current_win = true,
            -- bo = {
            --   buftype = {
            --     "",
            --     "nofile",
            --   },
            -- },
          },
        })
        if not win then return end
        local ok, res = pcall(vim.api.nvim_win_close, win, false)
        if not ok then
          if vim.startswith(res, "Vim:E444") then
            vim.ui.select({ "Close", "Cancel" }, {
              prompt = "Close window?",
            }, function(i)
              if i == "Close" then
                vim.api.nvim_exec2("qa!", { output = true })
              end
            end)
          else
            vim.notify("could not close window", vim.log.levels.WARN)
          end
        end
      end,
      "pick - close",
    },
  },
})

register("t", {
  ["<Esc>"] = { "<C-\\><C-n>", "Exit terminal" },
})

require("which-key").register({
  ["["] = {
    name = "prev",
    b = {
      function() require("cokeline.mappings").by_step("focus", -1) end,
      "Focus previous buffer",
    },
    B = {
      function() require("cokeline.mappings").by_step("switch", -1) end,
      "Move previous buffer",
    },
  },
  ["]"] = {
    name = "next",
    b = {
      function() require("cokeline.mappings").by_step("focus", 1) end,
      "Focus next buffer",
    },
    B = {
      function() require("cokeline.mappings").by_step("switch", 1) end,
      "Move next buffer",
    },
  },
})

register({ "n", "t" }, {
  ["<S-Esc>"] = {
    "<Cmd>TroubleToggle document_diagnostics<CR>",
    "Diagnostics",
  },
  ["<S-CR>"] = {
    function() require("wizen.terminals").toggle() end,
    "Toggle terminal",
  },
})

register({ "n", "x" }, {
  ["<C-F>"] = {
    function() require("ssr").open() end,
    "Structural Search/Replace",
  },
  ["<C-CR>"] = {
    function() require("cokeline.mappings").pick("focus") end,
    "Pick buffer",
  },
})

require("which-key").register({
  v = { name = "👀 View" },
  C = { name = "📦 Crates/Packages" },
  l = {
    name = "  LSP",
    i = { "<cmd>LspInfo<cr>", "Info" },
  },
  a = {
    function() require("harpoon.mark").add_file() end,
    "Add file to harpoon",
  },
  ["<leader>"] = { "<cmd>update!<CR>", "Save" },
  Q = { "<cmd>lua require('wizen.util').quit()<CR>", "Quit" },
  t = {
    name = "toggle",
    u = { vim.cmd.UndotreeToggle, "Toggle undotree" },
    t = {
      function() require("wizen.terminals").toggle() end,
      "Toggle terminal",
    },
    f = {
      function() require("wizen.terminals").toggle_float() end,
      "Toggle floating terminal",
    },
    h = {
      function()
        local h = require("harpoon.mark")
        local buf = vim.api.nvim_buf_get_name(0)
        if not h.get_current_index() then
          h.add_file(buf) -- mark is not in list
        else
          h.rm_file(buf) -- mark is in list
        end
      end,
      "Toggle current harpoon mark",
    },
    s = {
      function()
        vim.ui.input({
          prompt = "$ ",
          completion = "shellcmd",
        }, function(v)
          if v and type(v) == "string" then
            require("wizen.terminals").with():send(v)
          end
        end)
      end,
      "Send to terminal",
    },
    p = {
      function() require("wizen.terminals").py:toggle() end,
      "Python repl",
    },
    l = {
      function() require("wizen.terminals").lua:toggle() end,
      "Lua repl",
    },
    c = {
      name = "Actions",
      a = "Code actions",
      o = {
        function() require("telescope.builtin").oldfiles() end,
        "Telescope oldfiles",
      },
      r = {
        function() require("telescope.builtin").registers() end,
        "Telescope registers",
      },
      s = {
        function() require("telescope.builtin").lsp_document_symbols() end,
        "Telescope LSP document symbols",
      },
    },
  },
  b = {
    name = "﬘ Buffer",
    p = {
      function() require("cokeline.mappings").pick("focus") end,
      "Pick buffer",
    },
    x = {
      function() require("cokeline.mappings").pick("close") end,
      "Delete buffer",
    },
  },
  p = {
    name = "📽️ Project",
    w = {
      function() require("wizen.util").browse("~/Documents/work/") end,
      "Work projects",
    },
    p = {
      function() require("wizen.util").browse("~/private_projects/") end,
      "Private projects",
    },
    v = {
      function() require("wizen.util").browse() end,
      "Browse current directory",
    },
    r = {
      function()
        require("wizen.util").browse(require("wizen.util").project_root())
      end,
      "Browse project root",
    },
    h = {
      function() require("wizen.util").browse(vim.loop.os_homedir()) end,
      "Browse home directory",
    },
    cr = {
      function()
        require("wizen.util").browse(require("wizen.util").crate_root())
      end,
      "Browse crate root",
    },
    pc = {
      function()
        require("wizen.util").browse(require("wizen.util").parent_crate())
      end,
      "Browse parent crate",
    },
  },
        c = {
          name = "  Code",
          x = {
            name = "Swap Next",
            f = "Function",
            p = "Parameter",
            c = "Class",
          },
          R = {
            name = "󰌝 Rest 󱂛",
          },
          X = {
            name = "Swap Previous",
            f = "Function",
            p = "Parameter",
            c = "Class",
          },
        },
  g = {
    name = "  Git",
          a = {
            "<cmd>!git add %:p<CR>",
            "add current",
          },
          A = { "<cmd>!git add .<CR>", "add all" },
    f = { vim.cmd.Git, "Open fugitive" },
    b = {
      function() require("blam").peek() end,
      "Peek line blame",
    },
          B = { "<cmd>Telescope git_branches<CR>", "branches" },
    g = {
      function()
        -- hacky way of toggling diffview
        local diffview = require("diffview")
        local lib = require("diffview.lib")
        if lib.get_current_view() then
          diffview.close()
        else
          diffview.open()
        end
      end,
      "Diffview",
    },
    l = { "<cmd>LazyGit<CR>", "lazygit" },

          c = {
            name = "Conflict",
            b = {
              "<cmd>GitConflictChooseBoth<CR>",
              "choose both",
            },
            n = {
              "<cmd>GitConflictNextConflict<CR>",
              "move to next conflict",
            },
            o = {
              "<cmd>GitConflictChooseOurs<CR>",
              "choose ours",
            },
            p = {
              "<cmd>GitConflictPrevConflict<CR>",
              "move to prev conflict",
            },
            t = {
              "<cmd>GitConflictChooseTheirs<CR>",
              "choose theirs",
            },
          m = { "blame line" },
          s = { '<cmd>lua require("plugins.git.diffview").toggle_status()<CR>', "status" },
          S = { "<cmd>Telescope git_status<CR>", "telescope status" },
          w = {
            name = "Worktree",
            w = "worktrees",
            c = "create worktree",
          },
  },
},
  d = {
    name = "🐞 Debug",
    t = {
      function() require("dapui").toggle() end,
      "Toggle DAP UI",
    },
  },
  n = { name = "🦄 Neorg" },
  ["/"] = {
    name = "🧙 Wizen",
    ["/"] = { "<cmd>Alpha<CR>", "open dashboard" },
    c = { "<cmd>e $MYVIMRC<CR>", "open config" },
    i = { "<cmd>Lazy<CR>", "manage plugins" },
    u = { "<cmd>Lazy update<CR>", "update plugins" },
    s = {
      name = "Session",
      c = { "<cmd>SessionManager load_session<CR>", "choose session" },
      r = { "<cmd>SessionManager delete_session<CR>", "remove session" },
      d = { "<cmd>SessionManager load_current_dir_session<CR>", "load current dir session" },
      l = { "<cmd>SessionManager load_last_session<CR>", "load last session" },
      s = { "<cmd>SessionManager save_current_session<CR>", "save session" },
    },
  },
  j = {
    name = "🪞Portal",
    gd = { portal_diagnostics, "global diagnostics" },
    d = {
      function() portal_diagnostics({ buffer = 0 }) end,
      "diagnostics",
    },
    r = { portal_references, "references" },
    j = {
      function() require("portal.builtin").jumplist.tunnel() end,
      "jumplist",
    },
    h = { function() require("portal.builtin").harpoon.tunnel() end, "harpoon" },
    q = {
      function() require("portal.builtin").quickfix.tunnel() end,
      "quickfix",
    },
    c = {
      function() require("portal.builtin").changelist.tunnel() end,
      "changelist",
    },
  },
}, { prefix = "<leader>" })

require("which-key").register({
  ["<M-k>"] = {
    function() require("moveline").block_up() end,
    "Move block up",
  },
  ["<M-j>"] = {
    function() require("moveline").block_down() end,
    "Move block down",
  },
  ["<Tab>"] = { ">gv", "Indent line" },
  ["<S-Tab>"] = { "<gv", "Unindent line" },
  ["<C-c>"] = { '"+y', "Copy selection" },
}, {
  mode = "v",
})
