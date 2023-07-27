return 	{
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitCurrentFile",
        "LazyGitFilterCurrentFile",
        "LazyGitFilter",
    },
    config = function()
        vim.g.lazygit_floating_window_scaling_factor = 1
    end,
}