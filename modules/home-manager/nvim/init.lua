-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Initialize lazy with an external lockfile path
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  -- Crucial for Nix: Saves lockfile to ~/.local/share/nvim/lazy-lock.json
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", 
})
