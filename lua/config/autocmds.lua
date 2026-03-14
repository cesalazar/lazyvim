-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Git commit: 50 chars on subject line, 72 on body
local function setup_gitcommit_limits()
  vim.api.nvim_create_augroup("GitCommitDynamic", { clear = true })
  vim.opt_local.colorcolumn = "51,73"

  local function update_textwidth()
    local cc = vim.api.nvim_get_option_value("colorcolumn", { scope = "local" })
    if cc ~= "51,73" then
      return
    end
    vim.opt_local.textwidth = vim.fn.line(".") == 1 and 50 or 72
  end

  update_textwidth()
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = 0,
    group = "GitCommitDynamic",
    callback = update_textwidth,
  })
end

vim.api.nvim_create_user_command("GitCommitLimits", setup_gitcommit_limits, { desc = "Set git commit textwidth" })
vim.api.nvim_create_autocmd("FileType", { pattern = "gitcommit", callback = setup_gitcommit_limits })

-- Open help as a full listed buffer
vim.api.nvim_create_user_command("H", function(opts)
  vim.cmd("help " .. opts.args)
  vim.cmd("only")
  vim.bo.buflisted = true
end, { nargs = "?", complete = "help", desc = "Open help as listed buffer" })
vim.cmd("cabbrev h H")
vim.cmd("cabbrev help H")
