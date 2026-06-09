-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- DO NOT USE `LazyVim.safe_keymap_set` HERE! Use `vim.keymap.set` instead
local map = vim.keymap.set

-- ── Buffers ──────────────────────────────────────────────────────────────
map("n", ",", "<C-^>", { desc = "Switch to Other Buffer", remap = true, silent = true })
map("n", "<leader>bn", "<Cmd>bn<CR>", { desc = "Next Buffer", remap = true })
map("n", "<leader>bp", "<Cmd>bp<CR>", { desc = "Prev Buffer", remap = true })
map("n", "<leader>by", "<Cmd>YankPath<CR>", { desc = "Yank Absolute Path", silent = true })
map("n", "<leader>bY", "<Cmd>YankPath!<CR>", { desc = "Yank Relative Path", silent = true })
map("n", "<M-a>", "<leader>sg", { desc = "Grep (Root Dir)", remap = true })
map("n", "<M-f>", "<leader><space>", { desc = "Find Files (Root Dir)", remap = true })
map("n", "<M-x>", SmartBufDelete, { desc = "Delete Buffer", silent = true })

-- ── File ─────────────────────────────────────────────────────────────────
map("n", "<localleader><localleader>", "<Cmd>w<CR>", { desc = "Write Buffer", silent = true })
map("n", "<M-n>", "<leader>fE", { desc = "Explorer Snacks (cwd)", remap = true })
map("n", "<M-N>", "<leader>fe", { desc = "Explorer Snacks (Root Dir)", remap = true })

-- ── Checkboxes ───────────────────────────────────────────────────────────
map("n", "<localleader>x", ToggleCheckbox, { desc = "Toggle Checkbox", silent = true })
map("n", "<localleader>-", ToggleStrikethrough, { desc = "Toggle Strikethrough", silent = true })
map("n", "<localleader>h", DeleteHtmlComment, { desc = "Delete HTML comment", silent = true })
map("n", "<localleader>H", DeleteAllHtmlComments, { desc = "Delete all HTML comments", silent = true })

-- ── Editing ──────────────────────────────────────────────────────────────
map("n", "Y", "yy", { desc = "Copy line with linebreak", remap = true, silent = true })
map("v", "<M-h>", "<gv", { desc = "Indent Left", silent = true })
map("v", "<M-l>", ">gv", { desc = "Indent Right", silent = true })
map("v", "<M-s>", ":sort l<CR>", { desc = "Sort selection", remap = true, silent = true })
map("v", "<M-y>", '"+y', { desc = "Yank to clipboard", remap = true })
map("v", "S", "gsa", { desc = "Add Surrounding", remap = true, silent = true })

-- ── Formatting ──────────────────────────────────────────────────────────────
map("n", "<localleader>P", ":set filetype=", { desc = "Set filetype", silent = false })
map("n", "Q", "gw$", { desc = "Wrap lines at textwidth", silent = true })
map("v", "Q", "gw", { desc = "Wrap lines at textwidth", silent = true })

-- ── Options ──────────────────────────────────────────────────────────────
Snacks.toggle.option("list", { name = "List Mode" }):map("\\l")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("\\w")

map("n", "<localleader>t0", "<Cmd>set textwidth=0 colorcolumn=<CR>", { desc = "Reset textwidth", silent = true })
map("n", "<localleader>t2", "<Cmd>set textwidth=120 colorcolumn=+1<CR>", { desc = "Set textwidth=120", silent = true })
map("n", "<localleader>t5", "<Cmd>set textwidth=50 colorcolumn=+1<CR>", { desc = "Set textwidth=50", silent = true })
map("n", "<localleader>t7", "<Cmd>set textwidth=72 colorcolumn=+1<CR>", { desc = "Set textwidth=72", silent = true })
map("n", "<localleader>t8", "<Cmd>set textwidth=80 colorcolumn=+1<CR>", { desc = "Set textwidth=80", silent = true })
map("n", "<localleader>tg", "<Cmd>GitCommitLimits<CR>", { desc = "Set commit textwidth", silent = true })
