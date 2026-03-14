-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ── Git commit: 50 chars on subject line, 72 on body ─────────────────────
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

-- ── Yank buffer path to clipboard ────────────────────────────────────────
local function YankPath(relative)
  relative = relative or false
  local path = relative and vim.fn.expand("%:.") or vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify(path, vim.log.levels.INFO, { title = "Path copied" })
end
vim.api.nvim_create_user_command("YankPath", function(opts)
  YankPath(opts.bang)
end, { bang = true, desc = "Yank buffer path (! for relative)" })

-- ── Open help as a listed buffer ─────────────────────────────────────────
vim.api.nvim_create_user_command("H", function(opts)
  vim.cmd("help " .. opts.args)
  vim.cmd("only")
  vim.bo.buflisted = true
end, { nargs = "?", complete = "help", desc = "Open help as listed buffer" })

-- ── Keep help buffers listed ─────────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function(event)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(event.buf) then
        vim.bo[event.buf].buflisted = true
      end
    end)
  end,
})
