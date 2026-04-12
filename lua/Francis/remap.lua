-- Personal Shortcuts
-- mapleader is set in init.lua (before any require calls)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert blank line below" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert blank line above" })
vim.keymap.set("n", "<leader>u", function()
    vim.cmd("packadd nvim.undotree")
    require("undotree").open()
end, { desc = "Open undotree" })
