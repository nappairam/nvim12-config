local sev = vim.diagnostic.severity

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = '●' },
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [sev.ERROR] = '\u{F659} ',
      [sev.WARN]  = '\u{F529} ',
      [sev.INFO]  = '\u{F449} ',
      [sev.HINT]  = '\u{F835} ',
    },
  },
})
