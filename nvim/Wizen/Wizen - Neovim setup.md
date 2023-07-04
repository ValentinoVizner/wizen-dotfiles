# 📝 config 
## autocmds 
Autocommands are a way to tell Vim to run certain commands whenever certain events happen. Let's dive right into an example.
```lua fold file:autocmds.lua  !tangle:~/.config/nvim/Wizen/lua/config/autocmds.lua
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto toggle hlsearch
local ns = vim.api.nvim_create_namespace "toggle_hlsearch"
local function toggle_hlsearch(char)
  if vim.fn.mode() == "n" then
    local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end
vim.on_key(toggle_hlsearch, ns)

-- windows to close
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "OverseerForm",
    "OverseerList",
    "floggraph",
    "fugitive",
    "git",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-summary",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

```
## Enabled list of plugins
Here is a list of all the enabled and disabled plugins.
```lua lua fold file:enabled_list.lua  !tangle:~/.config/nvim/Wizen/lua/config/enabled_list.lua
---@type table<string, table<string, boolean>>
return {
  ["arsham/listish.nvim"] = { enabled = true, start = true },
  ["nanozuki/tabby.nvim"] = { enabled = false, start = true },
  ["Bekaboo/dropbar.nvim"] = { enabled = false, start = true },
  ["nvim-tree/nvim-web-devicons"] = { enabled = true, start = true },
  ["junegunn/fzf"] = { enabled = true, start = true },
  ["junegunn/fzf.vim"] = { enabled = true, start = true },
  ["arsham/fzfmania.nvim"] = { enabled = true, start = true },
  ["ibhagwan/fzf-lua"] = { enabled = true, start = true },
  ["tweekmonster/startuptime.vim"] = { enabled = true, start = true },
  ["tpope/vim-repeat"] = { enabled = true, start = true },
  ["arsham/archer.nvim"] = { enabled = true, start = true },
  ["MunifTanjim/nui.nvim"] = { enabled = true, start = true },
  ["arsham/indent-tools.nvim"] = { enabled = true, start = true },
  ["arsham/matchmaker.nvim"] = { enabled = true, start = true },
  ["stevearc/oil.nvim"] = { enabled = true, start = true },
  ["tpope/vim-fugitive"] = { enabled = true, start = true },
  ["tpope/vim-rhubarb"] = { enabled = true, start = true },
  ["tpope/vim-git"] = { enabled = true, start = true },
  ["nvim-treesitter/nvim-treesitter"] = { enabled = true, start = true },
  ["lewis6991/gitsigns.nvim"] = { enabled = true, start = true },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = { enabled = true, start = true },
  ["rcarriga/nvim-notify"] = { enabled = true, start = true },
  ["nvim-treesitter/nvim-treesitter-refactor"] = { enabled = true, start = true },
  ["nvim-treesitter/playground"] = { enabled = true, start = true },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = { enabled = true, start = true },
  ["andymass/vim-matchup"] = { enabled = true, start = true },
  ["monaqa/dial.nvim"] = { enabled = true, start = true },
  ["stevearc/dressing.nvim"] = { enabled = true, start = true },
  ["mattn/vim-gist"] = { enabled = true, start = true },
  ["RaafatTurki/hex.nvim"] = { enabled = true, start = true },
  ["iamcco/markdown-preview.nvim"] = { enabled = true, start = true },
  ["numToStr/Navigator.nvim"] = { enabled = true, start = true },
  ["nvim-neo-tree/neo-tree.nvim"] = { enabled = true, start = true },
  ["s1n7ax/nvim-window-picker"] = { enabled = true, start = true },
  ["ralismark/opsort.vim"] = { enabled = true, start = true },
  ["sQVe/sort.nvim"] = { enabled = true, start = true },
  ["dhruvasagar/vim-zoom"] = { enabled = true, start = true },
  ["David-Kunz/treesitter-unit"] = { enabled = true, start = true },
  ["mason-lspconfig.nvim"] = { enabled = true, start = true },
  ["neovim/nvim-lspconfig"] = { enabled = true, start = true },
  ["williamboman/mason-lspconfig.nvim"] = { enabled = true, start = true },
  ["williamboman/mason.nvim"] = { enabled = true, start = true },
  ["hrsh7th/nvim-cmp"] = { enabled = true, start = true },
  ["saadparwaiz1/cmp_luasnip"] = { enabled = true, start = true },
  ["L3MON4D3/LuaSnip"] = { enabled = true, start = true },
  ["hrsh7th/cmp-cmdline"] = { enabled = true, start = true },
  ["j-hui/fidget.nvim"] = { enabled = true, start = true },
  ["jose-elias-alvarez/null-ls.nvim"] = { enabled = true, start = true },
  ["jay-babu/mason-null-ls.nvim"] = { enabled = true, start = true },
  ["WhoIsSethDaniel/mason-tool-installer.nvim"] = { enabled = true, start = true },
  ["numToStr/Comment.nvim"] = { enabled = true, start = true },
  ["smjonas/inc-rename.nvim"] = { enabled = true, start = true },
  ["windwp/nvim-autopairs"] = { enabled = true, start = true },
  ["arthurxavierx/vim-caser"] = { enabled = true, start = true },
  ["NvChad/nvim-colorizer.lua"] = { enabled = true, start = true },
  ["saecki/crates.nvim"] = { enabled = true, start = true },
  ["kosayoda/nvim-lightbulb"] = { enabled = true, start = true },
  ["gbprod/substitute.nvim"] = { enabled = true, start = true },
  ["whynothugo/lsp_lines.nvim"] = { enabled = true, start = true },
  ["milisims/nvim-luaref"] = { enabled = true, start = true },
  ["echasnovski/mini.nvim"] = { enabled = true, start = true },
  ["folke/neodev.nvim"] = { enabled = true, start = true },
  ["nvim-neorg/neorg"] = { enabled = true, start = true },
  ["kevinhwang91/nvim-bqf"] = { enabled = true, start = true },
  ["bfredl/nvim-luadev"] = { enabled = true, start = true },
  ["SmiteshP/nvim-navic"] = { enabled = true, start = true },
  ["kiran94/s3edit.nvim"] = { enabled = true, start = true },
  ["woosaaahh/sj.nvim"] = { enabled = true, start = true },
  ["mbbill/undotree"] = { enabled = true, start = true },
  ["rbong/vim-flog"] = { enabled = true, start = true },
  ["towolf/vim-helm"] = { enabled = true, start = true },
  ["tmux-plugins/vim-tmux"] = { enabled = true, start = true },
  ["mg979/vim-visual-multi"] = { enabled = true, start = true },
  ["svban/YankAssassin.vim"] = { enabled = true, start = true },
  ["zbirenbaum/copilot.lua"] = { enabled = true, start = true },
  ["Exafunction/codeium.vim"] = { enabled = true, start = true },
  ["utilyre/barbecue.nvim"] = { enabled = true, start = true },
  ["uga-rosa/cmp-dynamic"] = { enabled = true, start = true },
  ["stevearc/overseer.nvim"] = { enabled = true, start = true },
  ["ziontee113/color-picker.nvim"] = { enabled = true, start = true },
  ["aduros/ai.vim"] = { enabled = true, start = true },
  ["tamton-aquib/duck.nvim"] = { enabled = true, start = true },
  ["rest-nvim/rest.nvim"] = { enabled = true, start = true },
  ["jbyuki/venn.nvim"] = { enabled = true, start = true },
}
```
## 📁 icons
Here are icons used all over the lua configs.
```lua fold file:icons.lua  !tangle:~/.config/nvim/Wizen/lua/config/icons.lua
return {
  kind = {
    Array = "[]",
    Boolean = " ",
    Calendar = " ",
    Class = "󰠱 ",
    Codeium = " ",
    Color = "󰏘 ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = "󰜢 ",
    File = "󰈚 ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = "󰌋 ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = "ﳠ ",
    Number = " ",
    Object = "󰅩 ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰙅 ",
    Table = " ",
    TabNine = "",
    Tag = " ",
    Text = "󰉿 ",
    TypeParameter = "󰊄 ",
    Unit = "󰑭 ",
    Value = "󰎠 ",
    Variable = "󰀫 ",
  },
  git = {
    LineAdded = " ",
    LineModified = " ",
    LineRemoved = " ",
    FileDeleted = " ",
    FileIgnored = "◌",
    FileRenamed = " ",
    FileStaged = "S",
    FileUnmerged = " ",
    FileUnstaged = "",
    FileUntracked = "U",
    Diff = " ",
    Repo = " ",
    Octoface = " ",
    Branch = "",
  },
  ui = {
    ArrowCircleDown = "",
    ArrowCircleLeft = "",
    ArrowCircleRight = "",
    ArrowCircleUp = "",
    BoldArrowDown = "",
    BoldArrowLeft = "",
    BoldArrowRight = "",
    BoldArrowUp = "",
    BoldClose = "",
    BoldDividerLeft = "",
    BoldDividerRight = "",
    BoldLineLeft = "▎",
    BookMark = "",
    BoxChecked = "",
    Bug = " ",
    Stacks = " ",
    Scopes = "",
    Watches = "",
    DebugConsole = " ",
    Calendar = " ",
    Check = " ",
    ChevronRight = ">",
    ChevronShortDown = "",
    ChevronShortLeft = "",
    ChevronShortRight = "",
    ChevronShortUp = "",
    Circle = " ",
    Close = "",
    CloudDownload = " ",
    Code = " ",
    Comment = " ",
    Dashboard = " ",
    DividerLeft = "",
    DividerRight = "",
    DoubleChevronRight = "»",
    Ellipsis = "",
    EmptyFolder = " ",
    EmptyFolderOpen = " ",
    File = " ",
    FileSymlink = " ",
    Files = " ",
    FindFile = "",
    FindText = "",
    Fire = " ",
    Folder = "",
    FolderOpen = "",
    FolderSymlink = "",
    Forward = "",
    Gear = " ",
    History = " ",
    Lightbulb = " ",
    LineLeft = "▏",
    LineMiddle = "│",
    List = " ",
    Lock = " ",
    NewFile = " ",
    Note = " ",
    Package = " ",
    Pencil = "",
    Plus = "",
    Project = " ",
    Search = " ",
    SignIn = " ",
    SignOut = " ",
    Tab = " ",
    Table = " ",
    Target = " ",
    Telescope = " ",
    Text = "",
    Tree = "",
    Triangle = "契",
    TriangleShortArrowDown = "",
    TriangleShortArrowLeft = "",
    TriangleShortArrowRight = "",
    TriangleShortArrowUp = "",
  },
  diagnostics = {
    BoldError = "",
    Error = "🚨",
    Warn = "🤡",
    Warning = " ",
    Info = "💬",
    Information = " ",
    BoldQuestion = "",
    Question = " ",
    BoldHint = "",
    Hint = "ﯦ ",
    Debug = " ",
    Trace = "✎",
  },
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  misc = {
    Robot = "ﮧ ",
    Squirrel = " ",
    Tag = " ",
    Watch = " ",
    Smiley = " ",
    Package = " ",
    CircuitBoard = " ",
  },
  border_chars = {
    border_chars_none = { "", "", "", "", "", "", "", "" },
    border_chars_empty = { " ", " ", " ", " ", " ", " ", " ", " " },
    border_chars_tmux = { " ", " ", " ", " ", " ", " ", " ", " " },
    border_chars_inner_thick = { " ", "▄", " ", "▌", " ", "▀", " ", "▐" },
    border_chars_outer_thick = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
    border_chars_outer_thin = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    border_chars_inner_thin = { " ", "▁", " ", "▏", " ", "▔", " ", "▕" },
    border_chars_outer_thin_telescope = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
    border_chars_outer_thick_telescope = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
  },
}

```
##  ⌨️ keymaps
```lua fold file:keymaps.lua  !tangle:~/.config/nvim/Wizen/lua/config/keymaps.lua
local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>")
keymap("t", "jk", "<C-\\><C-n>")
-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Awesome replace word/s
keymap("v", "<leader>rs", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "replace selection" })
keymap("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace word under cursor" })
-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "0")
keymap("n", "gl", "$")

-- Code action
keymap({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Rename all occurrences of the hovered word for the selected files
keymap("n", "gR", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Go to type definition
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show buffer diagnostics
keymap("n", "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Show workspace diagnostics
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

-- Show cursor diagnostics
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
end)

-- Toggle outline
keymap("n", "<leader>co", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
-- keymap("n", "<C-Tab>", require("dropbar.api").pick)

-- Floating terminal
keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
```
## 💤 lazy
Here we import all the plugins and lazy load them
```lua fold file:lazy.lua  !tangle:~/.config/nvim/Wizen/lua/config/lazy.lua
--- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup {
  spec = {
    { import = "plugins" },
    { import = "plugins.pde.lang" },
    { import = "plugins.pde.ui" },
    { import = "plugins.pde.coding" },
    { import = "plugins.workspace" },
  },
  defaults = { lazy = true, version = nil },
  checker = { enabled = true },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
vim.keymap.set("n", "<leader>z", "<cmd>:Lazy<cr>")
```
## options
In options we set all the important options for the Neovim/Vim, like indentation, mouse support, case sensitivity, using swapfile, etc.
```lua fold file:options.lua  !tangle:~/.config/nvim/Wizen/lua/config/options.lua
local indent = 2

vim.o.formatoptions = "jcroqlnt"
vim.o.shortmess = "filnxtToOFWIcC"
vim.opt.swapfile = false
vim.o.showtabline = 2
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.clipboard = "unnamedplus" -- Access system clipboard
vim.opt.completeopt = "menuone,noselect"
vim.opt.conceallevel = 3
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.joinspaces = false
vim.opt.laststatus = 0
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
-- vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.scrollback = 100000
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.wildmode = "longest:full,full"

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.opt.termguicolors = true
```

