require('nvim12.options')
require('nvim12.keymaps')
require('nvim12.diagnostics')
require('nvim12.autocmds')

vim.cmd.colorscheme('catppuccin')

require('vim._core.ui2').enable({
  enable = true,
})
