return {
    {
        "Civitasv/cmake-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun", "CMakeClean", "CMakeSelectBuildType" },
        opts = {
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
            cmake_soft_link_compile_commands = true,
            cmake_regenerate_on_save = true,
            cmake_build_directory = "out/${variant:buildType}",
        },
        keys = {
            { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake : generate" },
            { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake : build" },
            { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake : run" },
            { "<leader>ct", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake : select build type" },
            { "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake : clean" },
        },
    },
}
