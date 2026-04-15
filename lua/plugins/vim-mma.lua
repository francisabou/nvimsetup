return {
    {
        "voldikss/vim-mma",
        ft = { "mma" },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "mma",
                group = vim.api.nvim_create_augroup("wolfram-repl", { clear = true }),
                desc = "Wolfram: REPL overrides and conceal",
                callback = function(args)
                    local buf = args.buf

                    local resolve_terminal = require("Francis.utils").resolve_terminal

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