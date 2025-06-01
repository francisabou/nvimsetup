return {
  {
    -- 1) The core nvim-dap plugin:
    "mfussenegger/nvim-dap",
    dependencies = {
      -- 2) Optional UI sidebar (must load after 'nvim-dap'):
      "rcarriga/nvim-dap-ui",
      'nvim-neotest/nvim-nio',
      -- 3) Optional inline virtual-text (must load after 'nvim-dap'):
      --"theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      -- ──────── Begin DAP setup ────────

      -- 1) Try to load 'dap'; if it fails, abort early:
      local ok_dap, dap = pcall(require, "dap")
      if not ok_dap then
        return
      end

      -- 2) (Optional) Enable TRACE-level logging (goes to stdpath("cache").."/dap.log"):
      dap.set_log_level("TRACE")

      -- 3) If nvim-dap-ui is installed, set it up and hook its open/close listeners:
      local ok_ui, dapui_err_or_module = pcall(require, "dapui")
      if ok_ui then
          local dapui = dapui_err_or_module -- if pcall was successful, this is the dapui module
          dapui.setup()
          vim.notify("nvim-dap-ui loaded and setup successfully!", vim.log.levels.INFO)

          dap.listeners.after.event_initialized["dapui_config"] = function()
              vim.notify("DAP Initialized: Opening dapui", vim.log.levels.DEBUG)
              dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
              vim.notify("DAP Terminated: Closing dapui", vim.log.levels.DEBUG)
              dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
              vim.notify("DAP Exited: Closing dapui", vim.log.levels.DEBUG)
              dapui.close()
          end
      else
          -- THIS WILL SHOW THE ORIGINAL ERROR FROM WITHIN YOUR CONFIG
          vim.notify("Failed to load nvim-dap-ui within nvim-dap config: " .. tostring(dapui_err_or_module), vim.log.levels.ERROR, {title = "nvim-dap-ui Load Error"})
      end
      -- 4) If nvim-dap-virtual-text is installed, set it up:
      local ok_vt, dapvt = pcall(require, "nvim-dap-virtual-text")
      if ok_vt then
        dapvt.setup({
          enabled                     = true,
          highlight_changed_variables = true,
          show_stop_reason            = true,
        })
      end

      -- 5) Define adapters:
      -- 5a) LLDB (macOS xcrun lldb-dap)
      dap.adapters.lldb = {
        type = "server",
        port = "${port}",  -- nvim-dap will replace this at runtime
        executable = {
          command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
          args    = { "--port", "${port}" },
        },
        name = "lldb",
      }

      -- 5b) GDB (fortran)
      dap.adapters.gdb = {
        type    = "executable",
        command = "gdb",

      }

      -- 5c) Python (debugpy)
      dap.adapters.python = {
        type    = "executable",
        command = "/usr/bin/python3", -- adjust if needed
        args    = { "-m", "debugpy.adapter" },
      }

      -- 6) Define configurations:
      -- 6a) C/C++ (use LLDB):
      dap.configurations.cpp = {
        {
          name        = "Launch C++ (lldb)",
          type        = "lldb", -- matches dap.adapters.lldb
          request     = "launch",
          program     = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/out/Debug",
              "file"
            )
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
          args        = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp  -- same as C++

      -- 6b) Fortran (use GDB):
      dap.configurations.fortran = {
        {
          name        = "Launch Fortran (gdb)",
          type        = "gdb",    -- matches dap.adapters.gdb
          request     = "launch",
          program     = function()
            return vim.fn.input(
              "Path to Fortran exe: ",
              vim.fn.getcwd() .. "/out/Debug",
              "file"
            )
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
          args        = {},
        },
      }

      -- 6c) Python (use debugpy):
      dap.configurations.python = {
        {
          name       = "Launch Python file",
          type       = "python", -- matches dap.adapters.python
          request    = "launch",
          program    = "${file}", -- current file
          pythonPath = function()
            return "/usr/bin/python3"
          end,
        },
      }

      -- 7) (Optional) Key mappings for common DAP actions:
      --    You can remove or change these if you prefer other mappings.
      local map = vim.keymap.set
      map("n", "<Leader>dc", dap.continue,          { desc = "DAP: Continue" })
      map("n", "<Leader>so", dap.step_over,         { desc = "DAP: Step Over" })
      map("n", "<Leader>si", dap.step_into,         { desc = "DAP: Step Into" })
      map("n", "<Leader>se", dap.step_out,          { desc = "DAP: Step Out" })
      map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      map("n", "<Leader>dr", dap.repl.open,         { desc = "DAP: Open REPL" })
      map("n", "<Leader>dl", dap.run_last,          { desc = "DAP: Run Last" })

      -- ──────── End DAP setup ────────
    end,
  },

  -- ── You can list additional plugins here ──
}
