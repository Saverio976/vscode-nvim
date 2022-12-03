vim.opt.cmdheight = 0

vim.opt.undofile = true

vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

vim.opt.backspace = 'indent,start,eol'

vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftround = true

vim.opt.showmatch = true

vim.opt.ruler = true
vim.opt.colorcolumn = '80'

vim.opt.number = true

vim.opt.fileformat = 'unix'

vim.opt.timeout = true
vim.opt.timeoutlen = 500

vim.opt.list = true
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append "trail:⋅"
vim.opt.listchars:append "tab: ▷"

vim.opt.fillchars:append "eob: "
vim.opt.fillchars:append "fold: "
vim.opt.fillchars:append "foldopen:"
vim.opt.fillchars:append "foldsep: "
vim.opt.fillchars:append "foldclose:"
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

