-- Disable netrw (oil.nvim replaces it)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.guicursor = ""

vim.opt.nu = true --Line numbers
vim.opt.relativenumber = true --Relative line numbers

--4 space indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true --Line wrap
vim.opt.linebreak = true --Break at word boundaries

--No back ups, but long undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false --No persistent search highlight
vim.opt.incsearch = true --Incremental search

vim.opt.scrolloff = 8 --Always 8 lines down, but not at EOF
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 200 --Fast update time (gitsigns already debounces at 200ms)

vim.opt.cmdheight = 0

vim.opt.textwidth = 80
vim.opt.formatoptions:remove("t") -- don't auto-wrap code; use gq for manual reflow
-- vim.opt.colorcolumn = "80"
