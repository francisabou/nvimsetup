vim.opt.guicursor = ""

vim.opt.nu = true  --Line numbers
vim.opt.relativenumber = true --Relative line numbers

--4 space indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false  --Line wrap

--No back ups, but long undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false --Terms stay highlighted
vim.opt.incsearch = true --Incrimintal search

vim.opt.termguicolors = true --Colors

vim.opt.scrolloff = 8 --Always 8 lines down, but not at EOF
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50 --Fast unpdate time

vim.opt.cmdheight=0

-- init.lua (Neovim Lua)
vim.opt.statusline = table.concat({
    " ",
    " ",
    "%f",            -- file path
    " %y",           -- filetype
    " %m",           -- [+] if modified
    " %{mode()}",    -- show current mode code
    " %= ",          -- right‐align the rest
    "%l,%c",         -- line and column
    " ",
    " %P",           -- percentage through file
    " ",
    " ",
})
-- vim.opt.colorcolumn = "100" --Column at the right

-- In your Neovim config (init.lua)
vim.g.vimtex_indent_enabled = 1
