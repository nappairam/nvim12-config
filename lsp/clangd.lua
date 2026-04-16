return {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = { 'compile_commands.json', '.clangd', 'Makefile', '.git' },
  single_file_support = true,
}
