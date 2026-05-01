-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Diagnostic annotations related to the code
vim.diagnostic.enable(false)

vim.cmd("cabbrev h H")
vim.cmd("cabbrev help H")

local opt = vim.opt

opt.clipboard = "unnamed"
opt.conceallevel = 0
opt.cursorline = false
opt.foldmethod = "manual"
opt.listchars = "eol:¬,tab:▸-▸,extends:❯,precedes:❮,space:·,trail:X,nbsp:!"
opt.list = false
opt.relativenumber = false
opt.scrolloff = 7
opt.showtabline = 2
