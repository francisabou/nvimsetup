return {
    { "mason-org/mason.nvim", build = ":MasonUpdate", lazy = false, opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
        opts = {
            ensure_installed = { "clangd", "texlab", "fortls", "cmake", "lua_ls", "pyright" },
            automatic_enable = true,
        },
    },
    { "neovim/nvim-lspconfig", lazy = false },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { "saghen/blink.compat", lazy = true, opts = {} },
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "none",
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-y>"] = { "select_and_accept", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 250 },
                list = { selection = { preselect = true, auto_insert = false } },
            },
            signature = { enabled = true },
            fuzzy = { implementation = "prefer_rust" },
        },
        opts_extend = { "sources.default" },
    },
}
