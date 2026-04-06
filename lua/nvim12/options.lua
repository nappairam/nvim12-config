-- Leader key (must be set before keymaps)
vim.g.mapleader = ' '

-- Completion
vim.o.autocomplete = true
vim.o.pumborder = 'rounded'
vim.o.pummaxwidth = 40
vim.o.completeopt = 'menu,menuone,noselect,nearest'

-- Mouse (override mini.basics 'a' to exclude insert mode)
vim.o.mouse = 'nv'

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Search
vim.o.hlsearch = true
vim.o.showmatch = true

-- Display
vim.opt.fillchars:append({ vert = '│' })
vim.o.formatoptions = 'jtcroql'
vim.o.encoding = 'utf-8'
vim.o.colorcolumn = '81,96,98,100'
vim.o.listchars = 'tab:→-,trail:▓,eol:↴'
vim.o.list = true
vim.o.wrap = true
vim.o.numberwidth = 5
vim.o.conceallevel = 0
vim.o.laststatus = 3
vim.o.cmdheight = 1
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

-- Behavior
vim.o.clipboard = 'unnamedplus'
vim.o.swapfile = false
vim.o.updatetime = 500
vim.o.timeoutlen = 3000
vim.o.autoread = true
vim.o.redrawtime = 500
vim.o.switchbuf = 'useopen'
vim.o.hidden = true
vim.o.backspace = 'indent,eol,start'
vim.o.inccommand = 'nosplit'
vim.o.wildmode = 'full'
vim.o.emoji = false

-- Transparency
vim.o.winblend = 25
vim.o.pumblend = 25

-- Diff
vim.o.diffopt = 'internal,filler,closeoff,algorithm:patience,iwhiteall'

-- Folding
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- macOS clipboard
if vim.uv.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = { ['+'] = 'pbcopy', ['*'] = 'pbcopy' },
    paste = { ['+'] = 'pbpaste', ['*'] = 'pbpaste' },
    cache_enabled = false,
  }
end
