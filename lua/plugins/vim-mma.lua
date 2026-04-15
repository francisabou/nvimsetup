return {
    {
        "voldikss/vim-mma",
        ft = { "mma" },
        init = function()
            vim.g.mma_auto_collapse = 0
        end,
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "mma",
                group = vim.api.nvim_create_augroup("wolfram-repl", { clear = true }),
                desc = "Wolfram: REPL overrides and conceal",
                callback = function(args)
                    local buf = args.buf

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

                    vim.keymap.set("n", "<leader>rq", function()
                        local chans = resolve_terminal()
                        if #chans == 0 then
                            vim.notify("No Wolfram REPL found", vim.log.levels.WARN)
                            return
                        end
                        for _, ch in ipairs(chans) do
                            vim.fn.chansend(ch, "Quit[]\n")
                        end
                    end, { buf = buf, desc = "Wolfram: Quit kernel" })

                    vim.keymap.set("n", "<leader>rt", function()
                        local cur = vim.opt_local.conceallevel:get()
                        vim.opt_local.conceallevel = cur == 0 and 2 or 0
                    end, { buf = buf, desc = "Wolfram: Toggle conceal" })
                end,
            })
        end,
    },
}