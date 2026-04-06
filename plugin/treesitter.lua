vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

-- stylua: ignore
local langs = {
  'asm', 'bash', 'c', 'c_sharp', 'cpp', 'cmake', 'comment', 'csv', 'css',
  'devicetree', 'diff', 'disassembly', 'dockerfile', 'doxygen', 'fish',
  'git_rebase', 'gitattributes', 'git_config', 'gitignore', 'go', 'gomod',
  'gosum', 'gotmpl', 'gowork', 'hcl', 'helm', 'html', 'http', 'hurl',
  'java', 'javascript', 'jq', 'json', 'llvm', 'lua', 'luau', 'markdown',
  'meson', 'nasm', 'ninja', 'nix', 'nu', 'objdump', 'passwd', 'pem', 'perl',
  'printf', 'python', 'readline', 'regex', 'rust', 'sql', 'ssh_config',
  'strace', 'svelte', 'terraform', 'tmux', 'toml', 'tsv', 'typescript',
  'udev', 'vim', 'vimdoc', 'query', 'xml', 'yaml', 'yang', 'zig',
}

require('nvim-treesitter.configs').setup({
  ensure_installed = langs,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end,
})