## ⚡ util
Custom functions used throughout the plugins in Neovim setup.
```lua fold file:util.lua  !tangle:~/.config/nvim/Wizen/lua/config/util.lua
local M = {}

local augroups = {}
local plugins = require "config.enabled_list"
---Returns true if the plugin is enabled. Disabled plugins are listed in the
-- plugins table.
---@param name string e.g. "arsham/arshlib.nvim"
---@return boolean
function M.is_enabled(name)
  if plugins[name] and not plugins[name].enabled then
    return false
  end
  return true
end

function M.augroup(name)
  if augroups[name] then
    return augroups[name]
  end
  local group = vim.api.nvim_create_augroup(name, { clear = true })
  augroups[name] = group
  return group
end
return M
```
# 🔌 plugins
## 🎨 colorscheme
This folder consists of colorscheme initialization files.
```lua fold file:init.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/colorscheme/init.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",
        term_colors = true,
        integrations = {
          lsp_saga = true,
          cmp = true,
          navic = {
            enabled = true,
            custom_bg = "#f34c04",
          },
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          hop = true,
          fidget = true,
          treesitter = true,
          mason = true,
          illuminate = true,
          notify = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          dap = {
            enabled = true,
            enable_ui = true,
          },
        },
        custom_highlights = function(colors)
          return {
            CmpItemAbbr = { fg = "#D9E0EE" },
            CmpItemAbbrMatch = { fg = colors.blue, bold = true },
            CmpDoc = { bg = "#000000" },
            CmpDocBorder = { fg = "#000000", bg = "#000000" },
            PmenuDocBorder = { fg = "#000000", bg = "#000000" },
            Pmenu = { bg = "#000000" },
            CmpPmenu = { bg = "#000000" },
            CmpItemMenu = { italic = true, bold = true },
            CmpSel = { bold = true, bg = colors.green, fg = "#000000" },
            PmenuSel = { bold = true, bg = colors.green },
          }
        end,
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    -- enabled = false,
    -- priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup {}
      vim.cmd "colorscheme nightfox"
    end,
  },
}

```

## 📁 completion
Completion folder consists of plugins and snippets that serve as a completion engine for suggestions.

## luasnip 
Luasnip folder consists of all the snippets for different programming languages.
### lua
```lua fold file:lua.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/lua.lua
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local util = require("plugins.luasnip.util")

return {
  ls.s( -- Ignore stylua {{{
    { trig = "ignore", name = "Ignore Stylua" },
    fmt("-- stylua: ignore {}\n{}", {
      ls.c(1, {
        ls.t("start"),
        ls.t("end"),
      }),
      ls.i(0),
    })
  ), --}}}

  ls.s( -- Function {{{
    { trig = "fn", dsce = "create a function" },
    fmt(
      [[
      {} {}({})
        {}
      end
    ]],
      {
        ls.c(1, {
          ls.t("function"),
          ls.t("local function"),
        }),
        ls.i(2),
        ls.i(3),
        ls.i(0),
      }
    )
  ), --}}}

  ls.s( -- Require Module {{{
    { trig = "req", name = "Require", dscr = "Choices are on the variable name" },
    fmt([[local {} = require("{}")]], {
      ls.d(2, util.last_lua_module_section, { 1 }),
      ls.i(1),
    })
  ), --}}}
}
-- vim: fdm=marker fdl=0
```
### rust
```lua fold file:rust.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/rust.lua
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  ls.s(
    { trig = "testmod", name = "Create a test module" },
    fmt(
      [[
      #[cfg(test)]
      mod {} {{
          use super::*;

          #[test]
          fn {}() -> Result<(), Box<dyn std::error::Error>> {{
              {}
          }}
      }}
    ]],
      {
        ls.i(1),
        ls.i(2),
        ls.i(0),
      }
    )
  ),

  ls.s(
    { trig = "test", name = "Create a test function" },
    fmt(
      [[
      #[test]
      fn {}() -> Result<(), Box<dyn std::error::Error>> {{
          {}
          Ok(())
      }}
    ]],
      {
        ls.i(1),
        ls.i(0),
      }
    )
  ),

  ls.s(
    { trig = "crit", name = "Scaffold a criterion benchmark" },
    fmt(
      [[
      use criterion::{{black_box, criterion_group, criterion_main, Criterion}};

      pub fn {}(c: &mut Criterion) {{
          c.bench_function("{} {}", |b| b.iter(|| {{
              {}
          }}));
      }}
      criterion_group!({}_bench, {});
      criterion_main!({}_bench);
    ]],
      {
        ls.i(1),
        rep(1),
        ls.i(2),
        ls.i(0),
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),

  ls.s(
    { trig = "critthrp", name = "Scaffold a criterion benchmark with throughput" },
    fmt(
      [[
      pub fn {}(c: &mut Criterion) {{
          let {} = vec![];
          let mut {} = c.benchmark_group("{}_group");
          for {} in {}.iter() {{
              {}.throughput(Throughput::Bytes(*{} as u64));
              {}.bench_with_input(BenchmarkId::from_parameter({}), {}, |b, &{}| {{
                  b.iter(|| {{
                      {}
                  }});
              }});
          }}
          {}.finish();
      }}
      criterion_group!({}_bench, {});
      criterion_main!({}_bench);
    ]],
      {
        ls.i(1),
        ls.i(2, { "vector" }),
        ls.i(3, { "group" }),
        rep(1), -- benchmark_group("{}_group")
        ls.i(4, { "size" }), -- for {}
        rep(2), -- in {}.iter()
        rep(3), -- {}.throughput()
        rep(4), -- *{} as u64
        rep(4), -- {}.bench_with_input
        rep(4), -- from_parameter({})
        rep(4), -- , {},
        rep(4), -- &{}
        ls.i(0),
        rep(3), -- {}.finish()
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),

  ls.s(
    { trig = "clapgroup", name = "Scaffold a clap argument setup with groups" },
    fmt(
      [[
      command!()
        .group(ArgGroup::new("{}").multiple(true))
        .next_help_heading("{}")
        .args([
            arg!(--{} "{}").group("{}"),
        ])
      ]],
      {
        ls.i(1, { "group name" }),
        rep(1),
        ls.i(2, { "arg" }),
        ls.i(3, { "description" }),
        rep(1),
      }
    )
  ),

  ls.s(
    { trig = "clapsub", name = "Scaffold a clap argument setup with sub-commands" },
    fmt(
      [[
      let cmd = clap::Command::new("{}")
          .bin_name("{}")
          .subcommand_required(true)
          .subcommand(
              clap::command!("{}").arg(
                  clap::arg!(--"{}" {})
                      .value_parser(clap::value_parser!({})),
              ),
          );
      let matches = cmd.get_matches();
      let matches = match matches.subcommand() {{
          Some(("{}", matches)) => matches,
          _ => {},
      }};
      let manifest_path = matches.get_one::<std::path::PathBuf>("{}");
    ]],
      {
        ls.i(1, { "binary name" }), -- clap::Command::new("{}")
        rep(1), -- bin_name("{}")
        ls.i(2, { "command name" }), -- clap::command!("{}")
        ls.i(3, { "argument" }), -- clap::command!("{}").arg(
        ls.i(4, { "argument" }), -- clap::arg!(--"{*}" {})
        ls.i(5, { "description" }), -- clap::arg!(--"{}" {*})
        rep(2), -- Some(("{}", matches)) => matches,
        ls.i(0, { "todo!()" }),
        rep(3),
      }
    )
  ),

  ls.s(
    { trig = "structopt", name = "StructOpt", dscr = "Create a StructOpt struct" },
    fmt(
      [[
      /// {desc}
      #[derive({derive})]
      #[structopt({opts})]
      struct Opt {{
          {finally}
      }}
      ]],
      {
        desc = ls.i(1, { "Description" }),
        derive = ls.c(2, {
          ls.t("StructOpt, Debug"),
          ls.t("StructOpt"),
        }),
        opts = ls.c(3, {
          ls.sn(
            nil,
            fmt([[name = "{name}", about = "{about}"]], {
              name = ls.i(1, "Name"),
              about = ls.i(2, "About"),
            })
          ),
          ls.sn(
            nil,
            fmt([[name = "{name}"]], {
              name = ls.i(1, "Name"),
            })
          ),
        }),
        finally = ls.i(0),
      }
    )
  ),

  ls.s(
    { trig = "optvar", name = "StructOpt Variable", dscr = "Create a StructOpt struct variable" },
    fmt(
      [[
      /// {desc}
      #[structopt({opts})]
      {name}: {type},
      ]],
      {
        opts = ls.c(1, {
          ls.t("short, long"),
          ls.t([[short = "", long = ""]]), -- FIXME!
          ls.t([[short = "", long = "", env]]), -- FIXME!
          ls.t([[ short, long, default_value = ""]]),
          ls.t([[ short, long, env, default_value = ""]]),
        }),
        name = ls.i(2, { "name" }),
        type = ls.i(3, { "type" }),
        desc = ls.i(0),
      }
    )
  ),
}
-- vim: fdm=marker fdl=0
```
### all
```lua fold file:all.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/all.lua
-- Requires {{{
local ls = require("luasnip")
local util = require("plugins.luasnip.util")
local partial = require("luasnip.extras").partial
--}}}

local function generate_lorem(lines) --{{{
  local ret = {}
  for i = 1, lines + 1, 1 do
    table.insert(
      ret,
      ls.f(function()
        return vim.fn.systemlist("lorem", { "-lines", i })
      end)
    )
  end
  return ret
end --}}}

return {
  -- System {{{
  ls.s("time", partial(vim.fn.strftime, "%H:%M:%S")),
  ls.s("date", partial(vim.fn.strftime, "%Y-%m-%d")),
  ls.s("pwd", { partial(util.shell, "pwd") }),
  ls.s({ trig = "uuid", wordTrig = true }, { ls.f(util.uuid), ls.i(0) }),
  ls.s({ trig = "rstr(%d+)", regTrig = true }, {
    ls.f(function(_, snip)
      return util.random_string(snip.captures[1])
    end),
    ls.i(0),
  }),
  --}}}

  -- Lorem Ipsum {{{
  ls.s(
    { trig = "lorem", name = "Lorem Ipsum (Choice)", dscr = "Choose next for more lines" },
    ls.c(1, generate_lorem(20))
  ),
  ls.s(
    {
      trig = "lorem(%d+)",
      name = "Lorem Ipsum",
      regTrig = true,
      dscr = "Give it a count for more lines",
    },
    ls.f(function(_, snip)
      local lines = snip.captures[1]
      if not tonumber(lines) then
        lines = 1
      end
      return vim.fn.systemlist("lorem -lines " .. lines)
    end)
  ),
  --}}}

  -- Misc {{{
  ls.s("shrug", { ls.t("¯\\_(ツ)_/¯") }),
  ls.s("angry", { ls.t("(╯°□°）╯︵ ┻━┻") }),
  ls.s("happy", { ls.t("ヽ(´▽`)/") }),
  ls.s("sad", { ls.t("(－‸ლ)") }),
  ls.s("confused", { ls.t("(｡･ω･｡)") }),
  --}}}
}

-- vim: fdm=marker fdl=0
```
### gitcommit
```lua fold file:gitcommit.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/gitcommit.lua
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local function make(trig, name)
  return ls.s(
    trig,
    fmt("{} {}\n\n{}", {
      ls.c(1, {
        ls.sn(nil, fmt("{}({}):", { ls.t(name), ls.i(1, "scope") })),
        ls.t(name .. ":"),
      }),
      ls.i(2, "title"),
      ls.i(0),
    })
  )
end

return {
  make("ref", "ref"),
  make("rev", "revert"),
  make("add", "add"),
  make("break", "breaking"),
  make("fix", "fix"),
  make("refac", "refactor"),
  make("chore", "chore"),
  make("docs", "docs"),
  make("chore", "chore"),
  make("chore", "chore"),
  make("ci", "ci"),
}
```
### go
```lua fold file:go.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/go.lua
-- Requires {{{
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local util = require("plugins.luasnip.util")
local ai = require("luasnip.nodes.absolute_indexer")
local partial = require("luasnip.extras").partial
--}}}

-- Conditions {{{
local function not_in_function()
  return not util.is_in_function()
end

local in_test_func = {
  show_condition = util.is_in_test_function,
  condition = util.is_in_test_function,
}

local in_test_file = {
  show_condition = util.is_in_test_file,
  condition = util.is_in_test_file,
}

local in_func = {
  show_condition = util.is_in_function,
  condition = util.is_in_function,
}

local not_in_func = {
  show_condition = not_in_function,
  condition = not_in_function,
}
--}}}

