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
require('mini.surround').setup()

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
}

vim.lsp.enable('lua_ls')

vim.lsp.config.rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = {"Cargo.toml", ".git"},
    single_file_support = true,
    before_init = function(init_params, config)
        -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
        if config.settings and config.settings['rust-analyzer'] then
            init_params.initializationOptions = config.settings['rust-analyzer']
        end
    end,
}
vim.lsp.enable("rust_analyzer")
