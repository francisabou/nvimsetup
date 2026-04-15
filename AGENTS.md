# AGENTS.md - Neovim Configuration

Last reviewed: 2026-04-15

Personal Neovim configuration using `lazy.nvim` and Lua modules.

## Repository Structure (Current)

```
init.lua
.luarc.json
.stylua.toml
.gitignore
lua/
  Francis/
    init.lua          -- requires remap + set; OpenFOAM + Wolfram filetype detection
    remap.lua
    set.lua
    utils.lua         -- shared helpers (resolve_terminal for REPL workflows)
  config/
    lazy.lua
  plugins/
    99.lua
    autopairs.lua
    cmake-tools.lua
    conform.lua
    copilot.lua
    fidget.lua
    fzf-lua.lua
    gitsigns.lua
    harpoon-core.lua
    lsp.lua
    lualine.lua       -- full lualine setup (transparent theme, sections, refresh)
    mini-icons.lua
    nvim-dap.lua
    nvim-treesitter.lua
    oil.lua
    rose-pine.lua
    todo-comments.lua
    treesitter-context.lua
    vim-fugitive.lua
    vim-mma.lua       -- Wolfram/Mathematica syntax + REPL keymaps
    vim-slime.lua     -- REPL integration (terminal-based send)
    vimtex.lua
    which-key.lua
    tmp/              -- 99.nvim runtime data (gitignored)
lsp/
  lua_ls.lua
  matlab_ls.lua       -- MATLAB language server (finds local MATLAB.app)
  wolfram_ls.lua      -- Wolfram LSP via WolframKernel (not mason-managed)
after/plugin/
  lsp.lua             -- global LSP keymaps, diagnostics, wolfram_ls enable
tmp/                   -- 99.nvim temp files (gitignored runtime data)
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
- Format-on-save via `conform.nvim` (currently configured for `stylua` on Lua files).
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
- `which-key.nvim` provides keymap popup hints on leader key press

#### Built-in LSP keymaps (Nvim 0.12)

`K` (hover), `grr` (references), `grn` (rename), `gra` (code action), `gri` (implementation), `grt` (type def), `gO` (symbols)

#### Custom keymaps by source

**Core (`remap.lua`):**
- `jk` -- exit insert mode
- `<leader>o` / `<leader>O` -- insert blank line below/above
- `<leader>u` -- open undotree (packadd + open)

**LSP (`after/plugin/lsp.lua`):**
- `<leader>gd` -- go to definition
- `<leader>e` -- diagnostics float
- `<leader>q` -- diagnostics to loclist
- `<leader>ih` -- toggle inlay hints (off by default, buffer-local, on LspAttach)

**Formatting (`conform.lua`):**
- `<leader>cf` -- format buffer (async, LSP fallback)

**Fuzzy finder (`fzf-lua.lua`):**
- `<leader>pf` -- find files (project root)
- `<C-p>` -- git files (project root)
- `<leader>ps` -- grep string (project root)
- `<leader>pg` -- live grep (project root)

**File explorer (`oil.lua`):**
- `<leader>pv` -- open oil file explorer

**Harpoon (`harpoon-core.lua`):**
- `<leader>a` -- add file
- `<C-e>` -- toggle quick menu
- `<C-h/j/k/l>` -- navigate to marks 1-4
- `<C-S-P>` / `<C-S-N>` -- prev/next mark

**Git (`vim-fugitive.lua`, `gitsigns.lua`):**
- `<leader>gs` -- fugitive Git status
- `]h` / `[h` -- next/prev hunk (gitsigns, diff-aware)
- `<leader>ghs` -- stage hunk (n/v)
- `<leader>ghr` -- reset hunk (n/v)
- `<leader>ghS` -- stage buffer
- `<leader>ghu` -- undo stage hunk
- `<leader>ghR` -- reset buffer
- `<leader>ghp` -- preview hunk
- `<leader>ghi` -- preview hunk inline
- `<leader>ghb` -- blame line (full)
- `<leader>ghd` -- diff this
- `<leader>ghD` -- diff this ~
- `<leader>gtb` -- toggle line blame
- `<leader>gtw` -- toggle word diff
- `<leader>gtd` -- toggle deleted lines
- `ih` -- select hunk (text object, o/x mode)
- `<leader>tg` -- toggle git signs globally

**DAP (`nvim-dap.lua`):**
- `<leader>dc` -- continue
- `<leader>so` -- step over
- `<leader>si` -- step into
- `<leader>se` -- step out
- `<leader>db` -- toggle breakpoint
- `<leader>dr` -- open REPL
- `<leader>dl` -- run last

**CMake (`cmake-tools.lua`):**
- `<leader>cg` -- CMake generate
- `<leader>cb` -- CMake build
- `<leader>cr` -- CMake run
- `<leader>ct` -- CMake select build type
- `<leader>cc` -- CMake clean

**Copilot (`copilot.lua`):**
- `<leader>cp` -- toggle inline suggestions
- Accept keymaps (in insert mode): `` `h `` (accept), `` `j `` (accept word), `` `k `` (accept line), `` `] `` / `` `[ `` (next/prev), `<C-]>` (dismiss)

**AI - 99.nvim (`99.lua`):**
- `<leader>9v` -- visual prompt (visual mode only)
- `<leader>9x` -- stop all requests
- `<leader>9s` -- search
- `<leader>9m` -- select AI model (fzf-lua picker)
- `<leader>9p` -- select AI provider (fzf-lua picker)

### Requires and error handling

- Use `require("module")` with double quotes.
- Use `pcall(require, ...)` for optional integrations.
- Use early returns (`if not ok then return end`).

## Current Plugin Notes

- LSP keymaps live in `after/plugin/lsp.lua`; server configs live in `lsp/` directory (Nvim 0.12 native pattern).
- Plugin stack for LSP/completion: `mason.nvim` (`mason-org`), `mason-lspconfig.nvim`, `nvim-lspconfig`, `lazydev.nvim` (Lua dev), and `blink.cmp`.
- Registered language servers: `clangd`, `texlab`, `fortls`, `cmake`, `lua_ls`, `pyright`.
- Completion: `blink.cmp` (v1.x) with `lazydev`, LSP, path, snippets, buffer sources, and `friendly-snippets`. Keymap preset is `"none"` with custom bindings (`<Tab>`/`<S-Tab>` select, `<C-y>` accept, `<C-Space>` show, `<C-e>` hide). Signature help enabled. Fuzzy uses `prefer_rust`.
- Formatting: `conform.nvim` with format-on-save (500ms timeout, LSP fallback). Currently only `stylua` for Lua.
- Fuzzy finder: `fzf-lua` (replaced telescope.nvim). All searches use git-root detection via `vim.fs.root(0, ".git")`.
- File marks: `harpoon-core.nvim` (replaced harpoon2 -> grapple.nvim -> arrow.nvim -> harpoon-core.nvim).
- Treesitter: `nvim-treesitter` main branch + `vim.treesitter.start()` via FileType autocmd for highlighting.
- Statusline: `lualine.nvim` with transparent custom theme (based on `auto` with all `bg = "NONE"`), round separators, icons enabled. Full config in `lua/plugins/lualine.lua` spec `config` function.
- Colorscheme: `rose-pine` (moon variant, transparency enabled).
- Explorer: `oil.nvim` (`<leader>pv`), `lazy = false`, `delete_to_trash = true`, shows hidden files.
- Git: `vim-fugitive` + `gitsigns.nvim` (extensive buffer-local keymaps for hunks, blame, diff, toggles).
- DAP: adapters resolved from `$PATH` via `resolve_exe()` helper (cross-platform, not hardcoded). Adapters: `lldb` (C/C++), `gdb` (Fortran), `python` (debugpy). `nvim-dap-ui` auto-opens/closes on debug sessions. Python DAP auto-detects `$VIRTUAL_ENV`.
- AI: `99.nvim` with `blink.compat` for completion, `fzf_lua` extension for model/provider pickers. Model persistence across sessions (saved to `stdpath("data")/99-model.txt`). Completion source set to `"blink"`. Reads `AGENT.md` files from project hierarchy.
- Undotree: uses Nvim 0.12 built-in `nvim.undotree` package (loaded via `packadd nvim.undotree` in `remap.lua`; `<leader>u` opens it).
- Autopairs: `nvim-autopairs` for auto-closing brackets/quotes, lazy-loaded on `InsertEnter`.
- Copilot: `zbirenbaum/copilot.lua`, `auto_trigger = false` by default; toggle with `<leader>cp`. Accept keymaps use backtick prefix (`` `h ``, `` `j ``, `` `k ``). Panel disabled.
- Notifications: `fidget.nvim` overrides `vim.notify()` for LSP progress and all notifications.
- Keymap discovery: `which-key.nvim` loaded on `VeryLazy`.
- Filetype detection: `lua/Francis/init.lua` registers OpenFOAM dictionary files (controlDict, fvSchemes, etc.) as `cpp` filetype and Wolfram `.wl`/`.wls` as `mma` filetype.
- REPL helpers: `lua/Francis/utils.lua` provides shared `resolve_terminal()` used by `vim-slime` and `vim-mma` for terminal channel discovery.
- Netrw is explicitly disabled in `set.lua` (`loaded_netrw = 1`, `loaded_netrwPlugin = 1`).

## Editor Options (`set.lua`)

- `guicursor = ""` (block cursor in all modes)
- Line numbers: `nu = true`, `relativenumber = true`
- Indent: `tabstop = 4`, `softtabstop = 4`, `shiftwidth = 4`, `expandtab = true`, `smartindent = true`
- `wrap = true`
- No swapfile/backup; persistent undo to `stdpath("state")/undodir`
- `hlsearch = false`, `incsearch = true`
- `scrolloff = 8`
- `signcolumn = "yes"`
- `updatetime = 200`
- `cmdheight = 0` (no command line unless typing)
- `textwidth = 80`, `formatoptions` removes `t` (no auto-wrap; use `gq` for manual reflow)

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
5. Consider moving lualine config from `after/plugin/lualine.lua` into the plugin spec `opts`/`config` for consistency.
6. Add more formatters to `conform.nvim` as needed (e.g., `clang-format` for C/C++, `black`/`ruff` for Python).

## Important Notes for Agents

1. Avoid changing `lazy-lock.json` unless the user explicitly asks for plugin updates.
2. Plugin specs belong in `lua/plugins/`; LSP server configs belong in `lsp/`.
3. `after/plugin/` contains `lsp.lua` (global LSP keymaps/diagnostics) and `lualine.lua` (full statusline config).
4. For new plugins, create one plugin spec file. Prefer `opts`/`config`/`keys` in the spec over `after/plugin/`.
5. DAP adapters use `resolve_exe()` to find tools from `$PATH`; no hardcoded paths. Confirm before adding platform-specific paths.
6. Keep Neovim API usage aligned with 0.12+ behavior (use `vim.uv` not `vim.loop`, `buf` not `buffer` in keymap opts).
7. Rely on built-in LSP keymaps (`grr`, `grn`, `gra`, `K`, etc.) instead of adding custom duplicates.
8. `vim.notify()` is routed through `fidget.nvim`; use `vim.notify()` normally and it will display via fidget.
9. The `tmp/` directory (root and `lua/plugins/tmp/`) contains 99.nvim runtime data; do not version or modify these files.
