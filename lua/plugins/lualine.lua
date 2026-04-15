return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            -- Build a transparent variant of the auto theme
            local custom_theme = require("lualine.themes.auto")
            for _, mode in pairs(custom_theme) do
                for _, section in pairs(mode) do
                    if type(section) == "table" then
                        section.bg = "NONE"
                    end
                end
            end

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = custom_theme,
                    component_separators = { left = "\xee\x82\xb1", right = "\xee\x82\xb3" },
                    section_separators = { left = "\xee\x82\xb0", right = "\xee\x82\xb2" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                        refresh_time = 16, -- ~60fps
                        events = {
                            "WinEnter",
                            "BufEnter",
                            "BufWritePost",
                            "SessionLoadPost",
                            "FileChangedShellPost",
                            "VimResized",
                            "Filetype",
                            "CursorMoved",
                            "CursorMovedI",
                            "ModeChanged",
                        },
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
}
