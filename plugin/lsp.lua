vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo({ { value.message or 'done' } }, false, {
      id = 'lsp.' .. ev.data.client_id,
      kind = 'progress',
      source = 'vim.lsp',
      title = value.title,
      status = value.kind ~= 'end' and 'running' or 'success',
      percent = value.percentage,
    })
  end,
})

vim.lsp.enable({ 'lua_ls', 'rust_analyzer', 'nil_ls', 'ts_ls', 'pyright', 'clangd' })

-- Neovim has no default goto-definition map; it only wires up 'tagfunc'
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
