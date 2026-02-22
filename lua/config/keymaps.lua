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
map("n", "\\w", ":w<cr>", { desc = "Write Buffer", remap = true, silent = true }) -- TODO: Odd behaviour

map("n", "\\l", ":set list!<cr>", { desc = "Toggle List Mode", remap = true, silent = true })
map("n", "\\t0", ":set textwidth=0 colorcolumn=<cr>", { desc = "Reset textwidth", remap = true, silent = true })
map("n", "\\t5", ":set textwidth=50 colorcolumn=+1<cr>", { desc = "Set textwidth=50", remap = true, silent = true })
map("n", "\\t7", ":set textwidth=72 colorcolumn=+1<cr>", { desc = "Set textwidth=72", remap = true, silent = true })
map("n", "\\t8", ":set textwidth=80 colorcolumn=+1<cr>", { desc = "Set textwidth=80", remap = true, silent = true })

map("v", "<M-s>", ":sort<cr>", { desc = "Sort selection", remap = true, silent = true })
map("v", "<M-y>", '"+y', { desc = "Yank to clipboard", remap = true, silent = true })
