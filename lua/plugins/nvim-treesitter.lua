return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local wanted_parsers = {
                "cpp",
                "latex",
                "fortran",
                "cmake",
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "python",
                "markdown",
                "markdown_inline",
                "bash",
                "json",
                "toml",
                "gitcommit",
                "diff",
                "matlab",
            }

            require("nvim-treesitter").setup({})

            -- Install missing parsers asynchronously
            pcall(function()
                require("nvim-treesitter").install(wanted_parsers)
            end)

            -- Enable treesitter highlighting via Nvim built-in (0.12+)
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup(
                    "treesitter-highlight",
                    { clear = true }
                ),
                desc = "Enable treesitter highlighting",
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
}
