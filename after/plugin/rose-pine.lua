require("rose-pine").setup({
  variant           = "moon",        -- or "dawn" / "main"
  disable_background = true,         -- ← turn off bg
  -- you can keep other options here…
})
color=color or "rose-pine"
vim.cmd.colorscheme(color)
vim.api.nvim_set_hl(0,"Normal",{bg=none})
vim.api.nvim_set_hl(0,"NormalFloat",{bg=none})
