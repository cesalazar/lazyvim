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

-- ── Checkbox functions ───────────────────────────────────────────────────
local function parse_checkbox(lnum)
  local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
  local prefix, state = line:match("^(%s*%- %[([%sx])%] )")
  if not prefix then
    return nil
  end
  return prefix, state, line:sub(#prefix + 1)
end

local function label_end(lnum, indent_len)
  local end_lnum = lnum
  local total = vim.api.nvim_buf_line_count(0)
  for i = lnum + 1, total do
    local l = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
    if l:match("^" .. string.rep(" ", indent_len + 1)) and not l:match("^%s*[-*+] ") then
      end_lnum = i
    else
      break
    end
  end
  return end_lnum
end

-- Jump to next checkbox after lnum, wrapping to the first one in the buffer
local function jump_to_next_checkbox(lnum)
  local total = vim.api.nvim_buf_line_count(0)
  for i = lnum + 1, total do
    if parse_checkbox(i) then
      vim.cmd("normal! m'")
      vim.fn.cursor(i, 1)
      return
    end
  end
  for i = 1, lnum do
    if parse_checkbox(i) then
      vim.cmd("normal! m'")
      vim.fn.cursor(i, 1)
      return
    end
  end
end

function ToggleCheckbox()
  local lnum = vim.fn.line(".")
  local prefix, state = parse_checkbox(lnum)
  if not prefix then
    jump_to_next_checkbox(0)
    return
  end

  local new_state = state == " " and "x" or " "
  local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
  vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, {
    (line:gsub("^(%s*%- %[)[%sx](%] )", "%1" .. new_state .. "%2", 1)),
  })
  jump_to_next_checkbox(lnum)
end

-- ── Delete HTML comment ──────────────────────────────────────────────
function DeleteHtmlComment()
  local total = vim.api.nvim_buf_line_count(0)
  local cursor = vim.fn.line(".")
  local start_lnum = nil
  local end_lnum = nil

  -- Search backwards from cursor for <!--
  for i = cursor, 1, -1 do
    local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
    if line:find("<!%-%-") then
      start_lnum = i
      if line:find("%-%->") then
        end_lnum = i -- single-line comment
      end
      break
    elseif line:find("%-%->") and i ~= cursor then
      break -- hit --> before <!--, cursor is outside any comment
    end
  end

  -- If not found behind cursor, search forward
  if not start_lnum then
    for i = cursor + 1, total do
      local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
      if line:find("<!%-%-") then
        start_lnum = i
        if line:find("%-%->") then
          end_lnum = i
        end
        break
      end
    end
  end

  if not start_lnum then
    vim.notify("No HTML comment found", vim.log.levels.WARN)
    return
  end

  -- Find closing --> if not already found (multiline comment)
  if not end_lnum then
    for i = start_lnum + 1, total do
      local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
      if line:find("%-%->") then
        end_lnum = i
        break
      end
    end
  end

  if not end_lnum then
    vim.notify("No closing --> for HTML comment", vim.log.levels.WARN)
    return
  end

  vim.api.nvim_buf_set_lines(0, start_lnum - 1, end_lnum, false, {})
  vim.notify("Deleted HTML comment", vim.log.levels.INFO)
end

function DeleteAllHtmlComments()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result = {}
  local inside = false
  local count = 0

  for _, line in ipairs(lines) do
    if not inside then
      if line:find("<!%-%-") then
        if line:find("%-%->") then
          count = count + 1 -- single-line, skip it
        else
          inside = true
          count = count + 1
        end
      else
        result[#result + 1] = line
      end
    else
      if line:find("%-%->") then
        inside = false
      end
    end
  end

  if count == 0 then
    vim.notify("No HTML comments found", vim.log.levels.WARN)
    return
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
  vim.notify("Deleted " .. count .. " HTML comment(s)", vim.log.levels.INFO)
end

function ToggleStrikethrough()
  local lnum = vim.fn.line(".")
  local prefix, _, first_label = parse_checkbox(lnum)
  if not prefix or not first_label then
    jump_to_next_checkbox(0)
    return
  end

  local indent_len = #(prefix:match("^(%s*)"))
  local end_lnum = label_end(lnum, indent_len)
  local lines = vim.api.nvim_buf_get_lines(0, lnum - 1, end_lnum, false)

  if first_label:match("^~") and lines[#lines]:match("~$") then
    lines[1] = prefix .. first_label:sub(2)
    lines[#lines] = lines[#lines]:sub(1, -2)
  else
    lines[1] = prefix .. "~" .. first_label
    lines[#lines] = lines[#lines] .. "~"
  end

  vim.api.nvim_buf_set_lines(0, lnum - 1, end_lnum, false, lines)
  jump_to_next_checkbox(end_lnum)
end
