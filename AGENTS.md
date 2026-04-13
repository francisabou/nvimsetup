# AGENTS.md - Neovim Configuration

Last reviewed: 2026-04-11

Personal Neovim configuration using `lazy.nvim` and Lua modules.

## Repository Structure (Current)

```
init.lua
.luarc.json
.stylua.toml
lua/
  Francis/
    init.lua
    remap.lua
    set.lua
  config/
    lazy.lua
  plugins/
     99.lua
    harpoon-core.lua
    lualine.lua
    autopairs.lua
    cmake-tools.lua
    copilot.lua
    fzf-lua.lua
    gitsigns.lua
    lsp.lua
    mini-icons.lua
    nvim-dap.lua
    nvim-treesitter.lua
    oil.lua
    rose-pine.lua
    todo-comments.lua
    treesitter-context.lua
    vim-fugitive.lua
    vimtex.lua
lsp/
  lua_ls.lua
after/plugin/
  lsp.lua
```

## Runtime and Validation

- Current local runtime: `NVIM v0.12.1`
- Requires `tree-sitter` CLI (installed via `npm install -g tree-sitter-cli`)
- This repo is config-only (no traditional build/test pipeline)

### Validation commands

```bash
# Lua syntax check (using luajit)
find ~/.config/nvim/lua ~/.config/nvim/after ~/.config/nvim/lsp -name '*.lua' -print0 | xargs -0 -I{} luajit -bl "{}" /dev/null

# Startup smoke test
nvim --headless "+lua print('OK')" +qa

# Full health checks
nvim --headless "+checkhealth" +qa

# LSP health (preferred over lspconfig health)
nvim --headless "+checkhealth vim.lsp" +qa

# Plugin update availability (non-installing check)
nvim --headless "+Lazy! check" +qa
```

## Conventions

### Language and formatting

- All configuration is Lua.
- Indentation preference is 4 spaces (`tabstop=4`, `shiftwidth=4`, `expandtab=true`).
- Formatting enforced by `.stylua.toml` (4-space indent, 120 column width, double quotes).
- `wrap` is currently enabled in `lua/Francis/set.lua` (`vim.opt.wrap = true`).
- Avoid trailing whitespace.

### Plugin spec pattern

Each file in `lua/plugins/` should return a lazy.nvim spec table.

```lua
return {
  {
    "author/plugin-name",
    dependencies = { "dep/plugin" },
    opts = {},
  },
}
```

### LSP server config pattern

Server-specific overrides go in `lsp/<server_name>.lua` (Nvim 0.12 native convention).
Each file returns a config table:

```lua
return {
    settings = { ... },
}
```

### Keymaps

- `mapleader` is space (`" "`), set in `init.lua` (before any `require` calls)
- `maplocalleader` is backslash (`"\\"`)
- Use `vim.keymap.set` with `buf` (not deprecated `buffer`) for buffer-local maps
- All keymaps must include `desc` for discoverability
- Nvim 0.12 built-in LSP keymaps are used: `K` (hover), `grr` (references), `grn` (rename), `gra` (code action), `gri` (implementation), `grt` (type def), `gO` (symbols)
- Custom LSP keymaps: `<leader>gd` (definition), `<leader>e` (diagnostics float), `<leader>q` (diagnostics loclist)

### Requires and error handling

- Use `require("module")` with double quotes.
- Use `pcall(require, ...)` for optional integrations.
- Use early returns (`if not ok then return end`).

## Current Plugin Notes

