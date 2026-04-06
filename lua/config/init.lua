require('config.options')
require('config.keymaps')
require('config.diagnostics')
require('config.autocmds')

vim.cmd.colorscheme('catppuccin')

require('vim._core.ui2').enable({
  enable = true,
})
