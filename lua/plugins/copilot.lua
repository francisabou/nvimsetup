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
                    accept = "<M-a>",
                    accept_word = "<M-w>",
                    accept_line = "<M-l>",
                    next = "<M-n>",
                    prev = "<M-p>",
                    dismiss = "<M-d>",
                },
            },
            panel = { enabled = false },
        },
    },
}
