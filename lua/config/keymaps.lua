-- Example: Map <leader>h to turn off search highlighting in Normal mode
vim.keymap.set('n', '<leader>f', '<cmd>Pick files<CR>', { desc = 'Pick files' })
vim.keymap.set('n', '<leader>\'', '<cmd>Pick resume<CR>', { desc = 'Resume operation' })
vim.keymap.set('n', '<leader>b', '<cmd>Pick resume<CR>', { desc = 'Pick buffers' })
vim.keymap.set('n', '<leader>/', '<cmd>Pick grep_live<CR>', { desc = 'Pick buffers' })

