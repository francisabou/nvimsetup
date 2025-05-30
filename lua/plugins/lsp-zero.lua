return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    config = false,

    dependencies = {
      -- load Mason stack *eagerly* -----------------------------
      { "williamboman/mason.nvim",         build = ":MasonUpdate", lazy = false },
      { "williamboman/mason-lspconfig.nvim",                   lazy = false },

      -- core LSP -----------------------------------------------
      "neovim/nvim-lspconfig",

      -- completion (already eager) -----------------------------
      { "hrsh7th/nvim-cmp",         lazy = false },
      { "hrsh7th/cmp-nvim-lsp",     lazy = false },
      { "L3MON4D3/LuaSnip",         lazy = false },
      { "saadparwaiz1/cmp_luasnip", lazy = false },
    },
  },
}
