-- Personal Shortcuts
vim.g.mapleader = " " -- Defining leader character
vim.keymap.set('i','jk','<Esc>') -- Exit insert mode 
vim.keymap.set("n", "<leader>pv", function()
    require('oil').open()
    end, { desc = "Oil file explorer" }) -- Going back to file tree
vim.keymap.set("n","<leader>o","o<Esc>") -- Insert a new line below
vim.keymap.set("n","<leader>O","O<Esc>") -- Insert a new line above
