# config
## autocmds
Autocommands are a way to tell Vim to run certain commands whenever certain events happen. Let's dive right into an example.
```lua fold file:autocmds.lua  !tangle:~/.config/nvim/Wizen/config/autocmds.lua
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
```lua lua fold file:enabled_list.lua  !tangle:~/.config/nvim/Wizen/config/enabled_list.lua
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
## icons
Here are icons used all over the lua configs.
```lua fold file:icons.lua  !tangle:~/.config/nvim/Wizen/config/icons.lua
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
##  keymaps
```lua fold file:keymaps.lua  !tangle:~/.config/nvim/Wizen/config/keymaps.lua
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
## lazy
Here we import all the plugins and lazy load them
```lua fold file:lazy.lua  !tangle:~/.config/nvim/Wizen/config/lazy.lua
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
```lua fold file:options.lua  !tangle:~/.config/nvim/Wizen/config/options.lua
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

## util
Custom functions used throughout the plugins in Neovim setup.
```lua fold file:util.lua  !tangle:~/.config/nvim/Wizen/config/util.lua
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
# plugins
## colorscheme

## completion

## dap

## dashboard

## lsp

## pde

## statusline

## 