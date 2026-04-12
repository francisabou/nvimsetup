return {
    {
        -- 1) The core nvim-dap plugin:
        "mfussenegger/nvim-dap",
        dependencies = {
            -- 2) Optional UI sidebar (must load after 'nvim-dap'):
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            -- 3) Optional inline virtual-text (must load after 'nvim-dap'):
            --"theHamsta/nvim-dap-virtual-text",
        },
        cmd = { "DapContinue", "DapToggleBreakpoint" },
        keys = {
            {
                "<Leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "DAP: Continue",
            },
            {
                "<Leader>so",
                function()
                    require("dap").step_over()
                end,
                desc = "DAP: Step Over",
            },
            {
                "<Leader>si",
                function()
                    require("dap").step_into()
                end,
                desc = "DAP: Step Into",
            },
            {
                "<Leader>se",
                function()
                    require("dap").step_out()
                end,
                desc = "DAP: Step Out",
            },
            {
                "<Leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "DAP: Toggle Breakpoint",
            },
            {
                "<Leader>dr",
                function()
                    require("dap").repl.open()
                end,
                desc = "DAP: Open REPL",
            },
            {
                "<Leader>dl",
                function()
                    require("dap").run_last()
                end,
                desc = "DAP: Run Last",
            },
        },
        config = function()
            -- ──────── Begin DAP setup ────────

            local dap = require("dap")

            -- Log level: use WARN for daily use, switch to TRACE when debugging adapters
            dap.set_log_level("WARN")

            -- 3) If nvim-dap-ui is installed, set it up and hook its open/close listeners:
            local ok_ui, dapui_err_or_module = pcall(require, "dapui")
            if ok_ui then
                local dapui = dapui_err_or_module -- if pcall was successful, this is the dapui module
                dapui.setup()

                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close()
                end
            end
            -- 4) Define adapters:
            -- Helper: resolve executable from $PATH, warn if missing
            local function resolve_exe(name, fallback)
                local path = vim.fn.exepath(name)
                if path ~= "" then
                    return path
                end
                if fallback and vim.fn.exepath(fallback) ~= "" then
                    return vim.fn.exepath(fallback)
                end
                vim.notify("DAP: " .. name .. " not found on $PATH", vim.log.levels.WARN)
                return name -- return raw name so dap shows a clear error on launch
            end

            -- 5a) LLDB (resolved from $PATH, works across Homebrew/system/Linux)
            dap.adapters.lldb = {
                type = "executable",
                command = resolve_exe("lldb-dap", "lldb-vscode"),
                name = "lldb",
            }

            -- 5b) GDB (fortran)
            dap.adapters.gdb = {
                type = "executable",
                command = resolve_exe("gdb"),
                args = { "--interpreter=mi" },
            }

            -- 5c) Python (debugpy)
            dap.adapters.python = {
                type = "executable",
                command = resolve_exe("python3"),
                args = { "-m", "debugpy.adapter" },
            }

            -- 6) Define configurations:
            -- 6a) C/C++ (use LLDB):
            dap.configurations.cpp = {
                {
                    name = "Launch C++ (lldb)",
                    type = "lldb", -- matches dap.adapters.lldb
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/out/Debug/Main", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }
            dap.configurations.c = dap.configurations.cpp -- same as C++

            -- 6b) Fortran (use GDB):
            dap.configurations.fortran = {
                {
                    name = "Launch Fortran (gdb)",
                    type = "gdb", -- matches dap.adapters.gdb
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to Fortran exe: ", vim.fn.getcwd() .. "/out/Debug/Main", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }

            -- 6c) Python (use debugpy):
            dap.configurations.python = {
                {
                    name = "Launch Python file",
                    type = "python", -- matches dap.adapters.python
                    request = "launch",
                    program = "${file}", -- current file
                    pythonPath = function()
                        local venv = os.getenv("VIRTUAL_ENV")
                        if venv then
                            return venv .. "/bin/python3"
                        end
                        return resolve_exe("python3")
                    end,
                },
            }

            -- ──────── End DAP setup ────────
        end,
    },

    -- ── You can list additional plugins here ──
}
