return {
    {
        "MeanderingProgrammer/harpoon-core.nvim",
        config = function()
            require("harpoon-core").setup({
                mark_branch = false,
                use_existing = true,
                use_cursor = true,
                menu = { icons = false, width = 0.5, height = 0.5 },
            })
        end,
        keys = {
            {
                "<leader>a",
                function()
                    require("harpoon-core").add_file()
                end,
                desc = "Harpoon add file",
            },
            {
                "<C-e>",
                function()
                    require("harpoon-core").toggle_quick_menu()
                end,
                desc = "Harpoon edit list",
            },

            {
                "<C-h>",
                function()
                    require("harpoon-core").nav_file(1)
                end,
                desc = "Harpoon go to 1",
            },
            {
                "<C-j>",
                function()
                    require("harpoon-core").nav_file(2)
                end,
                desc = "Harpoon go to 2",
            },
            {
                "<C-k>",
                function()
                    require("harpoon-core").nav_file(3)
                end,
                desc = "Harpoon go to 3",
            },
            {
                "<C-l>",
                function()
                    require("harpoon-core").nav_file(4)
                end,
                desc = "Harpoon go to 4",
            },

            {
                "<C-S-P>",
                function()
                    require("harpoon-core").nav_prev()
                end,
                desc = "Harpoon prev",
            },
            {
                "<C-S-N>",
                function()
                    require("harpoon-core").nav_next()
                end,
                desc = "Harpoon next",
            },
        },
    },
}
