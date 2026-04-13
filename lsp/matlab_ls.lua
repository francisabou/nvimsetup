local function find_matlab()
    local matches = vim.fn.glob("/Applications/MATLAB_R*.app", false, true)
    if #matches > 0 then
        table.sort(matches)
        return matches[#matches]
    end
    return ""
end

return {
    settings = {
        MATLAB = {
            installPath = find_matlab(),
        },
    },
}
