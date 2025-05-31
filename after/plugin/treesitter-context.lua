require("treesitter-context").setup {
  enabled               = true,    -- Start with the context window enabled (toggle with :TSContext enable/disable)
  multi_window          = false,   -- When true, show context in all windows; when false, only the current window
  max_lines             = 0,       -- How many lines the floating context window may span. Values <= 0 mean “no limit”
  min_window_height     = 0,       -- Minimum total editor‐window height (in lines) required to enable context. Values ≤ 0 mean “no limit”
  line_numbers          = true,    -- Show line numbers on each context line
  multiline_threshold   = 20,      -- If a single context node spans more than this many lines, collapse it to a single line
  trim_scope            = "outer", -- When the context exceeds allowed lines (via max_lines), discard outer lines first (choices: "inner" | "outer")
  mode                  = "cursor",-- Which line to use when determining context: "cursor" (current cursor line) or "topline" (top visible line)
  separator             = nil,     -- Single-character string drawn between context and main buffer (nil = no separator)
  zindex                = 20,      -- Z-index of the floating context window (higher = drawn on top of other floats)
  on_attach             = nil,     -- (fun(buf: integer): boolean) Return false to disable attaching to a given buffer
}
