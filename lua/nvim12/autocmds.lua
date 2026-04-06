vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.wo.number = false
  end,
})
