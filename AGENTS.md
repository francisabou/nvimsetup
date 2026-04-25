# AGENTS.md - Neovim Configuration

Personal Neovim config using `lazy.nvim` + Lua. Runtime: `NVIM v0.12.1`.

## Repository Structure

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
  basedpyright.lua    -- Python LSP (typeCheckingMode=basic, inlay hints)
  clangd.lua          -- C/C++ LSP (background-index, clang-tidy, header-insertion=never)
  fortls.lua          -- Fortran LSP (nthreads, lowercase_intrinsics, sort_keywords)
  lua_ls.lua
  matlab_ls.lua       -- MATLAB language server (finds local MATLAB.app)
  wolfram_ls.lua      -- Wolfram LSP via WolframKernel (not mason-managed)
after/plugin/
  lsp.lua             -- global LSP keymaps, diagnostics, wolfram_ls enable
tmp/                   -- 99.nvim temp files (gitignored runtime data)
```

## Conventions

- All config is Lua. Format: 4-space indent, 80 col width, double quotes (per `.stylua.toml`).
- `mapleader` = space (`" "`), `maplocalleader` = backslash (`"\\"`), set in `init.lua` before any `require`.
- Use `vim.keymap.set` with `buf` (not deprecated `buffer`). All keymaps need `desc`.
- Use `pcall(require, ...)` for optional integrations, early returns for guards.
- Plugin specs: one file per plugin in `lua/plugins/`, return lazy.nvim spec table. Prefer `opts`/`config`/`keys` over `after/plugin/`.
- LSP server configs: one file per server in `lsp/<server_name>.lua`, return config table.
- `after/plugin/lsp.lua` has global LSP keymaps/diagnostics.

## Key Plugin Choices

- **Completion:** `blink.cmp` (not nvim-cmp). Sources: lazydev, LSP, path, snippets, buffer, friendly-snippets.
- **Fuzzy finder:** `fzf-lua` (not telescope). Git-root detection via `vim.fs.root(0, ".git")`.
- **File marks:** `harpoon-core.nvim` (not harpoon2/arrow.nvim).
- **Icons:** `mini.icons` (not nvim-web-devicons). `package.preload` mock redirects `require("nvim-web-devicons")`.
- **Colorscheme:** `rose-pine` (moon variant, transparency enabled).
- **Explorer:** `oil.nvim` (`lazy = false`, netrw replacement). Netrw explicitly disabled in `set.lua`.
- **Undotree:** Nvim 0.12 built-in (`packadd nvim.undotree`), not mbbill/undotree.
- **Treesitter:** `nvim-treesitter` main branch (not master). Uses `vim.treesitter.start()` via FileType autocmd.
- **Notifications:** `fidget.nvim` overrides `vim.notify()`.
- **AI:** `99.nvim` with `blink.compat` completion, `fzf_lua` extension for model/provider pickers.
- **DAP:** Adapters use `resolve_exe()` from `$PATH` (no hardcoded paths). Adapters: lldb, gdb, python (debugpy).
- **REPL:** `vim-slime` (general) + `vim-mma` (Wolfram-specific, `mma` filetype only). Shared `<leader>r` group.
- **Copilot:** `zbirenbaum/copilot.lua`, `auto_trigger = false`, toggle `<leader>cp`. Accept uses backtick prefix.
- **LSP stack:** `mason.nvim` (mason-org) → `mason-lspconfig` → `nvim-lspconfig` → `lazydev.nvim` → `blink.cmp`. Registered servers: clangd, texlab, fortls, cmake, lua_ls, basedpyright.

## Critical Gotchas for Agents

1. **`keys` without RHS are lazy-load triggers.** In lazy.nvim specs, `keys` entries with only `desc` tell lazy.nvim to load the plugin on that keypress. The `config` function then overwrites them. Never remove these.
2. **`oil.nvim` must be `lazy = false`.** It replaces netrw and must be available at startup.
3. **Netrw is disabled** in `set.lua` (`loaded_netrw = 1`, `loaded_netrwPlugin = 1`). Don't re-enable.
4. **`tmp/` and `lua/plugins/tmp/`** contain 99.nvim runtime data. Never version or modify these files.
5. **Don't change `lazy-lock.json`** unless user explicitly asks for plugin updates.
6. **DAP adapters use `resolve_exe()`** to find tools from `$PATH`. No hardcoded paths. Confirm before adding platform-specific paths.
7. **Nvim 0.12+ API:** Use `vim.uv` (not `vim.loop`), `buf` (not `buffer`) in keymap opts.
8. **Use built-in LSP keymaps** (`grr`, `grn`, `gra`, `K`, etc.) instead of adding custom duplicates.
9. **`vim.notify()`** is routed through `fidget.nvim`. Use it normally.
10. **`wrap = true`** is set in `set.lua`. `textwidth = 80` with `formatoptions` removing `t` (no auto-wrap, use `gq`).
