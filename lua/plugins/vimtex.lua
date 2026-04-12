return {
    {
        "lervag/vimtex",
        ft = "tex",
        -- init runs BEFORE the plugin loads (vim.g.* must be set early)
        init = function()
            vim.g.vimtex_indent_enabled = 1
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_continuous = 1
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_compiler_latexmk = {
                options = { "-pdf", "-interaction=nonstopmode", "-output-directory=out" },
            }
        end,
        -- config runs AFTER the plugin loads
        config = function()
            -- Make sure "out/" exists anytime main.tex is entered/loaded
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
                group = vim.api.nvim_create_augroup("vimtex-outdir", { clear = true }),
                pattern = { "*main.tex" },
                callback = function(args)
                    local bufnr = args.buf
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    local dir = vim.fn.fnamemodify(bufname, ":p:h")
                    local outdir = dir .. "/out"

                    if vim.fn.isdirectory(outdir) == 0 then
                        vim.fn.mkdir(outdir, "p")
                    end

                    vim.b[bufnr].vimtex_root = dir
                end,
            })
        end,
    },
}
