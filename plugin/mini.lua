vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.basics').setup()
require('mini.pick').setup()

local map = vim.keymap.set
map('n', '<leader>f', '<cmd>Pick files<cr>', { desc = 'Pick files' })
map('n', '<leader>b', '<cmd>Pick buffers<cr>', { desc = 'Pick buffers' })
map('n', '<leader>/', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' })
map('n', "<leader>'", '<cmd>Pick resume<cr>', { desc = 'Resume picker' })