-- stylua: ignore start
return {
  -- Main {{{
  ls.s(
    { trig = "main", name = "Main", dscr = "Create a main function" },
    fmta("func main() {\n\t<>\n}", ls.i(0)),
    not_in_func
  ), --}}}

  -- If call error {{{
  ls.s(
    { trig = "ifcall", name = "IF CALL", dscr = "Call a function and check the error" },
    fmt(
      [[
        {val}, {err1} := {func}({args})
        if {err2} != nil {{
          return {err3}
        }}
        {finally}
      ]], {
        val     = ls.i(1, { "val" }),
        err1    = ls.i(2, { "err" }),
        func    = ls.i(3, { "Func" }),
        args    = ls.i(4),
        err2    = rep(2),
        err3    = ls.d(5, util.make_return_nodes, { 2 }),
        finally = ls.i(0),
    }),
    in_func
  ), --}}}

  -- Function {{{
  ls.s(
    { trig = "fn", name = "Function", dscr = "Create a function or a method" },
    fmt(
      [[
        // {name1} {desc}
        func {rec}{name2}({args}) {ret} {{
          {finally}
        }}
      ]], {
        name1 = rep(2),
        desc  = ls.i(5, "description"),
        rec   = ls.c(1, {
          ls.t(""),
          ls.sn(nil, fmt("({} {}) ", {
            ls.i(1, "r"),
            ls.i(2, "receiver"),
          })),
        }),
        name2 = ls.i(2, "Name"),
        args  = ls.i(3),
        ret   = ls.c(4, {
          ls.i(1, "error"),
          ls.sn(nil, fmt("({}, {}) ", {
            ls.i(1, "ret"),
            ls.i(2, "error"),
          })),
        }),
        finally = ls.i(0),
    }),
    not_in_func
  ), --}}}

  -- If error {{{
  ls.s(
    { trig = "ife", name = "If error", dscr = "If error, return wrapped" },
    fmt("if {} != nil {{\n\treturn {}\n}}\n{}", {
      ls.i(1, "err"),
      ls.d(2, util.make_return_nodes, { 1 }, { user_args = { { "a1", "a2" } } }),
      ls.i(0),
    }),
    in_func
  ), --}}}

  -- Defer Recover {{{
  ls.s(
    { trig = "refrec", name = "Defer Recover", dscr = "Defer Recover" },
    fmta(
      [[
        defer func() {{
          if e := recover(); e != nil {{
            fmt.Printf("Panic: %v\n%v\n", e, string(debug.Stack()))
          }}
        }}()
      ]]
    , {}),
    in_func
  ), --}}}

  -- gRPC Error{{{
  ls.s(
    { trig = "gerr", dscr = "Return an instrumented gRPC error" },
    fmt('internal.GrpcError({},\n\tcodes.{}, "{}", "{}", {})', {
      ls.i(1, "err"),
      ls.i(2, "Internal"),
      ls.i(3, "Description"),
      ls.i(4, "Field"),
      ls.i(5, "fields"),
    }),
    in_func
  ), --}}}

  -- Mockery {{{
  ls.s(
    { trig = "mockery", name = "Mockery", dscr = "Create an interface for making mocks" },
    fmt(
      [[
        // {} mocks {} interface for testing purposes.
        //go:generate mockery --name {} --filename {}_mock.go
        type {} interface {{
          {}
        }}
      ]], {
        rep(1),
        rep(2),
        rep(1),
        ls.f(function(args) return util.snake_case(args[1][1]) end, { 1 }),
        ls.i(1, "Client"),
        ls.i(2, "pkg.Interface"),
    })
  ), --}}}

  -- Nolint {{{
  ls.s(
    { trig = "nolint", dscr = "ignore linter" },
    fmt([[// nolint:{} // {}]], {
      ls.i(1, "names"),
      ls.i(2, "explaination"),
    })
  ), --}}}

  -- Allocate Slices and Maps {{{
  ls.s(
    { trig = "make", name = "Make", dscr = "Allocate map or slice" },
    fmt("{} {}= make({})\n{}", {
      ls.i(1, "name"),
      ls.i(2),
      ls.c(3, {
        fmt("[]{}, {}", { ls.r(1, "type"), ls.i(2, "len") }),
        fmt("[]{}, 0, {}", { ls.r(1, "type"), ls.i(2, "len") }),
        fmt("map[{}]{}, {}", { ls.r(1, "type"), ls.i(2, "values"), ls.i(3, "len") }),
      }, {
        stored = { -- FIXME: the default value is not set.
          type = ls.i(1, "type"),
        },
      }),
      ls.i(0),
    }),
    in_func
  ), --}}}

  -- Test Cases {{{
  ls.s(
    { trig = "tcs", dscr = "create test cases for testing" },
    fmta(
      [[
        tcs := map[string]struct {
        	<>
        } {
        	// Test cases here
        }
        for name, tc := range tcs {
        	tc := tc
        	t.Run(name, func(t *testing.T) {
        		<>
        	})
        }
      ]],
      { ls.i(1), ls.i(2) }
    ),
    in_test_func
  ), --}}}

  -- Go CMP {{{
  ls.s(
    { trig = "gocmp", dscr = "Create an if block comparing with cmp.Diff" },
    fmt(
      [[
        if diff := cmp.Diff({}, {}); diff != "" {{
        	t.Errorf("(-want +got):\\n%s", diff)
        }}
      ]], {
        ls.i(1, "want"),
        ls.i(2, "got"),
    }),
    in_test_func
  ), --}}}

  -- Create Mocks {{{
  ls.s(
    { trig = "mock", name = "Mocks", dscr = "Create a mock with defering assertion" },
    fmt("{} := &mocks.{}{{}}\ndefer {}.AssertExpectations(t)\n{}", {
      ls.i(1, "m"),
      ls.i(2, "Mocked"),
      rep(1),
      ls.i(0),
    }),
    in_test_func
  ), --}}}

  -- Require NoError {{{
  ls.s(
    { trig = "noerr", name = "Require No Error", dscr = "Add a require.NoError call" },
    ls.c(1, {
      ls.sn(nil, fmt("require.NoError(t, {})", { ls.i(1, "err") })),
      ls.sn(nil, fmt('require.NoError(t, {}, "{}")', { ls.i(1, "err"), ls.i(2) })),
      ls.sn(nil, fmt('require.NoErrorf(t, {}, "{}", {})', { ls.i(1, "err"), ls.i(2), ls.i(3) })),
    }),
    in_test_func
  ), --}}}

  -- Subtests {{{
  ls.s(
    { trig = "Test", name = "Test/Subtest", dscr = "Create subtests and their function stubs" },
    fmta("func <>(t *testing.T) {\n<>\n}\n\n <>", {
      ls.i(1),
      ls.d(2, util.create_t_run, ai({ 1 })),
      ls.d(3, util.mirror_t_run_funcs, ai({ 2 })),
    }),
    in_test_file
  ), --}}}

  -- Stringer {{{
  ls.s(
    { trig = "strigner", name = "Stringer", dscr = "Create a stringer go:generate" },
    fmt("//go:generate stringer -type={} -output={}_string.go", {
      ls.i(1, "Type"),
      partial(vim.fn.expand, "%:t:r"),
    })
  ), --}}}

  -- Query Database {{{
  ls.s(
    { trig = "queryrows", name = "Query Rows", dscr = "Query rows from database" },
    fmta(
      [[
      const <query1> = `<query2>`
      <ret1> := make([]<type1>, 0, <cap>)

      <err1> := <retrier>.Do(func() error {
      	<rows1>, <err2> := <db>.Query(<ctx>, <query3>, <args>)
      	if errors.Is(<err3>, pgx.ErrNoRows) {
      		return &retry.StopError{Err: <err4>}
      	}
      	if <err5> != nil {
      		return <err6>
      	}
      	defer <rows2>.Close()

      	<ret2> = <ret3>[:0]
      	for <rows3>.Next() {
      		var <doc1> <type2>
      		<err7> := <rows4>.Scan(&<vals>)
      		if <err8> != nil {
      			return <err9>
      		}

      		<last>
      		<ret4> = append(<ret5>, <doc2>)
      	}

        if <err10> != nil {
          return <err11>
        }
        return nil
      })

      if <err12> != nil {
        return nil, <err13>
      }
      return <ret6>, nil
      ]], {
        query1  = ls.i(1, "query"),
        query2  = ls.i(2, "SELECT 1"),
        ret1    = ls.i(3, "ret"),
        type1   = ls.i(4, "Type"),
        cap     = ls.i(5, "cap"),
        err1    = ls.i(6, "err"),
        retrier = ls.i(7, "retrier"),
        rows1   = ls.i(8, "rows"),
        err2    = ls.i(9, "err"),
        db      = ls.i(10, "db"),
        ctx     = ls.i(11, "ctx"),
        query3  = rep(1),
        args    = ls.i(12, "args"),
        err3    = rep(9),
        err4    = rep(9),
        err5    = rep(9),
        err6    = ls.d(13, util.go_err_snippet, { 9 }, { user_args = { { "making query" } } }),
        rows2   = rep(8),
        ret2    = rep(3),
        ret3    = rep(3),
        rows3   = rep(8),
        doc1    = ls.i(14, "doc"),
        type2   = rep(4),
        err7    = ls.i(15, "err"),
        rows4   = rep(8),
        vals    = ls.d(16, function(args) return ls.sn(nil, ls.i(1, args[1][1])) end, { 14 }),
        err8    = rep(15),
        err9    = ls.d(17, util.go_err_snippet, { 15 }, { user_args = { { "scanning row" } } }),
        last    = ls.i(0),
        ret4    = rep(3),
        ret5    = rep(3),
        doc2    = rep(14),
        err10   = rep(15),
        err11   = ls.d(18, util.go_err_snippet, { 8 }, { user_args = { { "iterating rows", ".Err()" } } }),
        err12   = rep(15),
        ret6    = rep(3),
        err13   = ls.d(19, util.go_err_snippet, { 6 }, { user_args = { { "error in row iteration" } } }),
      }
    )
  ),
  -- }}}
}
-- stylua: ignore end

-- vim: fdm=marker fdl=0
```
### markdown
```lua fold file:markdown.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/markdown.lua
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

return {
  ls.s( -- Link {{{
    {
      trig = "link",
      name = "markdown_link",
      dscr = "Create markdown link [txt](url).\nSelect link, press C-s, type link.",
    },
    fmt("[{}]({})\n{}", {
      ls.i(1),
      ls.f(function(_, snip)
        return snip.env.TM_SELECTED_TEXT[1] or {}
      end, {}),
      ls.i(0),
    })
  ), --}}}

  ls.s( -- Codeblock {{{
    {
      trig = "codeblock",
      name = "Make code block",
      dscr = "Select text, press <C-s>, type codeblock.",
    },
    fmt("```{}\n{}\n```\n{}", {
      ls.i(1, "Language"),
      ls.f(function(_, snip)
        local tmp = snip.env.TM_SELECTED_TEXT
        tmp[0] = nil
        return tmp or {}
      end, {}),
      ls.i(0),
    })
  ), --}}}
}

-- vim: fdm=marker fdl=0
```
### util
```lua fold file:util.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/util.lua
-- Requires {{{
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local ts_utils = require("nvim-treesitter.ts_utils")
local ts_locals = require("nvim-treesitter.locals")
local rep = require("luasnip.extras").rep
local ai = require("luasnip.nodes.absolute_indexer")
--}}}

local M = {}

---Returns a choice node for errors.
-- @param choice_index integer
-- @param err_name string
M.go_err_snippet = function(args, _, _, spec)
  local err_name = args[1][1]
  local index = spec and spec.index or nil
  local msg = spec and spec[1] or ""
  if spec and spec[2] then
    err_name = err_name .. spec[2]
  end
  return ls.sn(index, {
    ls.c(1, {
      ls.sn(nil, fmt('fmt.Errorf("{}: %w", {})', { ls.i(1, msg), ls.t(err_name) })),
      -- ls.sn(nil, fmt('fmt.Errorf("{}", {}, {})', { ls.t(err_name), ls.i(1, msg), ls.i(2) })),
      ls.sn(
        nil,
        fmt('internal.GrpcError({},\n\t\tcodes.{}, "{}", "{}", {})', {
          ls.t(err_name),
          ls.i(1, "Internal"),
          ls.i(2, "Description"),
          ls.i(3, "Field"),
          ls.i(4, "fields"),
        })
      ),
      ls.t(err_name),
    }),
  })
end

---Transform makes a node from the given text.
local function transform(text, info) --{{{
  local string_sn = function(template, default)
    info.index = info.index + 1
    return ls.sn(info.index, fmt(template, ls.i(1, default)))
  end
  local new_sn = function(default)
    return string_sn("{}", default)
  end

  -- cutting the name if exists.
  if text:find([[^[^\[]*string$]]) then
    text = "string"
  elseif text:find("^[^%[]*map%[[^%]]+") then
    text = "map"
  elseif text:find("%[%]") then
    text = "slice"
  elseif text:find([[ ?chan +[%a%d]+]]) then
    return ls.t("nil")
  end

  -- separating the type from the name if exists.
  local type = text:match([[^[%a%d]+ ([%a%d]+)$]])
  if type then
    text = type
  end

  if text == "int" or text == "int64" or text == "int32" then
    return new_sn("0")
  elseif text == "float32" or text == "float64" then
    return new_sn("0")
  elseif text == "error" then
    if not info then
      return ls.t("err")
    end

    info.index = info.index + 1
    return M.go_err_snippet({ { info.err_name } }, nil, nil, { index = info.index })
  elseif text == "bool" then
    info.index = info.index + 1
    return ls.c(info.index, { ls.i(1, "false"), ls.i(2, "true") })
  elseif text == "string" then
    return string_sn('"{}"', "")
  elseif text == "map" or text == "slice" then
    return ls.t("nil")
  elseif string.find(text, "*", 1, true) then
    return new_sn("nil")
  end

  text = text:match("[^ ]+$")
  if text == "context.Context" then
    text = "context.Background()"
  else
    -- when the type is concrete
    text = text .. "{}"
  end

  return ls.t(text)
end --}}}

local get_node_text = vim.treesitter.get_node_text
local handlers = { --{{{
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
      if idx ~= count - 1 then
        table.insert(result, ls.t({ ", " }))
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
} --}}}

local function return_value_nodes(info) --{{{
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope_tree = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, scope in ipairs(scope_tree) do
    if
      scope:type() == "function_declaration"
      or scope:type() == "method_declaration"
      or scope:type() == "func_literal"
    then
      function_node = scope
      break
    end
  end

  if not function_node then
    return
  end

  local query = vim.treesitter.query.get("go", "luasnip")
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
  return ls.t({ "" })
end --}}}

---Transforms the given arguments into nodes wrapped in a snippet node.
M.make_return_nodes = function(args) --{{{
  local info = { index = 0, err_name = args[1][1] }
  return ls.sn(nil, return_value_nodes(info))
end --}}}

---Runs the command in shell.
-- @param command string
-- @return table
M.shell = function(command) --{{{
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end --}}}

M.last_lua_module_section = function(args) --{{{
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })

  local options = {}
  for len = 0, #split - 1 do
    local node = ls.t(table.concat(vim.list_slice(split, #split - len, #split), "_"))
    table.insert(options, node)
  end

  return ls.sn(nil, {
    ls.c(1, options),
  })
end --}}}

---Returns true if the cursor in a function body.
-- @return boolean
function M.is_in_function() --{{{
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return false
  end
  local expr = current_node

  while expr do
    if expr:type() == "function_declaration" or expr:type() == "method_declaration" then
      return true
    end
    expr = expr:parent()
  end
  return false
end --}}}

---Returns true if the cursor in a test file.
-- @return boolean
function M.is_in_test_file() --{{{
  local filename = vim.fn.expand("%:p")
  return vim.endswith(filename, "_test.go")
end --}}}

---Returns true if the cursor in a function body in a test file.
-- @return boolean
function M.is_in_test_function() --{{{
  return M.is_in_test_file() and M.is_in_function()
end --}}}

math.randomseed(os.time())
M.uuid = function() --{{{
  local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  local out
  local function subs(c)
    local v = (((c == "x") and math.random(0, 15)) or math.random(8, 11))
    return string.format("%x", v)
  end
  out = template:gsub("[xy]", subs)
  return out
end --}}}

local charset = {} -- Random String {{{
for i = 48, 57 do
  table.insert(charset, string.char(i))
end
for i = 65, 90 do
  table.insert(charset, string.char(i))
end
for i = 97, 122 do
  table.insert(charset, string.char(i))
end
M.random_string = function(length)
  if length == 0 then
    return ""
  end
  return M.random_string(length - 1) .. charset[math.random(1, #charset)]
end --}}}

M.snake_case = function(titlecase) --{{{
  -- lowercase the first letter otherwise it causes the result to start with an
  -- underscore.
  titlecase = string.lower(string.sub(titlecase, 1, 1)) .. string.sub(titlecase, 2)
  return titlecase:gsub("%u", function(c)
    return "_" .. c:lower()
  end)
end --}}}

M.create_t_run = function(args) --{{{
  return ls.sn(1, {
    ls.c(1, {
      ls.t({ "" }),
      ls.sn(
        nil,
        fmt('\tt.Run("{}", {}{})\n{}', {
          ls.i(1, "Case"),
          ls.t(args[1]),
          rep(1),
          ls.d(2, M.create_t_run, ai[1]),
        })
      ),
    }),
  })
end --}}}

M.mirror_t_run_funcs = function(args) --{{{
  local strs = {}
  for _, v in ipairs(args[1]) do
    local name = v:match('^%s*t%.Run%s*%(%s*".*", (.*)%)')
    if name then
      local node = string.format("func %s(t *testing.T) {{\n\tt.Parallel()\n}}\n\n", name)
      table.insert(strs, node)
    end
  end
  local str = table.concat(strs, "")
  if #str == 0 then
    return ls.sn(1, ls.t(""))
  end
  return ls.sn(1, fmt(str, {}))
end --}}}

return M

-- vim: fdm=marker fdl=0
```
### init
```lua fold file:init.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/luasnip/init.lua
local function config()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")

  ls.add_snippets("all", require("plugins.luasnip.all"))
  ls.add_snippets("go", require("plugins.luasnip.go"))
  ls.add_snippets("lua", require("plugins.luasnip.lua"))
  ls.add_snippets("gitcommit", require("plugins.luasnip.gitcommit"))
  ls.add_snippets("markdown", require("plugins.luasnip.markdown"))
  ls.add_snippets("rust", require("plugins.luasnip.rust"))

  ls.config.set_config({ --{{{
    store_selection_keys = "<c-s>",
    updateevents = "TextChanged,TextChangedI",
    ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,

    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { " ", "TSTextReference" } },
        },
      },
      [types.insertNode] = {
        active = {
          virt_text = { { " ", "TSEmphasis" } },
        },
      },
    },
  }) --}}}
end

return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        vim.schedule(function()
          require("luasnip.loaders.from_vscode").load()
        end)
      end,
      enabled = require("config.util").is_enabled("rafamadriz/friendly-snippets"),
    },
  },
  -- stylua: ignore
  keys = {
    { mode = { "i", "s" }, "<C-l>", function()
        local ls = require("luasnip")
        if ls.choice_active() then ls.change_choice(1) end
      end,
    },
    { mode = { "i", "s" }, "<C-h>", function()
        local ls = require("luasnip")
        if ls.choice_active() then ls.change_choice(-1) end
      end,
    },
  },
  config = config,
  lazy = true,
  enabled = require("config.util").is_enabled("L3MON4D3/LuaSnip"),
}

