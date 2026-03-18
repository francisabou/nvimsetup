return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            {
                "<leader>cp",
                function()
                    require("copilot.suggestion").toggle_auto_trigger()
                end,
                desc = "Copilot: Toggle inline suggestions",
            },
        },
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<leader>aa",
                    accept_word = "<leader>aw",
                    accept_line = "<leader>al",
                    next = "<leader>an",
                    prev = "<leader>ab",
                    dismiss = "<leader>ad",
                },
            },
            panel = { enabled = false },
        },
    },
}
