vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>q", function()
    vim.diagnostic.setloclist({ open = true })
end, { desc = "Diagnostics to loclist" })

-- LSP keymaps on attach
-- Built-in 0.12 globals: K (hover), grr (references), grn (rename),
-- gra (code action), gri (implementation), grt (type def), gO (symbols)
local lsp_group = vim.api.nvim_create_augroup("francis-lsp-attach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local bufnr = args.buf
        local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buf = bufnr, desc = desc })
        end

        map("<leader>gd", vim.lsp.buf.definition, "LSP: Go to definition")

        -- Inlay hints (off by default; toggle with <leader>ih)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.supports_method("textDocument/inlayHint") then
            map("<leader>ih", function()
                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
            end, "LSP: Toggle inlay hints")
        end
    end,
})
