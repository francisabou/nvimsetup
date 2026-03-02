-- ~/.config/nvim/lua/plugins/gitsigns.lua
-- Official recommended config + built-in toggle (using Lazy.nvim `keys` table — most reliable method)

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",

    opts = function(_, opts)
      -- Thicker, clearly visible signs (classic style — the #1 recommended change)
      opts.signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "│" },
      }
      opts.signs_staged = opts.signs   -- same visible style for staged changes

      -- Popular quality-of-life options
      opts.signs_staged_enable = true
      -- opts.current_line_blame = true        -- uncomment if you want always-on blame
      opts.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 200,
        ignore_whitespace = true,
      }
      opts.current_line_blame_formatter = "<author>, <author_time:%R> • <summary>"

      opts.word_diff = false
      opts.max_file_length = 50000
      opts.update_debounce = 200

      -- Preserve ALL LazyVim default keymaps (]h, <leader>ghs, blame, staging, etc.)
      local default_on_attach = opts.on_attach
      opts.on_attach = function(buffer)
        default_on_attach(buffer)
      end
    end,

    keys = {
      -- Remove LazyVim's default conflicting <leader>uG toggle
      { "<leader>uG", false },

      -- YOUR CUSTOM TOGGLE (registered reliably by Lazy.nvim)
      {
        "<leader>tg",
        function()
          require("gitsigns").toggle_signs()   -- toggles ON/OFF
          local state = require("gitsigns.config").config.signcolumn
          vim.notify("Git Signs: " .. (state and "ON" or "OFF"), vim.log.levels.INFO)
        end,
        desc = "Toggle Git Signs",
      },
    },
  },
}
