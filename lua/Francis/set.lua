-- Disable netrw (oil.nvim replaces it)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.guicursor = ""

vim.opt.nu = true  --Line numbers
vim.opt.relativenumber = true --Relative line numbers

--4 space indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true  --Line wrap

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

vim.opt.updatetime = 50 --Fast update time

vim.opt.cmdheight=0

-- Readable mode labels for statusline (cmdheight=0 means this is the only indicator)
local M = {}

local modes = {
    n = "NOR", i = "INS", v = "VIS", V = "V-L",
    ["\22"] = "V-B", c = "CMD", R = "REP", s = "SEL",
    S = "S-L", ["\19"] = "S-B", t = "TER", nt = "N-T",
}

function M.mode()
    local m = vim.api.nvim_get_mode().mode
    return modes[m] or m:upper()
end

vim.opt.statusline = table.concat({
    " ",
    " ",
    "%f",                            -- file path
    " %y",                           -- filetype
    " %m",                           -- [+] if modified
    " %{%v:lua.require('Francis.set').mode()%}", -- readable mode label
    " %= ",                          -- right-align the rest
    "%l,%c",                         -- line and column
    " ",
    " %P",                           -- percentage through file
    " ",
    " ",
})
vim.opt.textwidth = 80
-- vim.opt.colorcolumn = "80"

return M
