local opt = vim.opt           -- global/buffer/windows-scoped options

opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard

opt.guicursor = ""

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true

opt.wrap = true

-- opt.swapfile = false
-- opt.backup = false
-- opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

vim.g.mapleader = " "

-- Set netrw to display detailed listing by default
vim.g.netrw_liststyle = 1

-- Display such an arrow when wrapping lines
opt.showbreak = "↘"

vim.opt.listchars = {
  tab = "  ", -- »
  space = " ",
  eol = "↴",
}

opt.list = true
