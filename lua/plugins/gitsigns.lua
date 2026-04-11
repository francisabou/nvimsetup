return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Custom sign characters (thinner pipes than default)
      opts.signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        untracked    = { text = "│" },
      }

      -- Non-default overrides only
      opts.max_file_length = 50000
      opts.update_debounce = 200
      opts.sign_priority   = 9

      -- Blame (custom formatter + faster delay)
      opts.current_line_blame_opts = {
        delay             = 200,
        ignore_whitespace = true,
      }
      opts.current_line_blame_formatter = "<author>, <author_time:%R> • <summary>"

      -- Nice preview window
      opts.preview_config = {
        style    = "minimal",
        relative = "cursor",
        row      = 0,
        col      = 1,
        border   = "rounded",
      }

      -- Full-featured buffer-local keymaps
      opts.on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buf = bufnr, desc = "Git: " .. desc })
        end

        -- Navigation (smart — works in vim diff mode too)
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")

        -- Actions
        map("n", "<leader>ghs", gs.stage_hunk, "Stage Hunk")
        map("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
        map("n", "<leader>ghr", gs.reset_hunk, "Reset Hunk")
        map("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")

        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")

        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghi", gs.preview_hunk_inline, "Preview Hunk Inline")

        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line (Full)")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")

        -- Toggles
        map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle Line Blame")
        map("n", "<leader>gtw", gs.toggle_word_diff, "Toggle Word Diff")
        map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Deleted Lines")

        -- Text object
        map({ "o", "x" }, "ih", gs.select_hunk, "Select Hunk")
      end
    end,

    keys = {
      {
        "<leader>tg",
        function()
          require("gitsigns").toggle_signs()
          vim.notify("Git Signs: toggled", vim.log.levels.INFO)
        end,
        desc = "Toggle Git Signs",
      },
    },
  },
}
