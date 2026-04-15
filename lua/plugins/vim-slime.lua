return {
    {
        "jpalardy/vim-slime",
        init = function()
            vim.g.slime_target = "neovim"
            vim.g.slime_no_mappings = 1
        end,
        keys = {
            { "<leader>rr", "<Plug>SlimeParagraphSend", mode = "n", remap = true, desc = "REPL: Send paragraph" },
            { "<leader>r", "<Plug>SlimeRegionSend", mode = "x", remap = true, desc = "REPL: Send selection" },
            { "<leader>rl", "<Plug>SlimeLineSend", mode = "n", remap = true, desc = "REPL: Send line" },
            { "<leader>rc", "<Plug>SlimeSendCell", mode = "n", remap = true, desc = "REPL: Send cell" },
            { "<leader>rv", "<Plug>SlimeConfig", mode = "n", remap = true, desc = "REPL: Reconfigure target" },
            { "<leader>rf", ":%SlimeSend<CR>", mode = "n", desc = "REPL: Send entire file" },
            { "<leader>ro", mode = "n", desc = "REPL: Open terminal" },
            { "<leader>ri", mode = "n", desc = "REPL: Interrupt" },
            { "<leader>rk", mode = "n", desc = "REPL: Force kill" },
        },
        config = function()
            vim.g.slime_input_pid = false
            vim.g.slime_suggest_default = true
            vim.g.slime_menu_config = true

            vim.g.slime_get_jobid = function()
                for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "terminal" then
                        local chan = vim.api.nvim_get_option_value("channel", { buf = bufnr })
                        if chan and chan > 0 then
                            return chan
                        end
                    end
                end
                return nil
            end

            local function resolve_terminal()
                if vim.b.slime_config and vim.b.slime_config.jobid then
                    return { vim.b.slime_config.jobid }
                end
                local auto = vim.g.slime_get_jobid and vim.g.slime_get_jobid()
                if auto then
                    return { auto }
                end
                local chans = {}
                for _, b in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_get_option_value("buftype", { buf = b }) == "terminal" then
                        local ch = vim.api.nvim_get_option_value("channel", { buf = b })
                        if ch and ch > 0 then
                            table.insert(chans, ch)
                        end
                    end
                end
                return chans
            end

            vim.keymap.set("n", "<leader>ro", function()
                vim.cmd("belowright split | terminal")
            end, { desc = "REPL: Open terminal" })

            vim.keymap.set("n", "<leader>ri", function()
                local chans = resolve_terminal()
                if #chans == 0 then
                    vim.notify("No terminal found", vim.log.levels.WARN)
                    return
                end
                for _, ch in ipairs(chans) do
                    vim.fn.chansend(ch, string.char(3))
                end
            end, { desc = "REPL: Interrupt (Ctrl-C)" })

            vim.keymap.set("n", "<leader>rk", function()
                local chans = resolve_terminal()
                if #chans == 0 then
                    vim.notify("No terminal found", vim.log.levels.WARN)
                    return
                end
                for _, ch in ipairs(chans) do
                    vim.fn.jobstop(ch)
                end
            end, { desc = "REPL: Force kill terminal" })

            local ok, wk = pcall(require, "which-key")
            if ok then
                wk.add({ "<leader>r", group = "REPL", mode = { "n", "x" } })
            end
        end,
    },
}