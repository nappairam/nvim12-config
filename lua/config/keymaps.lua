local map = vim.keymap.set

-- Insert mode
map('i', 'jk', '<esc>', { desc = 'Exit insert mode' })

-- Command mode shortcut
map('n', ';', ':', { nowait = true, silent = false })
map('v', ';', ':', { nowait = true, silent = false })

-- Smart j/k (respect wrapped lines)
map({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Line start/end
map({ 'n', 'v' }, 'H', '^', { desc = 'Line start' })
map({ 'n', 'v' }, 'L', 'g_', { desc = 'Line end' })

-- Yank/paste
map('n', 'Y', 'y$', { desc = 'Yank to end of line' })
map('n', 'gV', '`[V`]', { desc = 'Select last pasted' })
map('v', 'gy', '"*y', { desc = 'Copy to system clipboard' })
map('n', 'gp', '"*p', { desc = 'Paste from system clipboard' })
map('n', 'gP', '"*P', { desc = 'Paste before from system clipboard' })

-- Disable accidental quit/close
map('n', 'ZZ', '<nop>')
map('n', 'ZQ', '<nop>')

-- Disable case change in visual
map('v', 'u', '<nop>')
map('v', 'U', '<nop>')

-- Buffer/file operations
map('n', 'X', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', 'W', '<cmd>w<cr>', { desc = 'Save file' })
map('n', 'Q', '<cmd>bdelete<cr>', { desc = 'Close buffer' })

-- Indentation (keep selection)
map('v', '>', '>gv')
map('v', '<', '<gv')
map('n', '<leader>=', "gg=G`'", { desc = 'Indent entire file' })

-- Increment/decrement
map('n', '+', '<c-a>', { desc = 'Increment' })
map('n', '-', '<c-x>', { desc = 'Decrement' })

-- Section jump with centering
map('n', '[[', '[[zz')
map('n', ']]', ']]zz')

-- Tag jump
map({ 'n', 'v' }, '<c-]>', 'g<c-]>')
map('n', 'gt', 'g<c-]>', { desc = 'Go to tag' })
map({ 'n', 'v' }, 'g<c-]>', '<c-]>')

-- Delete to black hole
map({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete (no yank)' })

-- Visual join
map('v', 'gJ', ':join<cr>', { desc = 'Join lines' })

-- Terminal
map('t', '<Esc>', '<c-\\><c-n><esc><cr>', { desc = 'Exit terminal mode' })

-- Picker (mini.pick)
map('n', '<leader>f', '<cmd>Pick files<cr>', { desc = 'Pick files' })
map('n', '<leader>b', '<cmd>Pick buffers<cr>', { desc = 'Pick buffers' })
map('n', '<leader>/', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' })
map('n', "<leader>'", '<cmd>Pick resume<cr>', { desc = 'Resume picker' })

