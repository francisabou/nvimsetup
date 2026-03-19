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
                    accept = "`h",
                    accept_word = "`j",
                    accept_line = "`k",
                    next = "`]",
                    prev = "`[",
                    dismiss = "<C-]>",
                },
            },
            panel = { enabled = false },
        },
    },
}