- LSP keymaps live in `after/plugin/lsp.lua`; server configs live in `lsp/` directory (Nvim 0.12 native pattern).
- Plugin stack for LSP/completion is `mason.nvim` (`mason-org`), `mason-lspconfig.nvim`, `nvim-lspconfig`, and `blink.cmp`.
- Registered language servers: `clangd`, `texlab`, `fortls`, `cmake`, `lua_ls`, `pyright`.
- Completion: `blink.cmp` with LSP, path, snippets, and buffer sources (replaced nvim-cmp).
- Fuzzy finder: `fzf-lua` (replaced telescope.nvim). All searches use git-root detection.
- File marks: `harpoon-core.nvim` (replaced harpoon2 -> grapple.nvim -> arrow.nvim -> harpoon-core.nvim).
- Treesitter: `nvim-treesitter` main branch + `vim.treesitter.start()` for highlighting.
- Statusline: `lualine.nvim` with `rose-pine` theme, round separators, icons enabled.
- Colorscheme: `rose-pine` (moon, transparent).
- Explorer: `oil.nvim` (`<leader>pv`), lazy-loaded via keys.
- Git: `vim-fugitive` + `gitsigns.nvim`.
- DAP paths are macOS/Homebrew-specific in `lua/plugins/nvim-dap.lua`. Python DAP auto-detects `$VIRTUAL_ENV`.
- AI: `99.nvim` with `blink.compat` for completion integration and `fzf_lua` extension for pickers.
- Undotree: uses Nvim 0.12 built-in `nvim.undotree` package (loaded via `packadd nvim.undotree` in `remap.lua`; `<leader>u` opens it).
- Autopairs: `nvim-autopairs` for auto-closing brackets/quotes, lazy-loaded on `InsertEnter`.
- Copilot: loaded but `auto_trigger = false` by default; toggle with `<leader>cp`.

## Current Ecosystem Status (Apr 2026)

- `lsp-zero.nvim` upstream project status is explicitly marked "Dead"; this config uses native Neovim LSP.
- `nvim-treesitter/playground` is archived; this config uses Neovim built-ins (`:Inspect`, `:InspectTree`, `:EditQuery`).
- `nvim-treesitter` repository is archived; this config uses the `main` branch rewrite for Nvim 0.12+.
- `telescope.nvim` is effectively unmaintained; this config uses `fzf-lua` instead.
- `harpoon` (harpoon2 branch) is stagnant; this config uses `harpoon-core.nvim` (replaced arrow.nvim).
- `arrow.nvim` maintenance is slowing (PRs piling up); this config switched to `harpoon-core.nvim`.
- `nvim-cmp` is maintained as a hobby project; this config uses `blink.cmp` instead.
- `nvim-web-devicons` replaced by `mini.icons` (lighter, faster); `package.preload` mock in `mini-icons.lua` redirects any `require("nvim-web-devicons")` calls.
- `mason.nvim` has moved to the `mason-org` GitHub organization.
- `mbbill/undotree` dropped in favor of Nvim 0.12 built-in `:Undotree` (requires `packadd nvim.undotree`).

## Recommended Improvements (Prioritized)

1. Decide whether to keep `mason-lspconfig` for convenience or manage server installs purely via system package manager.
2. Run `:Lazy! check` periodically and update `lazy-lock.json` only in intentional plugin-update changes.
3. Install `debugpy` for Python DAP (`pip3 install debugpy`).
4. `lua/Francis/set.lua` is a pure options file (no module return); statusline is handled by `lualine.nvim`.

## Important Notes for Agents

1. Avoid changing `lazy-lock.json` unless the user explicitly asks for plugin updates.
2. Plugin specs belong in `lua/plugins/`; LSP server configs belong in `lsp/`.
3. `after/plugin/` now only contains `lsp.lua` (global LSP keymaps and diagnostics).
4. For new plugins, create one plugin spec file. Prefer `opts`/`config`/`keys` in the spec over `after/plugin/`.
5. Confirm before changing hardcoded macOS tool paths.
6. Keep Neovim API usage aligned with 0.12+ behavior (use `vim.uv` not `vim.loop`, `buf` not `buffer` in keymap opts).
7. Rely on built-in LSP keymaps (`grr`, `grn`, `gra`, `K`, etc.) instead of adding custom duplicates.
