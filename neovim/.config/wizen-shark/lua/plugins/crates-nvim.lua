return {
  "saecki/crates.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = { "BufReadPre Cargo.toml" },
  opts = {
    popup = {
      autofocus = true,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("BufRead", {
      group = require("config.util").augroup("CmpSourceCargo"),
      pattern = "Cargo.toml",
      callback = function()
        local crates = require("crates")
        local opts = { noremap = true, silent = true, buffer = true }

        vim.keymap.set("n", "<leader>Ct", crates.toggle, opts)
        vim.keymap.set("n", "<leader>Cr", crates.reload, opts)

        vim.keymap.set("n", "H", crates.show_popup, opts)
        vim.keymap.set("n", "<leader>Cv", crates.show_versions_popup, opts)
        vim.keymap.set("n", "<leader>Cf", crates.show_features_popup, opts)
        vim.keymap.set("n", "<leader>Cd", crates.show_dependencies_popup, opts)

        vim.keymap.set("n", "<leader>Cu", crates.update_crate, opts)
        vim.keymap.set("v", "<leader>Cu", crates.update_crates, opts)
        vim.keymap.set("n", "<leader>Ca", crates.update_all_crates, opts)
        vim.keymap.set("n", "<leader>CU", crates.upgrade_crate, opts)
        vim.keymap.set("v", "<leader>CU", crates.upgrade_crates, opts)
        vim.keymap.set("n", "<leader>CA", crates.upgrade_all_crates, opts)

        vim.keymap.set("n", "<leader>CH", crates.open_homepage, opts)
        vim.keymap.set("n", "<leader>CR", crates.open_repository, opts)
        vim.keymap.set("n", "<leader>CD", crates.open_documentation, opts)
        vim.keymap.set("n", "<leader>CC", crates.open_crates_io, opts)
      end,
    })
  end,

  enabled = require("config.util").is_enabled("saecki/crates.nvim"),
}
