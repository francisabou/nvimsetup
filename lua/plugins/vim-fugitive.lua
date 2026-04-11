return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gvdiffsplit", "Glog", "Gdiffsplit" },
        keys = {
            { "<leader>gs", vim.cmd.Git, desc = "Fugitive: Git status" },
        },
    },
}
