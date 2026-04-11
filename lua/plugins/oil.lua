return {
    {
        "stevearc/oil.nvim",
        lazy = false,
        keys = {
            { "<leader>pv", function() require("oil").open() end, desc = "Oil file explorer" },
        },
        opts = {
            delete_to_trash = true,
            view_options = { show_hidden = true },
        },
    },
}
