# AGENTS.md - Neovim Configuration

Personal Neovim configuration using **lazy.nvim** as the plugin manager.
This is a Lua-based config, not a traditional Vimscript setup.

## Repository Structure

```
init.lua                    -- Entry point: loads Francis/ and config/lazy
lua/
  Francis/
    init.lua                -- Loads remap.lua and set.lua
    remap.lua               -- Global keymaps (leader, navigation)
    set.lua                 -- Vim options (indent, UI, statusline)
  config/
    lazy.lua                -- lazy.nvim bootstrap and setup
  plugins/                  -- Plugin specs (lazy.nvim format, each returns a table)
    lsp-zero.lua            -- LSP + Mason + completion dependencies
    telescope.lua           -- Fuzzy finder
    nvim-treesitter.lua     -- Syntax highlighting
    harpoon2.lua            -- File navigation
    nvim-dap.lua            -- Debug adapter protocol
    cmake-tools.lua         -- CMake integration
    gitsigns.lua            -- Git signs + keymaps
    vimtex.lua              -- LaTeX support
    rose-pine.lua           -- Colorscheme
    oil.lua                 -- File explorer
    99.lua                  -- ThePrimeagen/99 AI plugin
    (others)                -- undotree, fugitive, todo-comments, etc.
after/plugin/               -- Post-load configuration (keymaps, setup calls)
  lsp-zero.lua              -- LSP server registration + cmp config
  telescope.lua             -- Telescope keymaps
  treesitter.lua            -- Treesitter parser list + highlight config
  harpoon2.lua              -- Harpoon keymaps
  rose-pine.lua             -- Colorscheme options
  (others)                  -- cmake-tools, vimtex, undotree, fugitive, etc.
```

## Build / Lint / Test Commands

This is a Neovim config, not a compiled project. There is no formal build
system, test suite, or linter configured for the config itself.

### Validating the configuration

```bash
# Check for Lua syntax errors across all config files
find ~/.config/nvim/lua -name '*.lua' -exec luac -p {} +

# Start Neovim and check for startup errors
nvim --headless "+lua print('OK')" +qa

# Check lazy.nvim plugin health
nvim --headless "+Lazy health" +qa

# Run Neovim's built-in health checks
nvim --headless "+checkhealth" +qa
```

### Plugin management (inside Neovim)

```
:Lazy sync       -- Install/update/clean all plugins
:Lazy update     -- Update plugins to latest versions
:Lazy health     -- Check lazy.nvim health
:Mason           -- Manage LSP servers (UI)
:TSUpdate        -- Update treesitter parsers
```

### Project build commands (CMake projects edited in this Neovim)

The config includes cmake-tools.nvim with these keymaps:
- `<leader>cg` - CMake Generate
- `<leader>cb` - CMake Build
- `<leader>cr` - CMake Run

Build output directory pattern: `out/${variant:buildType}`

## Code Style Guidelines

### Language and Format

- **All configuration is written in Lua** (no Vimscript files).
- **Indentation**: 4 spaces (set in `set.lua`: tabstop=4, softtabstop=4,
  shiftwidth=4, expandtab=true). Some files use mixed indentation (tabs in
  `99.lua`, 2-space in `rose-pine.lua`) -- prefer 4 spaces for consistency.
- **No line wrapping** (`vim.opt.wrap = false`).
- **No trailing whitespace**.

### Plugin Spec Pattern

Every file in `lua/plugins/` **must return a table** (lazy.nvim spec format):

```lua
-- Simple plugin (no config)
return {
  { "author/plugin-name" }
}

-- Plugin with config function
return {
  {
    "author/plugin-name",
    dependencies = { "dep/plugin" },
    config = function()
      -- setup code here
    end,
  },
}

-- Plugin using opts (preferred for simple setups)
return {
  "author/plugin-name",
  opts = {
    option = value,
  },
  lazy = false,
}
```

### Keymaps

- **Leader key**: Space (`vim.g.mapleader = " "`)
- **Local leader**: Backslash (`vim.g.maplocalleader = "\\"`)
- Use `vim.keymap.set` for all keymaps, never the old `vim.api.nvim_set_keymap`.
- Always include a `desc` field for discoverability:
  ```lua
  vim.keymap.set("n", "<leader>pv", function() ... end, { desc = "Oil file explorer" })
  ```
- For buffer-local keymaps, pass `{ buffer = bufnr, desc = "..." }`.
- Alias `vim.keymap.set` to `map` in longer config blocks for brevity:
  ```lua
  local map = vim.keymap.set
  map("n", "<Leader>dc", dap.continue, { desc = "DAP: Continue" })
  ```

### Imports and Requires

- Use `require("module")` with double quotes.
- For optional dependencies, wrap in `pcall`:
  ```lua
  local ok, mod = pcall(require, "some-plugin")
  if not ok then return end
  ```
- Top-level `init.lua` loads modules via `require("Francis")` and
  `require("config.lazy")`.

### Error Handling

- Use `pcall(require, ...)` for optional plugin dependencies (see `nvim-dap.lua`
  for the canonical pattern).
- Abort early with `if not ok then return end` rather than nesting.
- Use commented-out `vim.notify()` calls for debug logging (leave them as
  comments, do not remove).

### Naming Conventions

- **Plugin spec files**: named after the plugin (`telescope.lua`, `harpoon2.lua`,
  `nvim-dap.lua`). Use lowercase with hyphens matching the plugin name.
- **After-plugin files**: same name as the plugin spec they configure.
- **Personal modules**: under `lua/Francis/` (capitalized, matching the user's
  namespace).
- **Local variables**: `snake_case` (`ok_dap`, `dapui`, `lua_opts`).

### Comments

- Use `--` for inline and single-line comments.
- Use section dividers in longer files:
  ```lua
  -- ──────── Section Name ────────
  ---------------------------------------------------------------------------
  -- N.  Section Name
  ---------------------------------------------------------------------------
  ```
- Use numbered steps in complex setup functions (see `nvim-dap.lua`).
- Comment out debug/notify lines rather than deleting them.

### LSP Servers

Registered LSP servers (in `after/plugin/lsp-zero.lua`):
- `clangd` (C/C++), `texlab` (LaTeX), `fortls` (Fortran), `cmake` (CMake),
  `lua_ls` (Lua), `pyright` (Python)

### Key Plugin Details

- **Colorscheme**: rose-pine (moon variant, transparent background)
- **File explorer**: oil.nvim (opened via `<leader>pv`)
- **Completion**: nvim-cmp with sources: nvim_lsp, luasnip, buffer, path
- **Git**: vim-fugitive (`<leader>gs`) + gitsigns.nvim
- **AI**: ThePrimeagen/99 plugin with AGENT.md auto-loading from project dirs

### Important Notes for Agents

1. **Do not modify `lazy-lock.json`** -- it is auto-generated by lazy.nvim.
2. **Plugin specs go in `lua/plugins/`**, post-load config goes in `after/plugin/`.
3. When adding a new plugin, create a new file in `lua/plugins/` returning a
   lazy.nvim spec table. If it needs keymaps or setup after load, add a
   corresponding file in `after/plugin/`.
4. The 99 plugin auto-loads `AGENT.md` files from the project directory tree.
5. **macOS paths** are hardcoded in places (e.g., `/opt/homebrew/` for lldb/gdb).
   Do not change these without confirming the user's environment.
6. This config targets Neovim 0.10+ (uses `vim.uv`, modern LSP APIs).
