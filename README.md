# mvim — hand-rolled Neovim, Ayu Gold edition

[Español](README.es.md)

**mvim** is a personal, hand-rolled Neovim configuration — not a distro, no framework on top. It runs under its own app name (`NVIM_APPNAME=mvim`), ships a custom **Ayu Gold** colorscheme, and is built performance-first and anti-Node: every LSP server is a native binary (Rust, Go, C++), so there is no Node.js tooling and no Mason to babysit. Every line of Lua is intentional and readable — nothing inherited from a prebuilt config you would never fully understand.

## Quick install

1. Clone the repo into the default config directory:

   ```bash
   git clone git@github.com:Yisus423/mvim.git ~/.config/mvim
   ```

2. Launch it:

   ```bash
   NVIM_APPNAME=mvim nvim
   ```

   lazy.nvim bootstraps itself on the first launch and installs all plugins.

3. Install the LSP servers for the languages you use — see [Language support](#language-support--lsp-servers).

There is no install script yet; the steps above are the full setup.

## Requirements

| Requirement | Detail |
|---|---|
| Neovim | ≥ 0.12 — uses native treesitter (0.12+) and the native `vim.lsp.config` API. The author runs 0.12.4 (installed with bob) |
| Git | clone, lazy.nvim bootstrap, plugin updates |
| Nerd Font | icons need a Nerd Font; verified against **JetBrainsMono Nerd Font** |
| Node.js | **not required** — no Node-based tooling anywhere |
| Mason | **not used** — LSP servers are installed by hand |

## Design philosophy

- **Hand-rolled over lazy.nvim.** Every line is understood; plugins are specs you can read. Prebuilt distros (LazyVim, NvChad and go.nvim were all evaluated) were rejected because they ship features you never use — dead code that still costs startup time and cognitive load.
- **Native-first.** Syntax highlighting is native treesitter; the LSP layer is `vim.lsp.config` + `vim.lsp.enable` with no plugin and no Mason; the picker is `snacks.picker` with a pure-Lua fuzzy matcher (fzf scoring ported to Lua) and `rg`/`fd` finders.
- **Performance matters.** `updatetime=300` (fast gitsigns refresh), `timeoutlen=400` (snappy leader keys), lazy-loaded plugins, and big-file handling.
- **Anti-Node.** clangd, gopls, biome, bashd, tombi, ruff, zls, lua-language-server — all native binaries, zero Node tooling.

## Layout

```
~/.config/mvim/
├── init.lua                entry point — loads everything in order
├── colors/mvim.lua         the hand-rolled Ayu Gold colorscheme
├── lua/config/             core configuration
│   ├── options.lua         editor options
│   ├── keymaps.lua         window / git / LSP / picker keymaps
│   ├── lsp.lua             native LSP layer (format-on-save, inlay hints, diagnostics)
│   ├── autopairs.lua       native auto-pairs (no nvim-autopairs)
│   ├── statusline.lua      hand-rolled statusline (snacks v2 dropped its module)
│   └── langs/              language registry — one file per language
└── lua/plugins/            lazy.nvim plugin specs
```

`init.lua` loads: `config.options` → colorscheme `mvim` → `config.lazy` → `config.lsp` → `config.autopairs` → `config.keymaps`.

**Adding a language = adding one file** in `lua/config/langs/`: each file declares its treesitter parsers, filetypes and LSP servers, and both treesitter and the LSP layer consume that registry — nothing is hardcoded twice. The config is itself a Lua project: `.luarc.json` at the root points lua-language-server at the Neovim runtime so the `vim` global is understood.

## Language support & LSP servers

Servers are installed by hand with your system package manager — mvim does not install them.

| Language | LSP server | Toolchain | Notes |
|---|---|---|---|
| C / C++ | `clangd` | C++ (LLVM) | one server for both; prefers `compile_commands.json` |
| Go | `gopls` | Go | inlay hints enabled via settings |
| Python | `ty` + `ruff` | Python (ty), Rust (ruff) | ty checks types only; ruff lints and formats |
| Lua | `lua-language-server` | C++ | `.luarc.json` provides the `vim` globals |
| JavaScript / TypeScript | `biome` (`lsp-proxy`) | Rust | also JSON, JSONC, CSS, GraphQL — no Node |
| Bash | `bashd` | Rust | also covers `sh` |
| Nim | `nimlangserver` | Nim | |
| TOML | `tombi` (`lsp`) | Rust | formatter + linter + LSP |
| Zig | `zls` | Zig | |

## Keymaps

Leader key is Space.

**Windows**

| Key | Action |
|---|---|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | go to window left / down / up / right |

**Editing**

| Key | Action |
|---|---|
| `jk` (insert) | leave insert mode |
| `<C-s>` (normal, insert) | save file |
| `<` `>` (visual) | indent left / right, keeping the selection (`gv`) |

> `<C-s>` is XON/XOFF flow control in some terminals; modern terminals pass it through.

**Finder** (snacks picker)

| Key | Action |
|---|---|
| `<leader>ff` | find files |
| `<leader>fg` | grep in files |
| `<leader>fb` | list buffers |
| `<leader>fr` | recent files |

**Terminal**

| Key | Action |
|---|---|
| `<M-i>` | toggle the floating terminal (open from normal mode, hide from inside) |

**Buffers** — no tabline: buffers + the picker replace tabs

| Key | Action |
|---|---|
| `]b` `[b` | next / previous buffer |
| `<leader>bd` | close buffer |

**Git**

| Key | Action |
|---|---|
| `<leader>ga` | git status picker — `<Tab>` stages/unstages (multi-select), `<C-r>` restores |
| `<leader>gc` | commit **only staged** changes — prompts for the message, no `git add -A`, runs in the repo that owns the current buffer |

**LSP**

| Key | Action |
|---|---|
| `K` | hover |
| `[d` `]d` | previous / next diagnostic |
| `<leader>d` | diagnostic details (float) |
| `gd` | go to definition |
| `gr` | references |
| `gi` | implementation |
| `<leader>rn` | rename symbol |
| `<leader>ca` | code action |

**Flash jump**

| Key | Action |
|---|---|
| `s` | jump to any visible location (normal, visual, operator-pending) |
| `S` | treesitter-based search (normal, visual, operator-pending) |

`which-key` groups: `<leader>f` find, `<leader>b` buffers, `<leader>g` git, `<leader>r` refactor, `<leader>c` code.

## Plugins

| Plugin | Purpose | Load |
|---|---|---|
| snacks.nvim | dashboard, picker, terminal, notifier, statuscolumn, indent, big-file, dim-in-insert | eager (priority 1000) |
| nvim-treesitter | parsers + queries, native highlighting, consumes the langs registry | eager |
| blink.cmp | completion — sources: LSP, buffer, path, snippets | on `InsertEnter` |
| mini.icons | icon provider (filetype, file, LSP kinds) | eager |
| gitsigns.nvim | git signs in the sign column (▎│▍) | on `BufReadPre` / `BufNewFile` |
| flash.nvim | jump navigation (`s` / `S`) | `VeryLazy` |
| which-key.nvim | keymap discovery popups | `VeryLazy` |

## Key options

| Option | Value | Effect |
|---|---|---|
| `number`, `relativenumber` | on | line numbers + relative jumps |
| `signcolumn` | `yes` | no layout shift when signs appear |
| `undofile` | on | undo persists across sessions (state under `~/.local/state/mvim`) |
| `splitbelow`, `splitright` | on | modern split placement |
| `tabstop`, `shiftwidth`, `expandtab` | 2 | 2-space indentation |
| `ignorecase`, `smartcase` | on | smart case handling for search |
| `termguicolors` | on | 24-bit color |
| `clipboard` | `unnamedplus` | system clipboard |
| `cursorline` | on | current line highlight |
| `scrolloff` | 8 | keep an 8-line margin while scrolling |
| `updatetime` | 300 | fast CursorHold events (gitsigns) |
| `timeoutlen` | 400 | snappy leader keymaps |

## Colorscheme — Ayu Gold

Built on the ayu-dark palette with **gold (`#e6b450`) as the primary accent**. Every highlight group is set explicitly — nothing inherited from a distro.

| Role | Hex |
|---|---|
| background (editor) | `#0a0e14` |
| background (floats, menus) | `#10151d` |
| background (statusline, bars) | `#1f2430` |
| foreground | `#b3b1ad` |
| gold — primary accent | `#e6b450` |
| cyan — secondary accent | `#59c2ff` |
| red — errors, deletions | `#ff3333` |
| disabled | `#475266` |
| green — strings | `#aad94c` |
| orange — numbers, warnings | `#ff8f40` |
| purple — hints | `#d2a6ff` |
| comment — comments, punctuation | `#565b66` |
| cursor line | `#131721` |
| selection | `#253340` |
| border | `#2d3640` |

Semantic mapping: **gold** keywords / functions / conditionals (primary accent), **cyan** types / operators (secondary), **green** strings, **orange** numbers / constants, **purple** hints / attributes, **red** errors / deletions, **comment** punctuation.

Surface hierarchy: editor `#0a0e14` < floats / menus `#10151d` < active bars `#1f2430`.

## Notable behaviors

- **Format on save** runs only when an attached server can format — Python formats via `ruff` (ty cannot); Go, Zig, Bash, JS/TS (biome) and TOML (tombi) format natively.
- **Inlay hints** enable automatically on attach when the server supports them.
- **Diagnostics**: signs plus a virtual line under the current line only.
- **Statusline** is global (`laststatus=3`), hand-rolled: mode, file + filetype icon, git branch (from gitsigns), error/warn counts, line:col and percentage.
