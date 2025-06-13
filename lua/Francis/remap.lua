vim.g.mapleader = " "
vim.keymap.set('i','jk','<Esc>')
-- somewhere after your oil `setup()`
vim.keymap.set("n", "<leader>pv", function()
  require('oil').open()        -- open in the current window
  -- or: require('oil').open_float()  -- floating window
end, { desc = "Oil file explorer" })
