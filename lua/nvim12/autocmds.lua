local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TermOpen', {
  callback = function()
    vim.wo.number = false
  end,
})

-- Autocmds below adapted from https://github.com/ThorstenRhau/neovim/blob/c5d8652edeedcd64a0e51c236986f379b8ac0724/lua/config/autocmds.lua

-- Restore cursor to last position when reopening a file
autocmd('BufReadPost', {
  group = augroup('restore_cursor', { clear = true }),
  callback = function(event)
    local exclude_ft = { gitcommit = true, gitrebase = true }
    if exclude_ft[vim.bo[event.buf].filetype] then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Equalize split sizes when terminal is resized
autocmd('VimResized', {
  group = augroup('resize_splits', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Map q to close non-editable buffer types
autocmd('FileType', {
  group = augroup('close_with_q', { clear = true }),
  pattern = {
    'checkhealth', 'git', 'gitsigns-blame', 'help',
    'lspinfo', 'notify', 'qf', 'startuptime',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', function()
      local ok = pcall(vim.cmd.bdelete, { bang = true })
      if not ok then vim.cmd.quit() end
    end, { buffer = event.buf, silent = true, desc = 'Close buffer' })
  end,
})

-- Auto-create parent directories when saving to a new path
autocmd('BufWritePre', {
  group = augroup('auto_create_dir', { clear = true }),
  callback = function(event)
    if event.match:match('^%w%w+://') then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Check for external file changes on focus return or terminal exit
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime', { clear = true }),
  callback = function()
    if vim.bo.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- UI2 floating window customizations
-- Set highlight for the msg floating window to use NormalFloat colors
vim.api.nvim_create_autocmd("FileType", {
  pattern = "msg",
  callback = function()
    local ui2 = require("vim._core.ui2")
    local win = ui2.wins and ui2.wins.msg
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_option_value(
        "winhighlight",
        "Normal:NormalFloat,FloatBorder:FloatBorder",
        { scope = "local", win = win }
      )
    end
  end,
})

local ui2 = require("vim._core.ui2")
local msgs = require("vim._core.ui2.messages")
local cmdline = require("vim._core.ui2.cmdline")

-- Override msg window position to float at top-right with a rounded border
-- instead of the default bottom-left laststatus-relative position
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
  orig_set_pos(tgt)
  if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
    pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
      relative = "editor",
      anchor = "NE",
      row = 1,
      col = vim.o.columns - 1,
      border = "rounded",
    })
  end
end

-- Reposition cmd window to float at bottom-center with a rounded border
-- instead of the default cmdline area at the very bottom
local function reposition_cmd()
  if vim.api.nvim_win_is_valid(ui2.wins.cmd) then
    local width = math.floor(vim.o.columns * 0.6)
    local col = math.floor((vim.o.columns - width) / 2)
    pcall(vim.api.nvim_win_set_config, ui2.wins.cmd, {
      relative = "editor",
      anchor = "SW",
      row = vim.o.lines - 2,
      col = col,
      width = width,
      border = "rounded",
    })
  end
end

-- Override cmdline_show to reposition the cmd window and restore cmdheight=0
-- (the original win_config sets cmdheight to the text height, causing an empty line at the bottom)
local orig_cmdline_show = cmdline.cmdline_show
cmdline.cmdline_show = function(content, pos, firstc, prompt, indent, level, hl_id)
  orig_cmdline_show(content, pos, firstc, prompt, indent, level, hl_id)
  reposition_cmd()
  if vim.o.cmdheight ~= 0 then
    vim._with({ noautocmd = true, o = { splitkeep = 'screen' } }, function()
      vim.o.cmdheight = 0
    end)
  end
end

-- Re-apply floating cmd config after check_targets recreates the window
-- (happens after expand/close cycles or tabpage changes)
local orig_check_targets = ui2.check_targets
ui2.check_targets = function(...)
  orig_check_targets(...)
  reposition_cmd()
end
