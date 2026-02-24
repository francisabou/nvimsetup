-- Mason-free, lsp-zero 3.x, lazy-nvim structure intact
local lsp = require("lsp-zero")

---------------------------------------------------------------------------
-- 0.  Default keymaps on attach
---------------------------------------------------------------------------
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)
-- show diagnostics in a floating window
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
-- send all diagnostics to the location list and open it
vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Diagnostics to loclist" })
vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, { noremap = true, silent = true })
---------------------------------------------------------------------------
-- 1.  Register the servers you installed manually
---------------------------------------------------------------------------
lsp.setup_servers({
    "clangd",   -- C/C++
    "texlab",   -- LaTeX
    "fortls",   -- Fortran
    "cmake",    -- CMake
    "lua_ls",   -- Lua
    "pyright",  -- Python
})

---------------------------------------------------------------------------
-- 2.  Extra config for Lua (Neovim globals)
---------------------------------------------------------------------------
local lua_opts = lsp.nvim_lua_ls()
require("lspconfig").lua_ls.setup(lua_opts)

---------------------------------------------------------------------------
-- 3.  FINALISE   ←------ this is the call we missed
---------------------------------------------------------------------------
lsp.setup()           -- <-- injects capabilities & default cmp setup

---------------------------------------------------------------------------
-- 4.  nvim-cmp: add sources so items appear
---------------------------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<S-tab>"]     = cmp.mapping.select_prev_item(),
    ["<Tab>"]     = cmp.mapping.select_next_item(),
    ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  },

  -- ↓↓↓ At least one LSP source is mandatory
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip"  },
    { name = "buffer"   },
    { name = "path"     },
  },
})

-- Recommended: makes the popup behave like VSCode
vim.o.completeopt = "menu,menuone,noselect"
