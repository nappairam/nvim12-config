vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.basics').setup()
require('mini.clue').setup({
  triggers = {
    { mode = 'n', keys = '<leader>' },
    { mode = 'x', keys = '<leader>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" },
    { mode = 'x', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = '`' },
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'x', keys = '[' },
    { mode = 'x', keys = ']' },
  },
  clues = {
    require('mini.clue').gen_clues.builtin_completion(),
    require('mini.clue').gen_clues.g(),
    require('mini.clue').gen_clues.marks(),
    require('mini.clue').gen_clues.registers(),
    require('mini.clue').gen_clues.windows(),
    require('mini.clue').gen_clues.z(),
  },
})
require('mini.diff').setup()
require('mini.git').setup()
require('mini.jump').setup()
require('mini.jump2d').setup()
require('mini.extra').setup()
require('mini.files').setup()
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(ev)
    vim.keymap.set('n', '<CR>', function()
      require('mini.files').go_in({ close_on_file = true })
    end, { buffer = ev.data.buf_id, desc = 'Open file/dir' })
  end,
})
require('mini.pairs').setup()
require('mini.pick').setup()

local map = vim.keymap.set
map('n', '<leader>e', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end, { desc = 'File explorer' })
map('n', '<leader>f', '<cmd>Pick files<cr>', { desc = 'Pick files' })
map('n', '<leader>b', '<cmd>Pick buffers<cr>', { desc = 'Pick buffers' })
map('n', '<leader>/', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' })
map('n', "<leader>'", '<cmd>Pick resume<cr>', { desc = 'Resume picker' })
