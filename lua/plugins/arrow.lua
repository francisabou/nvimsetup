return {
    {
        "otavioschwanck/arrow.nvim",
        dependencies = {
            { "echasnovski/mini.icons", lazy = true },
        },
        config = function()
            require("arrow").setup({
                show_icons = false,
                hide_handbook = true,
                leader_key = "<C-e>",
                save_key = "git_root",
                window = { border = "single" },
            })
            -- Override arrow's leader_key mapping to open edit mode (harpoon-style)
            vim.keymap.set("n", "<C-e>", function()
                require("arrow.persist").open_cache_file()
            end, { noremap = true, silent = true, nowait = true, desc = "Arrow edit list" })
        end,
        keys = {
            { "<leader>a", function() require("arrow.persist").toggle() end, desc = "Arrow toggle file" },
            { "<C-e>", desc = "Arrow edit list" },

            { "<C-h>", function() require("arrow.persist").go_to(1) end, desc = "Arrow go to 1" },
            { "<C-j>", function() require("arrow.persist").go_to(2) end, desc = "Arrow go to 2" },
            { "<C-k>", function() require("arrow.persist").go_to(3) end, desc = "Arrow go to 3" },
            { "<C-l>", function() require("arrow.persist").go_to(4) end, desc = "Arrow go to 4" },

            { "<C-S-P>", function() require("arrow.persist").previous() end, desc = "Arrow prev" },
            { "<C-S-N>", function() require("arrow.persist").next() end, desc = "Arrow next" },
        },
    },
}
