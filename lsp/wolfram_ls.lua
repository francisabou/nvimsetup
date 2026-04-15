local wolfram_kernel = vim.fn.exepath("WolframKernel")
if wolfram_kernel == "" then
    wolfram_kernel = "WolframKernel"
end

return {
    cmd = {
        wolfram_kernel,
        "-noinit",
        "-noprompt",
        "-nopaclet",
        "-noicon",
        "-nostartuppaclets",
        "-run",
        'Needs["LSPServer`"];LSPServer`StartServer[]',
    },
    filetypes = { "mma" },
    root_markers = { ".wlproject", ".wl", ".git" },
    on_attach = function(client, _)
        client.server_capabilities.semanticTokensProvider = nil
    end,
}