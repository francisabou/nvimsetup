return {
    {
        "ThePrimeagen/99",
        event = "VeryLazy",
        config = function()
            local _99 = require("99")

            -- For logging that is to a file if you wish to trace through requests
            -- for reporting bugs, i would not rely on this, but instead the provided
            -- logging mechanisms within 99.  This is for more debugging purposes
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                -- provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
                logger = {
                    type = "file",
                    level = _99.DEBUG,
                    path = "/tmp/" .. basename .. ".99.debug",
                    print_on_error = true,
                },
                -- When setting this to something that is not inside the CWD tools
                -- such as claude code or opencode will have permission issues
                -- and generation will fail refer to tool documentation to resolve
                -- https://opencode.ai/docs/permissions/#external-directories
                -- https://code.claude.com/docs/en/permissions#read-and-edit
                tmp_dir = "./tmp",

                --- Completions: #rules and @files in the prompt buffer
                completion = {
                    -- I am going to disable these until i understand the
                    -- problem better.  Inside of cursor rules there is also
                    -- application rules, which means i need to apply these
                    -- differently
                    -- cursor_rules = "<custom path to cursor rules>"

                    --- A list of folders where you have your own SKILL.md
                    --- Expected format:
                    --- /path/to/dir/<skill_name>/SKILL.md
                    ---
                    --- Example:
                    --- Input Path:
                    --- "scratch/custom_rules/"
                    ---
                    --- Output Rules:
                    --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
                    --- ... the other rules in that dir ...
                    ---
                    custom_rules = {
                        "scratch/custom_rules/",
                    },

                    --- Configure @file completion (all fields optional, sensible defaults)
                    files = {
                        -- enabled = true,
                        -- max_file_size = 102400,     -- bytes, skip files larger than this
                        -- max_files = 5000,            -- cap on total discovered files
                        -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
                    },

                    --- What autocomplete you use.
                    --- Changed from "cmp" to "blink" to match blink.cmp migration
                    source = "blink",
                },

                --- WARNING: if you change cwd then this is likely broken
                --- ill likely fix this in a later change
                ---
                --- md_files is a list of files to look for and auto add based on the location
                --- of the originating request.  That means if you are at /foo/bar/baz.lua
                --- the system will automagically look for:
                --- /foo/bar/AGENT.md
                --- /foo/AGENT.md
                --- assuming that /foo is project root (based on cwd)
                md_files = {
                    "AGENT.md",
                },
            })

            -- -------- Model persistence --------
            local model_path = vim.fn.stdpath("data") .. "/99-model.txt"

            local function load_saved_model()
                local f = io.open(model_path, "r")
                if not f then return nil end
                local model = f:read("*a")
                f:close()
                if model and model ~= "" then return model end
                return nil
            end

            local function save_model(model)
                local f = io.open(model_path, "w")
                if not f then return end
                f:write(model)
                f:close()
            end

            -- Restore saved model
            local saved_model = load_saved_model()
            if saved_model then
                _99.set_model(saved_model)
            end

            -- Wrap set_model to persist on every change
            local orig_set_model = _99.set_model
            _99.set_model = function(model)
                local result = orig_set_model(model)
                save_model(model)
                return result
            end

            -- take extra note that i have visual selection only in v mode
            -- technically whatever your last visual selection is, will be used
            -- so i have this set to visual mode so i dont screw up and use an
            -- old visual selection
            --
            -- likely i'll add a mode check and assert on required visual mode
            -- so just prepare for it now
            vim.keymap.set("v", "<leader>9v", function()
                _99.visual()
            end, { desc = "99: Visual prompt" })

            --- if you have a request you dont want to make any changes, just cancel it
            vim.keymap.set("n", "<leader>9x", function()
                _99.stop_all_requests()
            end, { desc = "99: Stop all requests" })

            vim.keymap.set("n", "<leader>9s", function()
                _99.search()
            end, { desc = "99: Search" })

            -- Model picker (<leader>9m) -- uses fzf-lua extension
            vim.keymap.set("n", "<leader>9m", function()
                local ok, ext = pcall(require, "99.extensions.fzf_lua")
                if ok then
                    ext.select_model()
                else
                    vim.notify("99: fzf-lua picker extension not available", vim.log.levels.WARN)
                end
            end, { desc = "99: Select AI Model" })

            -- Provider picker (<leader>9p) -- switches provider AND resets model
            vim.keymap.set("n", "<leader>9p", function()
                local ok, ext = pcall(require, "99.extensions.fzf_lua")
                if ok then
                    ext.select_provider()
                else
                    vim.notify("99: fzf-lua picker extension not available", vim.log.levels.WARN)
                end
            end, { desc = "99: Select AI Provider" })
        end,
    },
}
