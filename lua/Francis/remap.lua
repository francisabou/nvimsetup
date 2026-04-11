-- Personal Shortcuts
-- mapleader is set in init.lua (before any require calls)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert blank line below" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert blank line above" })
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open, { desc = "Open undotree" })
