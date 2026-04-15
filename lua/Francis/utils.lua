local M = {}

--- Resolve all active terminal channels.
--- Checks buffer-local slime config first, then vim-slime auto-detect, then manual scan.
---@return integer[] channels
function M.resolve_terminal()
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

return M
