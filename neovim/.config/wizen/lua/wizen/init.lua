vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.loader.enable()


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = {
    lazy = true,
    event = "VeryLazy",
  },
  spec = {
  { import = "plugins" },
  { import = "plugins.core" },
  { import = "plugins.dap" },
  { import = "plugins.editor" },
  { import = "plugins.lsp" },
  { import = "plugins.navigation" },
  { import = "plugins.pde.lang" },
  { import = "plugins.status" },
  { import = "plugins.terminal" },
  { import = "plugins.ui" },
  },
  -- dev = { path = "~/projects/lua/" },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = false,
    border = "rounded",
  },
  install = {
    missing = true,
    colorscheme = { "minimus" },
  },
  browser = "brave",
  diff = {
    cmd = "diffview.nvim",
  },
  change_detection = {
    notify = true,
  },
  performance = {
    cache = { enabled = true },
    -- reset_packpath = true,
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
})


require("wizen.set")

local function initialize()
  -- setup mappings
  require("wizen.mappings")

  -- setup hydras
  require("wizen.hydras")

  vim.defer_fn(
    function() vim.api.nvim_exec_autocmds("User", { pattern = "ExtraLazy" }) end,
    100
  )
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = vim.schedule_wrap(function()
    -- require("lazy").load("wizen")
    initialize()
  end),
})

vim.api.nvim_create_autocmd("User", {
  pattern = "ExtraLazy",
  once = true,
  callback = function()
    require("wizen.async")

    -- setup commands
    require("wizen.commands")
  end,
})