-- vim: fdm=marker fdl=0
```

## 📁dap
Dap is debugger adapter protocol, used for programming languages to test the code.
### init
```lua fold file:init.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/dap/init.lua
local M = {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "jbyuki/one-small-step-for-vimkind" },
      { "jay-babu/mason-nvim-dap.nvim" },
      { "LiadOz/nvim-dap-repl-highlights", opts = {} },
    },
  -- stylua: ignore
  keys = {
    { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
    { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
    { "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
    { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI", },
    { "<leader>db", function() require("dap").step_back() end, desc = "Step Back", },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
    { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
    { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Evaluate", },
    { "<leader>dg", function() require("dap").session() end, desc = "Get Session", },
    { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables", },
    { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over", },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>dp", function() require("dap").pause.toggle() end, desc = "Pause", },
    { "<leader>dq", function() require("dap").close() end, desc = "Quit", },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
    { "<leader>ds", function() require("dap").continue() end, desc = "Start", },
    { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
    { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
    { "<leader>du", function() require("dap").step_out() end, desc = "Step Out", },
  },
    opts = {},
    config = function(plugin, opts)
      local icons = require "config.icons"
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] })
      end

      require("nvim-dap-virtual-text").setup {
        commented = true,
      }

      local dap, dapui = require "dap", require "dapui"
      dapui.setup {}

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- set up debugger
      for k, _ in pairs(opts.setup) do
        opts.setup[k](plugin, opts)
      end
    end,
  },
  --TODO: to configure
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {},
    },
  },
}

return M

```
### lua
```lua fold file:lua.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/dap/lua.lua
local M = {}

function M.setup()
  local dap = require "dap"
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = function()
        local value = vim.fn.input "Host [127.0.0.1]: "
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input("Port: ", "8086"))
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host, port = config.port }
  end
end

return M

