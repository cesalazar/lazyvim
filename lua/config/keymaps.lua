-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- DO NOT USE `LazyVim.safe_keymap_set` HERE! Use `vim.keymap.set` instead
local map = vim.keymap.set

-- Buffers
map("n", ",", "<C-^>", { desc = "Return to last Buffer", remap = true, silent = true })
map("n", "<M-i>", ":BufferLineCyclePrev<cr>", { desc = "Go to previous Buffer", remap = true, silent = true })
map("n", "<M-o>", ":BufferLineCycleNext<cr>", { desc = "Go to next Buffer", remap = true, silent = true })
map("n", "<M-x>", ":bd<cr>", { desc = "Delete Buffer", remap = true, silent = true })

map("n", "Y", "yy", { desc = "Copy line with linebreak", remap = true, silent = true })
map("n", "\\\\", "<cmd>w<cr>", { desc = "Write Buffer", silent = true })

Snacks.toggle.option("list", { name = "List Mode" }):map("\\l")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("\\w")

map("n", "\\t0", "<cmd>set textwidth=0 colorcolumn=<cr>", { desc = "Reset textwidth", silent = true })
map("n", "\\t5", "<cmd>set textwidth=50 colorcolumn=+1<cr>", { desc = "Set textwidth=50", silent = true })
map("n", "\\t7", "<cmd>set textwidth=72 colorcolumn=+1<cr>", { desc = "Set textwidth=72", silent = true })
map("n", "\\t8", "<cmd>set textwidth=80 colorcolumn=+1<cr>", { desc = "Set textwidth=80", silent = true })

map("n", "<M-n>", "<leader>fe", { desc = "Explorer Snacks (root dir)", remap = true })

map("v", "<M-s>", ":sort<cr>", { desc = "Sort selection", remap = true, silent = true })
map("v", "<M-y>", '"+y', { desc = "Yank to clipboard", remap = true })
