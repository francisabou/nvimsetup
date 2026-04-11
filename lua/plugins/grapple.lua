return {
    {
        "otavioschwanck/arrow.nvim",
        dependencies = {
            { "echasnovski/mini.icons", lazy = true },
        },
        opts = {
            show_icons = true,
            leader_key = "<C-e>",
            save_key = "git_root",
        },
        keys = {
            { "<leader>a", function() require("arrow.persist").toggle() end, desc = "Arrow toggle file" },
            { "<C-e>", function() require("arrow.ui").openMenu() end, desc = "Arrow menu" },

            { "<C-h>", function() require("arrow.persist").go_to(1) end, desc = "Arrow go to 1" },
            { "<C-j>", function() require("arrow.persist").go_to(2) end, desc = "Arrow go to 2" },
            { "<C-k>", function() require("arrow.persist").go_to(3) end, desc = "Arrow go to 3" },
            { "<C-l>", function() require("arrow.persist").go_to(4) end, desc = "Arrow go to 4" },

            { "<C-S-P>", function() require("arrow.persist").previous() end, desc = "Arrow prev" },
            { "<C-S-N>", function() require("arrow.persist").next() end, desc = "Arrow next" },
        },
    },
}
