vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-mini/mini.nvim',
})

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

require('mini.basics').setup()
require('mini.pick').setup()

vim.lsp.enable({ 'lua_ls', 'rust_analyzer' })