```
### python
```lua fold file:python.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/dap/python.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
      setup = {
        pyright = function(_, opts)
          local lsp_utils = require "plugins.lsp.utils"
          lsp_utils.on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "pyright" then
              vim.keymap.set("n", "<leader>tC", function() require("dap-python").test_class() end, { buffer = buffer, desc = "Debug Class" })
              vim.keymap.set("n", "<leader>tM", function() require("dap-python").test_method() end, { buffer = buffer, desc = "Debug Method" })
              vim.keymap.set("v", "<leader>tS", function() require("dap-python").debug_selection() end, { buffer = buffer, desc = "Debug Selection" })
            end
          end)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mfussenegger/nvim-dap-python" },
    opts = {
      setup = {
        debugpy = function(_, _)
          require("dap-python").setup("python", {})
          table.insert(require("dap").configurations.python, {
            type = "python",
            request = "attach",
            connect = {
              port = 5678,
              host = "127.0.0.1",
            },
            mode = "remote",
            name = "container attach debug",
            cwd = vim.fn.getcwd(),
            pathmappings = {
              {
                localroot = function()
                  return vim.fn.input("local code folder > ", vim.fn.getcwd(), "file")
                end,
                remoteroot = function()
                  return vim.fn.input("container code folder > ", "/", "file")
                end,
              },
            },
          })
        end,
      },
    },
  },
}
```
##  📁dashboard
Starting dashboard with the shortcuts and logo.
### init
```lua fold file:init.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/dashboard/init.lua
return {
  "goolord/alpha-nvim",
  lazy = false,
  config = function()
    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.header.val = require("plugins.dashboard.logo")["random"]
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      dashboard.button("s", "🌘" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.footer.opts.hl = "Constant"
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.opts.layout[1].val = 0

    if vim.o.filetype == "lazy" then
      -- close and re-open Lazy after showing alpha
      vim.notify("Missing plugins installed!", vim.log.levels.INFO, { title = "lazy.nvim" })
      vim.cmd.close()
      require("alpha").setup(dashboard.opts)
      require("lazy").show()
    else
      require("alpha").setup(dashboard.opts)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        -- local now = os.date "%d-%m-%Y %H:%M:%S"
        local version = "   v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        local fortune = require "alpha.fortune"
        local quote = table.concat(fortune(), "\n")
        local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        local footer = "\t" .. version .. "\t" .. plugins .. "\n" .. quote
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
```

### logo
```lua fold file:logo.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/dashboard/logo.lua
return setmetatable({
  {
    [[                      ***********************                          ]],
    [[                 *********************************                     ]],
    [[             *******   *     *       *    *    *******                 ]],
    [[          *******   ***      **     **     ***   *******               ]],
    [[        ******   *****       *********      *****    *****             ]],
    [[      ******  ********       *********       ******    *****           ]],
    [[     ****   **********       *********       *********   *****         ]],
    [[    ****  **************    ***********     ************   ****        ]],
    [[   ****  *************************************************  ****       ]],
    [[  ****  ***************************************************  ****      ]],
    [[  ****  ****************************************************  ****     ]],
    [[  ****  ****************************************************  ****     ]],
    [[   ****  ***************************************************  ****     ]],
    [[    ****  *******     ****  ***********  ****     *********  ****      ]],
    [[     ****   *****      *      *******      *      ********  ****       ]],
    [[      *****   ****             *****             ******   *****        ]],
    [[        *****   **              ***              **    ******          ]],
    [[         ******   *              *              *   *******            ]],
    [[           *******                                *******              ]],
    [[              ********                         *******                 ]],
    [[                 *********************************                     ]],
    [[                      ***********************                          ]],
  },
  {
    "                                   ",
    "                                   ",
    "                                   ",
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    "                                   ",
  },
  {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⢀⢄⠀⠀⡴⠁⠈⡆⠀⢀⡤⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠢⣄⠀⠀⡇⠀⡕⠀⢸⠀⢠⠃⠀⢮⠀⠹⠀⠀⣠⢾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⣞⠀⢀⠇⠀⡇⠀⡸⠀⠈⣆⠀⡸⠀⢰⠀⠀⡇⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠘⢶⣯⣊⣄⡨⠟⡡⠁⠐⢌⠫⢅⣢⣑⣵⠶⠁⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⣼⣀⠀⢀⠒⠒⠂⠉⠀⠀⠀⠀⠁⠐⠒⠂⡀⠀⣸⣄⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢮⣵⣶⣦⡩⡲⣄⠀⠀⣿⣿⣽⠲⠭⣥⣖⣂⣀⣀⣀⣀⣐⣢⡭⠵⠖⣿⣿⢫⠀⠀⣠⣖⣯⣶⣶⣮⡷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢸⡟⢉⣉⠙⣿⣿⣦⠀⣿⣿⣿⣿⣷⣲⠶⠤⠭⣭⡭⠭⠴⠶⣖⣾⣿⣿⡿⢸⢀⣼⣿⡿⠋⣉⠉⢳⠁⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠮⣳⣴⣫⠂⠘⣿⣿⣇⢷⢻⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣿⣿⣿⣿⣿⢿⢃⡟⣼⣿⣿⠁⠸⣘⣢⣚⠜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠈⢧⢻ ⣿⣿⣟⠻⣿⣿⣿⣿⠛⣩⣿⣿ ⢟⡞⢀⣿⣿⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣒⣒⣦⣄⣿⣿⣿⢀⡬⣟⣯  ⣿⢷⣼⡟⢿⣿⡿⣿⣿  ⡻⣤⡀⣿⣿⣸⡠⢔⣒⡒⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢾⣟⣅⠉⢎⣽⣿⣿⡏⡟⣤⣮⣿⣿  ⡏⣿⠀⠀⣿⢡⣷  ⣿⣟⢎⣷⢻⣿⣿⣾⡟⠉⣽⡇⡇⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⡴⣫⣭⣭⣍⡲⢄⠀⠀⠀⠀⠈⠻⠋⣠⡮⣻⣿⣿⠃⠳⣏⣼⣿⣿⣿⣿⡇⣿⣴⣴⣿⣾⣿⣿⣿⡿⣄⣩⠏⢸⣿⣿⣿⣧⡀⠛⠞⠁⠀⠀⠀⢀⣤⣺⣭⣭⣭⡝⢦⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢸⢹⡟⠁⠀⠉⢫⡳⣵⣄⠀⠀⢀⠴⢊⣿⣾⣿⣿⣿⠀⠀⠀⠻⣬⣽⣿⣿⣿⣿  ⣿⣿⣿⣿⣯⣵⠏⠀⠀⢸⣿⣿⣿⣿⣿⣗⢤⡀⠀⠀⣠⣿⢟⠟⠉⠀⠈⢻⢸⡆⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠘⢏⢧⣤⡀⠀⠀⣇⢻⣿⣆⢔⢕⣵⠟⣏⣿⣿⣿⠋⣵⠚⠄⣾⣿⣿⣿⡿⠟⣛⣛⣛⣛⠻⣿⣿⣿⣿⣧⢰⠓⣏⠻⣿⣿⣿⢹⠻⣿⣿⢦⣸⣿⡏⡾⠀⠀⢠⣤⠎⡼⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠈⠑⠂⠁⠀⠀⣿⠸⣿⢏⢂⣾⠇⠀⣿⣿⣿⡇⡆⠹⢷⣴⣿⡿⠟⠉⣐⡀⠄⣠⡄⡠⣁⡠⠙⠻⢿⣿⣴⡾⠃⢠⢹⣿⣿⢸⠀⢹⣿⣷⢹⣿⢃⡇⠀⠀⠈⠒⠋⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⣿⢀⣿⣿⡀⠀⢫⣿⣿⣷⣙⠒⠀⠄⠐⠂⣼⠾⣵⠾⠟⣛⣛⠺⢷⣮⠷⣢⠐⠂⠀⠀⠒⣣⣾⣿⡿⡎⠀⢠⣿⣿⡄⣿⣸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣟⣿⢸⣿⣿⣷⣄⡈⣾⣿⣿⣿⣿⣿⠻⡷⢺⠃⠠⠁⠈⠋⠀⠀⠉⠁⠙⡀⠘⡗⣾⠿⣿⣿⣿⣿⣿⡿⢀⣴⣿⣿⡿⢃⣯⣽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⡆⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣵⡞⠀⠁⠐⢁⠎⠄⣠⠀⠀⡄⠀⢳⠈⠆⠈⠈⢳⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣸⡷⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣌⠛⢿⣿⣿⣿⣿⣿⣿⠿⠋⣠⣢⠂⠀⢂⠌⠀⠃⠀⠀⠘⠀⢢⡑⠀⠰⣵⡀⠻⢿⣿⣿⣿⣿⣿⣿⡿⠋⣰⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⣤⣭⢛⣻⠿⣿⣷⣶⢞⡟⡁⢀⢄⠎⠀⠀⠀⠀⠀⡀⠁⠀⠳⢠⠀⢈⢿⢳⣶⣾⣿⠿⣟⣛⣅⡴⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠻⠿⠿⡟⢜⠔⡠⢊⠔⠀⡆⠀⡆⠀⠀⢡⢰⢠⠀⢢⠱⣌⢂⠃⢿⠿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢤⣊⡰⠵⢺⠉⠸⠀⢰⢃⠀⠀⠀⠀⠀⠸⢸⠀⠀⡇⡞⡑⠬⢆⣑⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠘⣾⡸⢀⡜⡾⡀⡇⠀⠀⡴⢠⢻⢦⠀⢃⡿⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡎⠀⠱⡡⠐⠀⠠⠃⢢⠋⠀⢧⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢤⡀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  },
  {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⠿⠿⠿⠿⢿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⣾⣿⣿⠀⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⠀⣿⣿⣷⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣾⣿⡿⠟⠛⠉⠉⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠉⠉⠛⠻⢿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⡿⠋⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠃⠀⠀⣠⣶⣾⣿⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⣿⣷⣦⣄⠀⠀⠸⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⢀⣾⣿⡿⠛⠉⠀⣿⣿⡇⠀⠀⣀⣀⠀⠀⠀⠀⠀⣀⣀⠀⠀⢸⣿⣿⠀⠉⠛⢿⣿⣷⡀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣆⢸⣿⣿⠀⠀⠀⠀⣿⣿⡇⠀⢾⣿⣿⡇⠀⠀⠀⢾⣿⣿⡇⠀⢸⣿⣿⠀⠀⠀⠈⣿⣿⡇⣼⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣄⠀⠀⠀⣿⣿⡇⠀⠈⠙⠋⠀⠀⠀⠀⠈⠙⠋⠀⠀⢸⣿⣿⠀⠀⠀⣰⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⣿⣿⣷⣶⣶⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿⣿⣶⣶⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠛⠛⠛⠛⠛⠛⠛⢻⣿⣿⠛⣿⣿⣿⢻⣿⣿⠛⠛⠛⠛⠛⠛⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⠀⣿⣿⣿⢸⣿⣿⠀⠀⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣈⣉⣉⣉⣉⡉⢹⣿⣿⠀⢸⣿⣿⠀⣿⣿⣿⢸⣿⣿⠀⠀⣿⣿⡏⢉⣉⣉⣉⣉⣁⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⠀⢸⣿⣿⠀⣿⣿⣿⢸⣿⣿⠀⠀⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⢸⣿⣿⠀⢸⣿⣿⠀⣿⣿⣿⢸⣿⣿⠀⠀⣿⣿⡇⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⢸⣿⣿⠀⢸⣿⣿⠀⣿⣿⣿⢸⣿⣿⠀⠀⣿⣿⡇⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⢸⣿⣿⣄⣼⣿⣿⠀⣿⣿⣿⠸⣿⣿⣆⣠⣿⣿⡇⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣄⠻⢿⣿⣿⠿⢋⣴⣿⣿⣿⣦⡙⠿⣿⣿⡿⠛⣠⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣷⣶⣤⣴⣶⣿⣿⠿⠙⢿⣿⣿⣶⣦⣴⣶⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⠿⠛⠋⠁⠀⠀⠀⠈⠙⠛⠿⠿⠛⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  },
  {
    [[      `       --._    `-._   `-.   `.     :   /  .'   .-'   _.-'    _.--'                   ]],
    [[        `--.__     `--._   `-._  `-.  `. `. : .' .'  .-'  _.-'   _.--'     __.--'           ]],
    [[           __    `--.__    `--._  `-._ `-. `. :/ .' .-' _.-'  _.--'    __.--'    __         ]],
    [[            `--..__   `--.__   `--._ `-._`-.`_=_'.-'_.-' _.--'   __.--'   __..--'           ]],
    [[          --..__   `--..__  `--.__  `--._`-q(-_-)p-'_.--'  __.--'  __..--'   __..--         ]],
    [[                ``--..__  `--..__ `--.__ `-'_) (_`-' __.--' __..--'  __..--''               ]],
    [[          ...___        ``--..__ `--..__`--/__/  --'__..--' __..--''        ___...          ]],
    [[                ```---...___    ``--..__`_(<_   _/)_'__..--''    ___...---'''               ]],
    [[           ```-----....._____```---...___(____|_/__)___...---'''_____.....-----'''          ]],
  },
  {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  },
  [[
                               _                         
                           ,--.\`-. __                   
                         _,.`. \:/,"  `-._               
                     ,-*" _,.-;-*`-.+"*._ )              
                    ( ,."* ,-" / `.  \.  `.              
                   ,"   ,;"  ,"\../\  \:   \             
                  (   ,"/   / \.,' :   ))  /             
                   \  |/   / \.,'  /  // ,'              
                    \_)\ ,' \.,'  (  / )/                
                        `  \._,'   `"                    
                           \../                          
                           \../                          
                 ~        ~\../           ~~             
          ~~          ~~   \../   ~~   ~      ~~         
     ~~    ~   ~~  __...---\../-...__ ~~~     ~~         
       ~~~~  ~_,--'        \../      `--.__ ~~    ~~     
   ~~~  __,--'              `"             `--.__   ~~~  
~~  ,--'                                         `--.    
   '------......______             ______......------` ~~
 ~~~   ~    ~~      ~ `````---"""""  ~~   ~     ~~       
        ~~~~    ~~  ~~~~       ~~~~~~  ~ ~~   ~~ ~~~  ~  
     ~~   ~   ~~~     ~~~ ~         ~~       ~~   SSt    
              ~        ~~       ~~~       ~              
  ]],
}, {
  __index = function(logos, key)
    if key == "random" then
      math.randomseed(os.time())
      return logos[math.random(1, #logos)]
    end
    return logos[key]
  end,
})

```

## 📁 lsp_new
This is a trial to merge the awesome shark version with mine.
### 📁 config
#### gopls
```lua fold file:gopls.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/config/gopls.lua
return {
  settings = {
    -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    gopls = {
      analyses = {
        unusedparams = true,
        nillness = true,
        unusedwrites = true,
        useany = true,
        unusedvariable = true,
      },
      completeUnimported = true,
      staticcheck = true,
      buildFlags = { "-tags=integration,e2e" },
      linksInHover = true,
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
        run_vulncheck_exp = true,
        upgrade_dependency = true,
      },
      usePlaceholders = true,
      directoryFilters = {
        "-**/node_modules",
        "-/tmp",
      },
      completionDocumentation = true,
      deepCompletion = true,
      semanticTokens = true,
      verboseOutput = false, -- useful for debugging when true.
      matcher = "Fuzzy", -- default
      diagnosticsDelay = "500ms",
      symbolMatcher = "Fuzzy", -- default is FastFuzzy
    },
  },

  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
        },
        contextSupport = true,
        dynamicRegistration = true,
      },
    },
  },

  server_capabilities = {
    semanticTokensProvider = {
      range = true,
    },
  },
}

-- vim: fdm=marker fdl=0
```
#### jsonls
```lua fold file:jsonls.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/config/jsonls.lua
return {
  settings = {
    json = {
      schemas = require("plugins.lsp.config.schemas").jsonls,
    },
  },
}
```
#### lua_ls
```lua fold file:lua_ls.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/config/lua_ls.lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "?.lua")
table.insert(runtime_path, "?/init.lua")

return {
  settings = {
    Lua = {
      runtime = {
        special = {
          req = "require",
        },
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
          "rocks",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        ignoreDir = "tmp/",
        useGitIgnore = false,
        maxPreload = 100000000,
        preloadFileSize = 500000,
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },

  server_capabilities = {
    definition = true,
    typeDefinition = true,
  },
}
```

#### rust_analyzer
```lua fold file:rust_analyzer.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/config/rust_analyzer.lua
return {
  settings = {
    ["rust-analyzer"] = {
      imports = {
        ["granularity.group"] = "module",
        prefix = "self",
      },
      cargo = {
        ["buildScripts.enable"] = true,
      },
      procMacro = {
        enable = true,
      },
      files = {
        excludeDirs = { "target" },
      },
      ["lru.capacity"] = 2048,
      workspace = {
        symbol = {
          ["search.limit"] = 2048,
        },
      },
      diagnostics = {
        enable = true,
        enableExperimental = true,
        experimental = {
          enable = true,
        },
      },

      ["updates.channel"] = "nightly",
      rustfmt = {
        extraArgs = { "--all", "--", "--check" },
      },
      checkOnSave = {
        command = "clippy",
        allFeatures = true,
        features = "all",
        overrideCommand = {
          "cargo",
          "clippy",
          "--workspace",
          "--message-format=json",
          "--all-targets",
          "--all-features",
          "--",
          "-W",
          "correctness",
          "-W",
          "keyword_idents",
          "-W",
          "rust_2021_prelude_collisions",
          "-W",
          "trivial_casts",
          "-W",
          "trivial_numeric_casts",
          "-W",
          "unused_lifetimes",
          "-W",
          "unwrap_used",
        },
      },
    },
  },

  server_capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          -- enable auto-import
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
          snippetSupport = true,
        },
      },
    },
    experimental = {
      commands = {
        commands = {
          "rust-analyzer.runSingle",
          "rust-analyzer.debugSingle",
          "rust-analyzer.showReferences",
          "rust-analyzer.gotoLocation",
          "editor.action.triggerParameterHints",
        },
      },
      hoverActions = true,
      hoverRange = true,
      serverStatusNotification = true,
      snippetTextEdit = true,
      codeActionGroup = true,
      ssr = true,
    },
  },
}

-- vim: fdm=marker fdl=0
```

#### schemas
```lua fold file:schemas.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/config/schemas.lua
---@diagnostics disable
local M = {}
---Find more schemas here: https://www.schemastore.org/json/
M.jsonls = {
  {
    description = "TypeScript compiler configuration file",
    fileMatch = {
      "tsconfig.json",
      "tsconfig.*.json",
    },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "Lerna config",
    fileMatch = { "lerna.json" },
    url = "https://json.schemastore.org/lerna.json",
  },
  {
    description = "Babel configuration",
    fileMatch = {
      ".babelrc.json",
      ".babelrc",
      "babel.config.json",
    },
    url = "https://json.schemastore.org/babelrc.json",
  },
  {
    description = "ESLint config",
    fileMatch = {
      ".eslintrc.json",
      ".eslintrc",
    },
    url = "https://json.schemastore.org/eslintrc.json",
  },
  {
    description = "Bucklescript config",
    fileMatch = { "bsconfig.json" },
    url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
  },
  {
    description = "Prettier config",
    fileMatch = {
      ".prettierrc",
      ".prettierrc.json",
      "prettier.config.json",
    },
    url = "https://json.schemastore.org/prettierrc",
  },
  {
    description = "Vercel Now config",
    fileMatch = { "now.json" },
    url = "https://json.schemastore.org/now",
  },
  {
    description = "Stylelint config",
    fileMatch = {
      ".stylelintrc",
      ".stylelintrc.json",
      "stylelint.config.json",
    },
    url = "https://json.schemastore.org/stylelintrc",
  },
  {
    description = "A JSON schema for the ASP.NET LaunchSettings.json files",
    fileMatch = { "launchsettings.json" },
    url = "https://json.schemastore.org/launchsettings.json",
  },
  {
    description = "Schema for CMake Presets",
    fileMatch = {
      "CMakePresets.json",
      "CMakeUserPresets.json",
    },
    url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
  },
  {
    description = "Configuration file as an alternative for configuring your repository in the settings page.",
    fileMatch = {
      ".codeclimate.json",
    },
    url = "https://json.schemastore.org/codeclimate.json",
  },
  {
    description = "LLVM compilation database",
    fileMatch = {
      "compile_commands.json",
    },
    url = "https://json.schemastore.org/compile-commands.json",
  },
  {
    description = "Config file for Command Task Runner",
    fileMatch = {
      "commands.json",
    },
    url = "https://json.schemastore.org/commands.json",
  },
  {
    description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
    fileMatch = {
      "*.cf.json",
      "cloudformation.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
  },
  {
    description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
    fileMatch = {
      "serverless.template",
      "*.sam.json",
      "sam.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
  },
  {
    description = "Json schema for properties json file for a GitHub Workflow template",
    fileMatch = {
      ".github/workflow-templates/**.properties.json",
    },
    url = "https://json.schemastore.org/github-workflow-template-properties.json",
  },
  {
    description = "golangci-lint configuration file",
    fileMatch = {
      ".golangci.toml",
      ".golangci.json",
    },
    url = "https://json.schemastore.org/golangci-lint.json",
  },
  {
    description = "JSON schema for the JSON Feed format",
    fileMatch = {
      "feed.json",
    },
    url = "https://json.schemastore.org/feed.json",
    versions = {
      ["1"] = "https://json.schemastore.org/feed-1.json",
      ["1.1"] = "https://json.schemastore.org/feed.json",
    },
  },
  {
    description = "Packer template JSON configuration",
    fileMatch = {
      "packer.json",
    },
    url = "https://json.schemastore.org/packer.json",
  },
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
  {
    description = "JSON schema for Visual Studio component configuration files",
    fileMatch = {
      "*.vsconfig",
    },
    url = "https://json.schemastore.org/vsconfig.json",
  },
  {
    description = "Resume json",
    fileMatch = { "resume.json" },
    url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
  },
}

M.yamlls = {
  kubernetes = {
    'templates/*.yaml',
    'helm/*.yaml',
    'kube/*.yaml',
  },
  ['http://json.schemastore.org/golangci-lint.json']      = '.golangci.{yml,yaml}',
  ['http://json.schemastore.org/github-workflow.json']    = '.github/workflows/*.{yml,yaml}',
  ['http://json.schemastore.org/github-action.json']      = '.github/action.{yml,yaml}',
  ['http://json.schemastore.org/ansible-stable-2.9.json'] = 'roles/tasks/*.{yml,yaml}',
  ['http://json.schemastore.org/ansible-playbook.json']   = 'playbook.{yml,yaml}',
  ['http://json.schemastore.org/prettierrc.json']         = '.prettierrc.{yml,yaml}',
  ['http://json.schemastore.org/stylelintrc.json']        = '.stylelintrc.{yml,yaml}',
  ['http://json.schemastore.org/circleciconfig.json']     = '.circleci/**/*.{yml,yaml}',
  ['http://json.schemastore.org/kustomization.json']      = 'kustomization.{yml,yaml}',
  ['http://json.schemastore.org/helmfile.json']           = 'templates/**/*.{yml,yaml}',
  ['http://json.schemastore.org/chart.json']              = 'Chart.yml,yaml}',
  ['http://json.schemastore.org/gitlab-ci.json']          = '/*lab-ci.{yml,yaml}',

  ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "templates/**/*.{yml,yaml}",
}

return M
```

#### yamlls
```lua fold file:yamlls.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/config/yamlls.lua
return {
  settings = {
    yaml = {
      format = { enable = true, singleQuote = true },
      validate = true,
      hover = true,
      completion = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = require("plugins.lsp.config.schemas").yamlls,
    },
  },
}
```

#### init
```lua fold file:init.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/config/init.lua
local function silent_reload() -- {{{
  -- If nvim is started with a file, because this is lazy loaded the server
  -- would not attach. We force read the file to kick-start the server. If all
  -- predicates are negative, then we can safely reload.
  local predicates = {
    function()
      return vim.bo.filetype == ""
    end,
    function()
      local filename = vim.api.nvim_buf_get_name(0)
      return filename:find("fugitive:///")
    end,
    function()
      return vim.bo.filetype == "man"
    end,
  }
  for _, fn in ipairs(predicates) do
    if fn() then
      return
    end
  end
  vim.cmd("silent! e")
end
silent_reload() -- }}}

local popup_window = {
  stylize_markdown = true,
  syntax = "lsp_markdown",
  border = require("config.icons").border_fn("FloatBorder"),
  width = 100,
  height = 10,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_window)
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, popup_window)

require("neodev").setup({})

return function(opts)
  if opts.log_level == nil then
    opts.log_level = "error"
  end
  vim.lsp.set_log_level(opts.log_level)

  if vim.fn.has("nvim-0.10.0") == 0 then
    -- using a function is not supported in old versions.
    opts.diagnostics.virtual_text.prefix = "●"
  end
  vim.diagnostic.config(opts.diagnostics)
end

-- vim: fdm=marker fdl=0
```

### init
```lua fold file:init.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/init.lua
return {
  { -- LSPConfig {{{
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
    },

    enabled = require("config.util").is_enabled("neovim/nvim-lspconfig"),
  }, -- }}}

  { -- Mason {{{
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
    },
    build = ":MasonUpdate",
    config = function()
      local path = require("mason-core.path")
      require("mason").setup({
        install_root_dir = path.concat({ vim.fn.stdpath("cache"), "mason" }),
        max_concurrent_installers = 4,
      })
    end,
    lazy = true,
    enabled = require("config.util").is_enabled("williamboman/mason.nvim"),
  }, -- }}}

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { -- {{{
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "arshlib.nvim",
      "fzfmania.nvim",
      "hrsh7th/cmp-nvim-lsp",
    }, -- }}}

    opts = function(_, opts)
      local defaults = {
        ensure_installed = { -- {{{
          "gopls",
          "rust_analyzer@nightly",
          "jsonls",
          "vimls",
          "yamlls",
          "lua_ls",
          "helm_ls",
          "bashls",
          "bufls",
          "clangd",
          "dockerls",
          "html",
          "jedi_language_server",
          "pyright",
          "sqlls",
          "taplo",
          "tsserver",
        }, -- }}}
        log_level = "error",
        diagnostics = { -- {{{
          signs = false,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
            focusable = true,
            source = "always",
          },
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = function(diagnostic)
              local signs = require("config.icons").lsp.diagnostic.upper_signs
              local severity = vim.diagnostic.severity[diagnostic.severity]
              if signs[severity] then
                return signs[severity]
              end
              return "●"
            end,
          },
        }, -- }}}

        capabilities = { -- {{{
          dynamicRegistration = true,
          textDocument = {
            completion = {
              completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                  properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                  },
                },
              },
              dynamicRegistration = true,
            },
            callHierarchy = {
              dynamicRegistration = true,
            },
            documentSymbol = {
              dynamicRegistration = true,
            },
          },
        }, -- }}}

        server_capabilities = { -- {{{
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
            symbol = {
              dynamicRegistration = true,
            },
          },
          workspaceSymbolProvider = true,
        }, -- }}}

        servers = { -- {{{
          gopls = require("plugins.lsp.config.gopls"),
          rust_analyzer = require("plugins.lsp.config.rust_analyzer"),
          jsonls = require("plugins.lsp.config.jsonls"),
          yamlls = require("plugins.lsp.config.yamlls"),
          lua_ls = require("plugins.lsp.config.lua_ls"),
          clangd = require("plugins.lsp.config.clangd"),
        }, -- }}}
      }
      return vim.tbl_deep_extend("force", defaults, opts)
    end,

    config = function(_, opts) -- {{{
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        automatic_installation = true,
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local conf = opts.servers[server_name] or {}

          local ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
          if ok then
            cmp_caps = cmp_caps.default_capabilities()
          end
          local caps = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_caps or {},
            opts.capabilities or {},
            conf.capabilities or {}
          )
          conf.capabilities = caps

          local pre_attach = function(_, _) end
          if conf.on_attach ~= nil then
            pre_attach = conf.on_attach or function() end
          end
          conf.on_attach = function(client, bufnr)
            client.server_capabilities = vim.tbl_deep_extend(
              "force",
              client.server_capabilities,
              opts.server_capabilities or {},
              conf.server_capabilities or {}
            )
            pre_attach(client, bufnr)
            require("plugins.lsp.on_attach").on_attach(client, bufnr)
          end

          require("lspconfig")[server_name].setup(conf)
        end,
      })
      require("plugins.lsp.config")(opts)
    end, -- }}}
    enabled = require("config.util").is_enabled("williamboman/mason-lspconfig.nvim"),
  },

  { -- Mason Null LS {{{
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    event = { "BufRead", "BufNewFile" },
    opts = {
      ensure_installed = nil,
      automatic_installation = true,
      automatic_setup = false,
    },
    enabled = require("config.util").is_enabled("jay-babu/mason-null-ls.nvim"),
  }, -- }}}

  { -- Null LS {{{
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = function()
      local null_ls = require("null-ls")
      return {
        debug = false,
        sources = {
          -- Formatters run in the shown order.

          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.diagnostics.buf,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.selene,

          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.formatting.buf,
          null_ls.builtins.formatting.cbfmt.with({
            extra_args = { "--config", vim.fn.stdpath("config") .. "/scripts/cbfmt.toml" },
          }),
          null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.prettier.with({
            disabled_filetypes = { "html" },
            extra_args = function(params)
              return params.options
                and params.options.tabSize
                and { "--tab-width", params.options.tabSize }
            end,
          }),
          null_ls.builtins.formatting.rustfmt.with({ extra_args = { "--edition=2021" } }),
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type=Spaces", "--indent-width=2", "--column-width=100" },
          }),
          null_ls.builtins.formatting.uncrustify.with({
            extra_args = function()
              return { "-c", vim.fn.findfile("uncrustify.cfg", ".;"), "--no-backup" }
            end,
          }),
        },
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git"
        ),
        on_attach = require("plugins.lsp.on_attach").on_attach,
      }
    end,

    enabled = require("config.util").is_enabled("jose-elias-alvarez/null-ls.nvim"),
  }, -- }}}

  { -- Mason Tool Installer {{{
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "delve",
          "impl",
          "rustfmt",
          "shellcheck",
        },

        auto_update = false,
      })

      vim.defer_fn(function()
        require("mason-tool-installer").run_on_start()
      end, 2000)
    end,
    enabled = require("config.util").is_enabled("WhoIsSethDaniel/mason-tool-installer.nvim"),
  }, -- }}}
}

-- vim: fdm=marker fdl=0
```
### on_attach
```lua fold file:on_attach.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/on_attach.lua
local lsp_util = require("plugins.lsp.util")

local server_callbacks = {}

---@param client lspclient
local function capability_callbacks(client)
  local name = client.name
  local callbacks = server_callbacks[name]
  if callbacks then
    return callbacks
  end

  callbacks = {}
  if client.supports_method("textDocument/completion") then -- {{{
    table.insert(callbacks, function(_, buf)
      vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end)
  end -- }}}

  if client.supports_method("textDocument/hover") then -- {{{
    table.insert(callbacks, lsp_util.hover)
  end -- }}}

  if client.supports_method("textDocument/definition") then -- {{{
    table.insert(callbacks, lsp_util.goto_definition)
  end -- }}}

  if client.supports_method("textDocument/signatureHelp") then -- {{{
    table.insert(callbacks, lsp_util.signature_help)
  end -- }}}

  -- Contains functions to be run before writing the buffer. The format
  -- function will format the while buffer, and the imports function will
  -- organise imports.
  local imports_hook = function() end
  local format_hook = function() end
  local caps = client.server_capabilities
  if client.supports_method("textDocument/codeAction") then -- {{{
    table.insert(callbacks, lsp_util.code_action)

    -- Either is it set to true, or there is a specified set of
    -- capabilities. Sumneko doesn't support it, but the
    -- client.supports_method returns true.
    local can_organise_imports = type(caps.codeActionProvider) == "table"
      and _t(caps.codeActionProvider.codeActionKinds):contains("source.organizeImports")
    if can_organise_imports then
      table.insert(callbacks, lsp_util.setup_organise_imports)
      imports_hook = lsp_util.lsp_organise_imports
    end
  end -- }}}

  if client.supports_method("textDocument/formatting") then -- {{{
    table.insert(callbacks, lsp_util.document_formatting)
    local disabled_servers = {
      "lua_ls",
      "jsonls",
      "sqls",
      "html",
    }
    format_hook = function()
      vim.lsp.buf.format({
        async = false,
        filter = function(server)
          return not vim.tbl_contains(disabled_servers, server.name)
        end,
      })
    end
  end -- }}}

  if client.supports_method("textDocument/rangeFormatting") then -- {{{
    local disabled_servers = {}
    table.insert(callbacks, function()
      lsp_util.document_range_formatting(disabled_servers)
    end)
  end -- }}}

  -- Setup import format eveents {{{
  table.insert(callbacks, function(cl, bufnr)
    lsp_util.setup_events(cl, imports_hook, format_hook, bufnr)
  end) -- }}}

  local workspace_folder_supported = caps.workspace -- {{{
    and caps.workspace.workspaceFolders
    and caps.workspace.workspaceFolders.supported
  if workspace_folder_supported then
    table.insert(callbacks, lsp_util.workspace_folder_properties)
  end -- }}}

  if client.supports_method("workspace/symbol") then -- {{{
    table.insert(callbacks, lsp_util.workspace_symbol)
  end -- }}}

  if client.supports_method("textDocument/documentSymbol") then -- {{{
    table.insert(callbacks, lsp_util.document_symbol)
  end -- }}}

  if client.supports_method("textDocument/rename") then -- {{{
    table.insert(callbacks, lsp_util.rename)
  end -- }}}

  if client.supports_method("textDocument/references") then -- {{{
    table.insert(callbacks, lsp_util.find_references)
  end -- }}}

  if client.supports_method("textDocument/implementation") then -- {{{
    table.insert(callbacks, lsp_util.implementation)
  end -- }}}

  if client.supports_method("textDocument/typeDefinition") then -- {{{
    table.insert(callbacks, lsp_util.type_definition)
  end -- }}}

  if client.supports_method("textDocument/declaration") then -- {{{
    table.insert(callbacks, lsp_util.declaration)
  end -- }}}

  -- Code lenses {{{
  if
    client.supports_method("textDocument/codeLens") or client.supports_method("codeLens/resolve")
  then
    table.insert(callbacks, lsp_util.code_lens)
  end -- }}}

  -- Code hierarchy {{{
  if
    client.supports_method("textDocument/prepareCallHierarchy")
    or client.supports_method("callHierarchy/incomingCalls")
    or client.supports_method("callHierarchy/outgoingCalls")
  then
    table.insert(callbacks, lsp_util.call_hierarchy)
  end -- }}}

  -- Semantic Tokens {{{
  if client.supports_method("textDocument/semanticTokens") and vim.lsp.semantic_tokens then
    table.insert(callbacks, lsp_util.semantic_tokens)
  end
  -- }}}

  server_callbacks[name] = callbacks
  return callbacks
end

---The function to pass to the LSP's on_attach callback.
---@param client lspclient
---@param bufnr number
local function on_attach(client, bufnr) --{{{
  vim.api.nvim_buf_call(bufnr, function()
    local callbacks = capability_callbacks(client)
    for _, callback in ipairs(callbacks) do
      callback(client, bufnr)
    end

    lsp_util.setup_diagnostics(bufnr)
    lsp_util.support_commands()
  end)
end --}}}

return {
  on_attach = on_attach,
}

-- vim: fdm=marker fdl=0
```
### util
```lua fold file:util.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/util.lua
---@diagnostic disable: duplicate-set-field, param-type-mismatch
local M = {}

local quick = require("arshlib.quick")
local fzf = require("fzf-lua")
local util = require("config.util")
local augroup = require("config.util").augroup

local function nnoremap(key, fn, desc, opts) --{{{
  opts = vim.tbl_extend("force", { buffer = true, silent = true, desc = desc }, opts or {})
  vim.keymap.set("n", key, fn, opts)
end --}}}
local function xnoremap(key, fn, desc, opts) --{{{
  opts = vim.tbl_extend("force", { buffer = true, silent = true, desc = desc }, opts or {})
  vim.keymap.set("x", key, fn, opts)
end --}}}
local function inoremap(key, fn, desc, opts) --{{{
  opts = vim.tbl_extend("force", { buffer = true, silent = true, desc = desc }, opts or {})
  vim.keymap.set("i", key, fn, opts)
end --}}}

function M.setup_diagnostics(bufnr) --{{{
  nnoremap("<localleader>dd", vim.diagnostic.open_float, "show diagnostics")
  nnoremap("<localleader>dq", vim.diagnostic.setqflist, "populate quickfix")
  nnoremap("<localleader>dw", vim.diagnostic.setloclist, "populate local list")

  -- stylua: ignore start
  local next = vim.diagnostic.goto_next
  local prev = vim.diagnostic.goto_prev
  local repeat_ok, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
  if repeat_ok then
    next, prev= ts_repeat_move.make_repeatable_move_pair(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
  end

  nnoremap("]d", function() quick.call_and_centre(next) end, "goto next diagnostic")
  nnoremap("[d", function() quick.call_and_centre(prev) end, "goto previous diagnostic")

  quick.buffer_command("DiagLoc", function() vim.diagnostic.setloclist() end)
  quick.buffer_command("DiagQf",  function() vim.diagnostic.setqflist()  end)

  local ok, diagnostics = pcall(require, "fzf-lua.providers.diagnostic")
  if ok then
    quick.buffer_command("Diagnostics",    function() diagnostics.diagnostics({}) end)
    quick.buffer_command("Diag",           function() diagnostics.diagnostics({}) end)
    quick.buffer_command("DiagnosticsAll", function() diagnostics.all({})         end)
    quick.buffer_command("DiagAll",        function() diagnostics.all({})         end)
  end
  -- stylua: ignore end
  quick.buffer_command("DiagnosticsDisable", function()
    vim.diagnostic.disable(bufnr)
  end)
  quick.buffer_command("DiagnosticsEnable", function()
    vim.diagnostic.enable(bufnr)
  end)
end --}}}

function M.hover() --{{{
  nnoremap("H", vim.lsp.buf.hover, "Show hover")
  inoremap("<M-h>", vim.lsp.buf.hover, "Show hover")
end --}}}

function M.goto_definition() --{{{
  local perform = function()
    fzf.lsp_definitions({ jump_to_single_result = true })
  end
  quick.buffer_command("Definition", perform)
  nnoremap("gd", perform, "Go to definition")
  vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"
end --}}}

function M.signature_help() --{{{
  nnoremap("K", vim.lsp.buf.signature_help, "show signature help")
  inoremap("<M-l>", vim.lsp.buf.signature_help, "show signature help")
end --}}}

function M.lsp_organise_imports() --{{{
  local context = { source = { organizeImports = true } }
  vim.validate({ context = { context, "table", true } })

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local method = "textDocument/codeAction"
  local timeout = 1000 -- ms

  local ok, resp = pcall(vim.lsp.buf_request_sync, 0, method, params, timeout)
  if not ok or not resp then
    return
  end

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    local offset_encoding = client.offset_encoding or "utf-16"
    if client.id and resp[client.id] then
      local result = resp[client.id].result
      if result and result[1] and result[1].edit then
        local edit = result[1].edit
        if edit then
          vim.lsp.util.apply_workspace_edit(result[1].edit, offset_encoding)
        end
      end
    end
  end
end --}}}

---Formats a range if given.
---@param disabled_servers table
---@param range_given boolean
---@param line1 number
---@param line2 number
---@param bang boolean
local function format_command(disabled_servers, range_given, line1, line2, bang) --{{{
  if range_given then
    vim.lsp.buf.format({
      range = {
        start = { line1, 0 },
        ["end"] = { line2, 99999999 },
      },
      filter = function(server)
        return not vim.tbl_contains(disabled_servers, server.name)
      end,
    })
  elseif bang then
    vim.lsp.buf.format({
      async = false,
      filter = function(server)
        return not vim.tbl_contains(disabled_servers, server.name)
      end,
    })
  else
    vim.lsp.buf.format({
      async = true,
      filter = function(server)
        return not vim.tbl_contains(disabled_servers, server.name)
      end,
    })
  end
end --}}}

function M.setup_organise_imports() --{{{
  nnoremap("<localleader>i", M.lsp_organise_imports, "Organise imports")
end --}}}

function M.document_formatting() --{{{
  nnoremap("<localleader>gq", vim.lsp.buf.format, "Format buffer")
end --}}}

local function document_range_formatting(disabled_servers, args) --{{{
  format_command(disabled_servers, args.range ~= 0, args.line1, args.line2, args.bang)
end --}}}

-- selene: allow(global_usage)
local function format_range_operator(disabled_servers) --{{{
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local start = vim.api.nvim_buf_get_mark(0, "[")
    local finish = vim.api.nvim_buf_get_mark(0, "]")
    finish[2] = 99999999
    vim.lsp.buf.format({
      range = {
        start = start,
        ["end"] = finish,
      },
      async = false,
      filter = function(server)
        return not vim.tbl_contains(disabled_servers, server.name)
      end,
    })
    vim.go.operatorfunc = old_func
  end
  vim.go.operatorfunc = "v:lua.op_func_formatting"
  vim.api.nvim_feedkeys("g@", "n", false)
end --}}}

function M.document_range_formatting(disabled_servers) --{{{
  quick.buffer_command("Format", function(args)
    document_range_formatting(disabled_servers, args)
  end, { range = true })
  xnoremap("gq", function()
    local line1, _ = unpack(vim.api.nvim_buf_get_mark(0, "["))
    local line2, _ = unpack(vim.api.nvim_buf_get_mark(0, "]"))
    if line1 > line2 then
      line1, line2 = line2, line1
    end
    document_range_formatting(disabled_servers, { range = 1, line1 = line1, line2 = line2 })
  end, "Format range")
  nnoremap("gq", function()
    format_range_operator(disabled_servers)
  end, "Format range")

  vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:3000})"
end --}}}

local lsp_formatting_imports = augroup("lsp_formatting_imports")
---Setup events for formatting and imports.
---@param client lspclient
---@param imports function
---@param format function
---@param bufnr number?
function M.setup_events(client, imports, format, bufnr) --{{{
  if not util.buffer_has_var("lsp_formatting_imports_" .. client.name) then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = lsp_formatting_imports,
      buffer = bufnr or 0,
      callback = function()
        imports()
        format()
      end,
      desc = "format and imports",
    })
  end
end --}}}

function M.workspace_folder_properties() --{{{
  quick.buffer_command("WorkspaceList", function()
    vim.notify(vim.lsp.buf.list_workspace_folders() or {}, vim.lsp.log_levels.INFO, {
      title = "Workspace Folders",
      timeout = 3000,
    })
  end)

  quick.buffer_command("WorkspaceAdd", function(args)
    vim.lsp.buf.add_workspace_folder(args.args and vim.fn.fnamemodify(args.args, ":p"))
  end, { range = true, nargs = "?", complete = "dir" })

  quick.buffer_command(
    "WorkspaceRemove",
    function(args)
      vim.lsp.buf.remove_workspace_folder(args.args)
    end,
    { range = true, nargs = "?", complete = "customlist,v:lua.vim.lsp.buf.list_workspace_folders" }
  )
end --}}}

function M.workspace_symbol() --{{{
  quick.buffer_command("WorkspaceSymbols", fzf.lsp_live_workspace_symbols)
end --}}}

function M.document_symbol() --{{{
  local perform = function()
    fzf.lsp_document_symbols({
      jump_to_single_result = true,
      fzf_opts = {
        ["--with-nth"] = "2..",
      },
    })
  end
  quick.buffer_command("DocumentSymbol", perform)
  nnoremap("<localleader>@", perform, "Document symbol")
end --}}}

function M.rename() --{{{
  vim.keymap.set("n", "<localleader>rn", function()
    return ":Rename " .. vim.fn.expand("<cword>")
  end, { expr = true })
end --}}}

function M.find_references() --{{{
  local perform = function()
    fzf.lsp_references({ jump_to_single_result = true })
  end
  quick.buffer_command("References", perform)
  nnoremap("gr", perform, "Go to references")
end --}}}

function M.implementation() --{{{
  local perform = function()
    fzf.lsp_implementations({ jump_to_single_result = true })
  end
  quick.buffer_command("Implementation", perform)
  nnoremap("<localleader>gi", perform, "Go to implementation")
end --}}}

function M.type_definition() --{{{
  quick.buffer_command("TypeDefinition", function()
    fzf.lsp_typedefs({ jump_to_single_result = true })
  end)
end --}}}

function M.declaration() --{{{
  nnoremap("gD", function()
    fzf.lsp_declarations({ jump_to_single_result = true })
  end, "Go to declaration")
end --}}}

function M.code_lens() --{{{
  if util.buffer_has_var("code_lens") then
    return
  end
  quick.buffer_command("CodeLensRefresh", vim.lsp.codelens.refresh)
  quick.buffer_command("CodeLensRun", vim.lsp.codelens.run)
  nnoremap("<localleader>cr", vim.lsp.codelens.run, "run code lenses")

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
    group = augroup("code_lenses"),
    callback = vim.lsp.codelens.refresh,
    buffer = 0,
  })
end --}}}

---Runs code actions on a given range.
---@param range_given boolean
---@param line1 number
---@param line2 number
local function code_action(range_given, line1, line2) --{{{
  if range_given then
    vim.lsp.buf.code_action({
      range = {
        start = { line1, 0 },
        ["end"] = { line2, 99999999 },
      },
    })
  else
    vim.lsp.buf.code_action()
  end
end --}}}

function M.code_action() --{{{
  quick.buffer_command("CodeAction", function(args)
    code_action(args.range ~= 0, args.line1, args.line2)
  end, { range = true })
  nnoremap("<localleader>ca", code_action, "Code action")
  xnoremap("<localleader>ca", ":'<,'>CodeAction<CR>", "Code action")
end --}}}

function M.call_hierarchy() --{{{
  quick.buffer_command("Callers", fzf.lsp_incoming_calls)
  nnoremap("<localleader>gc", fzf.lsp_incoming_calls, "show incoming calls")
  quick.buffer_command("Callees", fzf.lsp_outgoing_calls)
end --}}}

function M.support_commands() --{{{
  ---Restats the LSP server. Fixes the problem with the LSP server not
  -- restarting with LspRestart command.
  local function restart_lsp()
    vim.cmd.LspStop()
    vim.defer_fn(function()
      vim.cmd.LspStart()
    end, 1000)
  end
  quick.buffer_command("RestartLsp", restart_lsp)
  nnoremap("<localleader>dr", restart_lsp, "Restart LSP server")

  quick.buffer_command("ListWorkspace", function()
    vim.notify(vim.lsp.buf.list_workspace_folders(), vim.lsp.log_levels.INFO, {
      title = "Workspace Folders",
      timeout = 3000,
    })
  end)
end --}}}

local handler = function(err)
  if err then
    local msg = string.format("Error reloading Rust workspace: %v", err)
    vim.notify(msg, vim.lsp.log_levels.ERROR, {
      title = "Reloading Rust workspace",
      timeout = 3000,
    })
  else
    vim.notify("Workspace has been reloaded")
  end
end

local function reload_rust_workspace()
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == "rust_analyzer" then
      client.request("rust-analyzer/reloadWorkspace", nil, handler, 0)
    end
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.rs",
  callback = function()
    quick.buffer_command("ReloadWorkspace", function()
      vim.lsp.buf_request(0, "rust-analyzer/reloadWorkspace", nil, handler)
    end, { range = true })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("reload_rust_workspace"),
  pattern = "*/Cargo.toml",
  callback = reload_rust_workspace,
})

function M.semantic_tokens(_, bufnr)
  vim.keymap.set("n", "<leader>st", function()
    vim.b.semantic_tokens_enabled = vim.b.semantic_tokens_enabled == false
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if client.server_capabilities.semanticTokensProvider then
        vim.lsp.semantic_tokens[vim.b.semantic_tokens_enabled and "start" or "stop"](
          bufnr or 0,
          client.id
        )
      end
    end
  end, { desc = "Toggle semantic tokens on buffer", buffer = bufnr or 0 })
end

return M

-- vim: fdm=marker fdl=0
```
##  📁 lsp
This folder consists of all the configuration for LSP server
### init
```lua fold file:init.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/int.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", config = true },
      { "j-hui/fidget.nvim", config = true },
      { "smjonas/inc-rename.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      servers = {
        dockerls = {},
        gopls = {},
        vimls = {},
        yamlls = {},
        bashls = {},
        html = {},
        sqlls = {},
        taplo = {},
        marksman = {},
      },
      setup = {},
    },
    config = function(plugin, opts)
      require("plugins.lsp.servers").setup(plugin, opts)
      for name, icon in pairs(require("config.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has "nvim-0.10.0" == 0 and "●"
          or function(diagnostic)
            local icons = require("config.icons").diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
      local navbuddy = require "nvim-navbuddy"
      local actions = require "nvim-navbuddy.actions"
      navbuddy.setup {
        window = {
          border = "single", -- "rounded", "double", "solid", "none"
          -- or an array with eight chars building up the border in a clockwise fashion
          -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
          size = "60%", -- Or table format example: { height = "40%", width = "100%"}
          position = "50%", -- Or table format example: { row = "100%", col = "0%"}
          scrolloff = nil, -- scrolloff value within navbuddy window
          sections = {
            left = {
              size = "20%",
              border = nil, -- You can set border style for each section individually as well.
            },
            mid = {
              size = "40%",
              border = nil,
            },
            right = {
              -- No size option for right most section. It fills to
              -- remaining area.
              border = nil,
              preview = "leaf", -- Right section can show previews too.
              -- Options: "leaf", "always" or "never"
            },
          },
        },
        node_markers = {
          enabled = true,
          icons = {
            leaf = "  ",
            leaf_selected = " → ",
            branch = " ",
          },
        },
        icons = {
          File = "󰈙 ",
          Module = " ",
          Namespace = "󰌗 ",
          Package = " ",
          Class = "󰌗 ",
          Method = "󰆧 ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = "󰕘",
          Interface = "󰕘",
          Function = "󰊕 ",
          Variable = "󰆧 ",
          Constant = "󰏿 ",
          String = " ",
          Number = "󰎠 ",
          Boolean = "◩ ",
          Array = "󰅪 ",
          Object = "󰅩 ",
          Key = "󰌋 ",
          Null = "󰟢 ",
          EnumMember = " ",
          Struct = "󰌗 ",
          Event = " ",
          Operator = "󰆕 ",
          TypeParameter = "󰊄 ",
        },
        use_default_mappings = true, -- If set to false, only mappings set
        -- by user are set. Else default
        -- mappings are used for keys
        -- that are not set by user
        mappings = {
          ["<esc>"] = actions.close(), -- Close and cursor to original location
          ["q"] = actions.close(),

          ["j"] = actions.next_sibling(), -- down
          ["k"] = actions.previous_sibling(), -- up

          ["h"] = actions.parent(), -- Move to left panel
          ["l"] = actions.children(), -- Move to right panel
          ["0"] = actions.root(), -- Move to first panel

          ["v"] = actions.visual_name(), -- Visual selection of name
          ["V"] = actions.visual_scope(), -- Visual selection of scope

          ["y"] = actions.yank_name(), -- Yank the name to system clipboard "+
          ["Y"] = actions.yank_scope(), -- Yank the scope to system clipboard "+

          ["i"] = actions.insert_name(), -- Insert at start of name
          ["I"] = actions.insert_scope(), -- Insert at start of scope

          ["a"] = actions.append_name(), -- Insert at end of name
          ["A"] = actions.append_scope(), -- Insert at end of scope

          ["r"] = actions.rename(), -- Rename currently focused symbol

          ["d"] = actions.delete(), -- Delete scope

          ["f"] = actions.fold_create(), -- Create fold of current scope
          ["F"] = actions.fold_delete(), -- Delete fold of current scope

          ["c"] = actions.comment(), -- Comment out current scope

          ["<enter>"] = actions.select(), -- Goto selected symbol
          ["o"] = actions.select(),

          ["J"] = actions.move_down(), -- Move focused node down
          ["K"] = actions.move_up(), -- Move focused node up

          ["t"] = actions.telescope { -- Fuzzy finder at current level.
            layout_config = { -- All options that can be
              height = 0.60, -- passed to telescope.nvim's
              width = 0.60, -- default can be passed here.
              prompt_position = "top",
              preview_width = 0.50,
            },
            layout_strategy = "horizontal",
          },

          ["g?"] = actions.help(), -- Open mappings help window
        },
        lsp = {
          auto_attach = false, -- If set to true, you don't need to manually use attach function
          preference = nil, -- list of lsp server names in order of preference
        },
        source_buffer = {
          follow_node = true, -- Keep the current node in focus on the source buffer
          highlight = true, -- Highlight the currently focused node
          reorient = "smart", -- "smart", "top", "mid" or "none"
          scrolloff = nil, -- scrolloff value when navbuddy is open
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "ruff",
        "rustfmt",
        "debugpy",
        "codelldb",
        "cbfmt",
        "marksman",
        "markdownlint",
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mr = require "mason-registry"
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    config = function()
      local nls = require "null-ls"
      nls.setup {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.ruff.with { extra_args = { "--max-line-length=180" } },
          nls.builtins.formatting.rustfmt,
          nls.builtins.formatting.cbfmt,
          nls.builtins.formatting.markdownlint,
        },
      }
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    -- enabled = false,
    config = function()
      require("lspsaga").setup {
        definition = {
          edit = "<C-c>o",
          vsplit = "<C-c>v",
          split = "<C-c>i",
          table = "<C-c>t",
          quit = "q",
        },
        code_action = {
          num_shortcut = true,
          show_server_name = false,
          extend_gitsigns = true,
          keys = {
            -- string | table type
            quit = "q",
            exec = "<CR>",
          },
        },
        lightbulb = {
          enable = true,
          enable_in_insert = true,
          sign = true,
          sign_priority = 40,
          virtual_text = true,
        },
        diagnostic = {
          on_insert = false,
          on_insert_follow = false,
          insert_winblend = 0,
          show_code_action = true,
          show_source = true,
          jump_num_shortcut = true,
          max_width = 0.7,
          max_height = 0.6,
          max_show_width = 0.9,
          max_show_height = 0.6,
          text_hl_follow = true,
          border_follow = true,
          extend_relatedInformation = false,
          keys = {
            exec_action = "o",
            quit = "q",
            expand_or_jump = "<CR>",
            quit_in_show = { "q", "<ESC>" },
          },
        },
        hover = {
          max_width = 0.6,
          open_link = "gx",
          open_browser = "!chrome",
        },
        rename = {
          quit = "<C-c>",
          exec = "<CR>",
          mark = "x",
          confirm = "<CR>",
          in_select = true,
        },
        outline = {
          win_position = "right",
          win_with = "",
          win_width = 30,
          preview_width = 0.4,
          show_detail = true,
          auto_preview = true,
          auto_refresh = true,
          auto_close = true,
          auto_resize = false,
          custom_sort = nil,
          keys = {
            expand_or_jump = "o",
            quit = "q",
          },
        },
        callhierarchy = {
          show_detail = false,
          keys = {
            edit = "e",
            vsplit = "s",
            split = "i",
            table = "t",
            jump = "o",
            quit = "q",
            expand_collapse = "u",
          },
        },
        beacon = {
          enable = true,
          frequency = 7,
        },
        ui = {
          -- This option only works in Neovim 0.9
          title = true,
          -- Border type can be single, double, rounded, solid, shadow.
          border = "single",
          winblend = 0,
          expand = "",
          collapse = "",
          code_action = "💡",
          incoming = " ",
          outgoing = " ",
          hover = " ",
          kind = {
            File = { "󰈔 ", "LspKindFile" },
            Module = { " ", "LspKindModule" },
            Namespace = { " ", "LspKindNamespace" },
            Package = { " ", "LspKindPackage" },
            Class = { " ", "LspKindClass" },
            Method = { " ", "LspKindMethod" },
            Property = { " ", "LspKindProperty" },
            Field = { " ", "LspKindField" },
            Constructor = { " ", "LspKindConstructor" },
            Enum = { " ", "LspKindEnum" },
            Interface = { " ", "LspKindInterface" },
            Function = { "󰊕 ", "LspKindFunction" },
            Variable = { " ", "LspKindVariable" },
            Constant = { " ", "LspKindConstant" },
            String = { " ", "LspKindString" },
            Number = { "󰉻 ", "LspKindNumber" },
            Boolean = { " ", "LspKindBoolean" },
            Array = { " ", "LspKindArray" },
            Object = { "󰐾 ", "LspKindObject" },
            Key = { "󰌋 ", "LspKindKey" },
            Null = { "󰟢 ", "LspKindNull" },
            EnumMember = { " ", "LspKindEnumMember" },
            Struct = { " ", "LspKindStruct" },
            Event = { " ", "LspKindEvent" },
            Operator = { " ", "LspKindOperator" },
            TypeParameter = { " ", "LspKindTypeParameter" },
            TypeAlias = { " ", "LspKindTypeAlias" },
            Parameter = { " ", "LspKindParameter" },
            StaticMethod = { " ", "LspKindStaticMethod" },
            Macro = { " ", "LspKindMacro" },
            Text = { " ", "LspKindText" },
            Snippet = { " ", "LspKindSnippet" },
            Folder = { " ", "LspKindFolder" },
            Unit = { " ", "LspKindUnit" },
            Value = { " ", "LspKindValue" },
          },
        },
      }
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
```
### format
```lua fold file:format.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/format.lua
local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  vim.notify(M.autoformat and "Enabled format on save" or "Disabled format on save")
end

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format {
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  }
end

function M.on_attach(client, buf)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        if M.autoformat then
          M.format()
        end
      end,
    })
  end
end

return M
```
### keymaps
```lua fold file:keymaps.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/keymaps.lua
local M = {}

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)

  self:map("gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
  self:map("gr", "Telescope lsp_references", { desc = "References" })
  self:map("gD", "Telescope lsp_declarations", { desc = "Goto Declaration" })
  self:map("gI", "Telescope lsp_implementations", { desc = "Goto Implementation" })
  self:map("gb", "Telescope lsp_type_definitions", { desc = "Goto Type Definition" })
  self:map("K", vim.lsp.buf.hover, { desc = "Hover" })
  self:map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })
  self:map("[d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
  self:map("]d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
  self:map("]e", M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  self:map("[e", M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  self:map("]w", M.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
  self:map("[w", M.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })
  self:map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })

  local format = require("plugins.lsp.format").format
  self:map("<leader>cf", format, { desc = "Format Document", has = "documentFormatting" })
  self:map("<leader>cf", format, { desc = "Format Range", mode = "v", has = "documentRangeFormatting" })
  self:map("<leader>cr", M.rename, { expr = true, desc = "Rename", has = "rename" })
  self:map("<leader>cn", "Navbuddy", { desc = "Navbuddy" })
  self:map("<leader>cs", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
  self:map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
end

function M.new(client, buffer)
  return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
  return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not self:has(opts.has) then
    return
  end
  vim.keymap.set(
    opts.mode or "n",
    lhs,
    type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
  )
end

function M.rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand "<cword>"
  else
    vim.lsp.buf.rename()
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

return M
```

### servers
```lua fold file:servers.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/servers.lua
local M = {}

local lsp_utils = require "plugins.lsp.utils"

function M.setup(_, opts)
  lsp_utils.on_attach(function(client, buffer)
    require("plugins.lsp.format").on_attach(client, buffer)
    require("plugins.lsp.keymaps").on_attach(client, buffer)
  end)

  local servers = opts.servers
  require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }
  require("mason-lspconfig").setup_handlers {
    function(server)
      local server_opts = servers[server] or {}
      server_opts.capabilities = lsp_utils.capabilities()
      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end,
  }
end

return M
```

### utils
```lua fold file:utils.lua  !tangle:~/.config/nvim/Wizen/lua/plugins/lsp/utils.lua
local M = {}

local FORMATTING = require("null-ls").methods.FORMATTING
local DIAGNOSTICS = require("null-ls").methods.DIAGNOSTICS
local COMPLETION = require("null-ls").methods.COMPLETION
local CODE_ACTION = require("null-ls").methods.CODE_ACTION
local HOVER = require("null-ls").methods.HOVER

local function list_registered_providers_names(ft)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(ft)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.list_formatters(ft)
  local providers = list_registered_providers_names(ft)
  return providers[FORMATTING] or {}
end

function M.list_linters(ft)
  local providers = list_registered_providers_names(ft)
  return providers[DIAGNOSTICS] or {}
end

function M.list_completions(ft)
  local providers = list_registered_providers_names(ft)
  return providers[COMPLETION] or {}
end

function M.list_code_actions(ft)
  local providers = list_registered_providers_names(ft)
  return providers[CODE_ACTION] or {}
end

function M.list_hovers(ft)
  local providers = list_registered_providers_names(ft)
  return providers[HOVER] or {}
end

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  })
end

return M
```

## pde
This folder contains everything related to personal development environment.

## statusline

## test

## vcs

## rest of the plugins