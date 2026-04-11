-- Always search from project root (git root), regardless of cwd
local function project_root()
    return vim.fs.root(0, ".git") or vim.uv.cwd()
end

return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons" },
        opts = {},
        keys = {
            {
                "<leader>pf",
                function()
                    require("fzf-lua").files({ cwd = project_root() })
                end,
                desc = "Find files (project root)",
            },
            {
                "<C-p>",
                function()
                    require("fzf-lua").git_files({ cwd = project_root() })
                end,
                desc = "Git files (project root)",
            },
            {
                "<leader>ps",
                function()
                    require("fzf-lua").grep({ search = vim.fn.input("Grep > "), cwd = project_root() })
                end,
                desc = "Grep string (project root)",
            },
            {
                "<leader>pg",
                function()
                    require("fzf-lua").live_grep({ cwd = project_root() })
                end,
                desc = "Live grep (project root)",
            },
        },
    },
}
