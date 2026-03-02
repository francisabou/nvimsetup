-- ~/.config/nvim/lua/plugins/gitsigns.lua
-- Official recommended + error-free version (March 2026)

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",

    opts = function(_, opts)
      -- Thicker, clearly visible signs (classic style everyone uses)
      opts.signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "│" },
      }
      opts.signs_staged = opts.signs   -- same style for staged changes

      -- Recommended quality-of-life options
      opts.signs_staged_enable = true
      -- opts.current_line_blame = true        -- uncomment if you want blame always visible
      opts.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 200,
        ignore_whitespace = true,
      }
      opts.current_line_blame_formatter = "<author>, <author_time:%R> • <summary>"

      opts.word_diff = false
      opts.max_file_length = 50000          -- handles huge files
      opts.update_debounce = 200
    end,

    -- Remove LazyVim's conflicting <leader>uG toggle + add your custom one
    keys = {
      { "<leader>uG", false },

      {
        "<leader>tg",
        function()
          require("gitsigns").toggle_signs()
          local state = require("gitsigns.config").config.signcolumn
          vim.notify("Git Signs: " .. (state and "ON" or "OFF"), vim.log.levels.INFO)
        end,
        desc = "Toggle Git Signs",
      },
    },
  },
}
