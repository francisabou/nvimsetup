return {
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        opts = {
            notification = {
                override_vim_notify = true, -- route all vim.notify() through fidget
            },
        },
    },
}
