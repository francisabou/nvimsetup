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
                    accept = "<D-l>",
                    accept_word = "<D-w>",
                    accept_line = "<D-e>",
                    next = "<D-]>",
                    prev = "<D-[>",
                    dismiss = "<C-]>",
                },
            },
            panel = { enabled = false },
        },
    },
}
