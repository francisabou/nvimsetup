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
                    accept = "<D-h>",
                    accept_word = "<D-j>",
                    accept_line = "<D-k>",
                    next = "<D-]>",
                    prev = "<D-[>",
                    dismiss = "<C-]>",
                },
            },
            panel = { enabled = false },
        },
    },
}
