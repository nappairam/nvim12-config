vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.wo.number = false
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
