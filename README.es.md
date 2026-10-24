# mvim — Neovim configurado a mano, edición Ayu Gold

[English](README.md)

**mvim** es una configuración personal de Neovim hecha a mano — no es una distro ni un framework encima. Corre bajo su propio nombre de aplicación (`NVIM_APPNAME=mvim`), trae un colorscheme propio llamado **Ayu Gold** y está construida con prioridad en el rendimiento y en contra de Node: todos los servidores LSP son binarios nativos (Rust, Go, C++), así que no hay tooling de Node ni Mason que mantener. Cada línea de Lua es intencional y legible — nada heredado de una configuración prehecha que nunca terminarías de entender.

## Instalación rápida

1. Clona el repositorio en el directorio de configuración por defecto:

   ```bash
   git clone git@github.com:Yisus423/mvim.git ~/.config/mvim
   ```

2. Ábrelo:

   ```bash
   NVIM_APPNAME=mvim nvim
   ```

   lazy.nvim se auto-instala (bootstrap) en el primer arranque e instala todos los plugins.

3. Instala los servidores LSP de los lenguajes que uses — ver [Soporte de lenguajes](#soporte-de-lenguajes-y-servidores-lsp).

Todavía no hay script de instalación; los pasos anteriores son toda la instalación.

## Requisitos

| Requisito | Detalle |
|---|---|
| Neovim | ≥ 0.12 — usa treesitter nativo (0.12+) y la API nativa `vim.lsp.config`. El autor usa 0.12.4 (instalado con bob) |
| Git | clonado, bootstrap de lazy.nvim, actualizaciones de plugins |
| Nerd Font | los iconos requieren una Nerd Font; verificada contra **JetBrainsMono Nerd Font** |
| Node.js | **no requerido** — no hay tooling basado en Node en ninguna parte |
| Mason | **no se usa** — los servidores LSP se instalan a mano |

## Filosofía de diseño

- **Hecha a mano sobre lazy.nvim.** Cada línea está entendida; los plugins son specs legibles. Las distros prehechas (se evaluaron LazyVim, NvChad y go.nvim) se descartaron porque traen funciones que nunca usas — código muerto que igual cuesta tiempo de arranque y carga cognitiva.
- **Nativa primero.** El resaltado sintáctico es treesitter nativo; la capa LSP es `vim.lsp.config` + `vim.lsp.enable` sin plugin ni Mason; el picker es `snacks.picker` con un matcher difuso en Lua puro (port del scoring de fzf) y finders `rg`/`fd`.
- **El rendimiento importa.** `updatetime=300` (refresco rápido de gitsigns), `timeoutlen=400` (leader keys ágiles), plugins con lazy-load y manejo de archivos grandes.
- **Anti-Node.** clangd, gopls, biome, bashd, tombi, ruff, zls, lua-language-server — binarios nativos, cero tooling de Node.

## Estructura

```
~/.config/mvim/
├── init.lua                punto de entrada — carga todo en orden
├── colors/mvim.lua         el colorscheme Ayu Gold hecho a mano
├── lua/config/             configuración principal
│   ├── options.lua         opciones del editor
│   ├── keymaps.lua         keymaps de ventanas / git / LSP / picker
│   ├── lsp.lua             capa LSP nativa (format-on-save, inlay hints, diagnósticos)
│   ├── autopairs.lua       auto-pairs nativo (sin nvim-autopairs)
│   ├── statusline.lua      statusline hecho a mano (snacks v2 eliminó su módulo)
│   └── langs/              registro de lenguajes — un archivo por lenguaje
└── lua/plugins/            specs de lazy.nvim
```

`init.lua` carga: `config.options` → colorscheme `mvim` → `config.lazy` → `config.lsp` → `config.autopairs` → `config.keymaps`.

**Agregar un lenguaje = agregar un archivo** en `lua/config/langs/`: cada archivo declara sus parsers de treesitter, filetypes y servidores LSP, y tanto treesitter como la capa LSP consumen ese registro — nada se duplica a mano. La configuración es en sí un proyecto Lua: el `.luarc.json` en la raíz apunta lua-language-server al runtime de Neovim para que entienda el global `vim`.

## Soporte de lenguajes y servidores LSP

Los servidores se instalan a mano con el gestor de paquetes de tu sistema — mvim no los instala.

| Lenguaje | Servidor LSP | Toolchain | Notas |
|---|---|---|---|
| C / C++ | `clangd` | C++ (LLVM) | un solo servidor para ambos; prefiere `compile_commands.json` |
| Go | `gopls` | Go | inlay hints habilitados vía settings |
| Python | `ty` + `ruff` | Python (ty), Rust (ruff) | ty solo verifica tipos; ruff hace lint y formato |
| Lua | `lua-language-server` | C++ | el `.luarc.json` provee los globals de `vim` |
| JavaScript / TypeScript | `biome` (`lsp-proxy`) | Rust | también JSON, JSONC, CSS, GraphQL — sin Node |
| Bash | `bashd` | Rust | también cubre `sh` |
| Nim | `nimlangserver` | Nim | |
| TOML | `tombi` (`lsp`) | Rust | formateador + linter + LSP |
| Zig | `zls` | Zig | |

## Atajos de teclado (keymaps)

La tecla líder (leader) es Espacio.

**Ventanas**

| Tecla | Acción |
|---|---|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | ir a la ventana izquierda / abajo / arriba / derecha |

**Edición**

| Tecla | Acción |
|---|---|
| `jk` (insert) | salir del modo insertar |
| `<C-s>` (normal, insert) | guardar archivo |
| `<` `>` (visual) | indentar a la izquierda / derecha, manteniendo la selección (`gv`) |

> `<C-s>` es control de flujo XON/XOFF en algunos terminales; los terminales modernos lo pasan sin problema.

**Buscador** (snacks picker)

| Tecla | Acción |
|---|---|
| `<leader>ff` | buscar archivos |
| `<leader>fg` | buscar en archivos (grep) |
| `<leader>fb` | listar buffers |
| `<leader>fr` | archivos recientes |

**Terminal**

| Tecla | Acción |
|---|---|
| `<M-i>` | alternar la terminal flotante (abre desde modo normal, oculta desde dentro) |

**Buffers** — sin tabline: los buffers + el picker reemplazan las pestañas

| Tecla | Acción |
|---|---|
| `]b` `[b` | siguiente / anterior buffer |
| `<leader>bd` | cerrar buffer |

**Git**

| Tecla | Acción |
|---|---|
| `<leader>ga` | picker de git status — `<Tab>` stage/unstage (multi-select), `<C-r>` restaura |
| `<leader>gc` | commit **solo de lo staged** — pide el mensaje, no ejecuta `git add -A`, corre en el repo al que pertenece el buffer actual |

**LSP**

| Tecla | Acción |
|---|---|
| `K` | detalle bajo el cursor (hover) |
| `[d` `]d` | diagnóstico anterior / siguiente |
| `<leader>d` | detalle de diagnóstico (flotante) |
| `gd` | ir a la definición |
| `gr` | referencias del símbolo |
| `gi` | ir a la implementación |
| `<leader>rn` | renombrar símbolo |
| `<leader>ca` | code action |

**Salto flash**

| Tecla | Acción |
|---|---|
| `s` | saltar a cualquier ubicación visible (normal, visual, operator-pending) |
| `S` | búsqueda con treesitter (normal, visual, operator-pending) |

Grupos de `which-key`: `<leader>f` buscar, `<leader>b` buffers, `<leader>g` git, `<leader>r` refactor, `<leader>c` código.

## Plugins

| Plugin | Función | Carga |
|---|---|---|
| snacks.nvim | dashboard, picker, terminal, notifier, statuscolumn, indent, archivos grandes, dim en insert | eager (priority 1000) |
| nvim-treesitter | parsers + queries, resaltado nativo, consume el registro de langs | eager |
| blink.cmp | completado — fuentes: LSP, buffer, path, snippets | en `InsertEnter` |
| mini.icons | proveedor de iconos (filetype, archivo, LSP kinds) | eager |
| gitsigns.nvim | signos de git en la columna de signos (▎│▍) | en `BufReadPre` / `BufNewFile` |
| flash.nvim | navegación por saltos (`s` / `S`) | `VeryLazy` |
| which-key.nvim | popups de descubrimiento de keymaps | `VeryLazy` |

## Opciones clave

| Opción | Valor | Efecto |
|---|---|---|
| `number`, `relativenumber` | on | números de línea + saltos relativos |
| `signcolumn` | `yes` | sin saltos de layout cuando aparecen signos |
| `undofile` | on | el historial de undo persiste entre sesiones (estado en `~/.local/state/mvim`) |
| `splitbelow`, `splitright` | on | colocación moderna de splits |
| `tabstop`, `shiftwidth`, `expandtab` | 2 | indentación de 2 espacios |
| `ignorecase`, `smartcase` | on | manejo inteligente de mayúsculas en la búsqueda |
| `termguicolors` | on | color de 24 bits |
| `clipboard` | `unnamedplus` | portapapeles del sistema |
| `cursorline` | on | resaltado de la línea actual |
| `scrolloff` | 8 | mantiene un margen de 8 líneas al hacer scroll |
| `updatetime` | 300 | eventos CursorHold rápidos (gitsigns) |
| `timeoutlen` | 400 | leader keys ágiles |

## Colorscheme — Ayu Gold

Construido sobre la paleta ayu-dark con **gold (`#e6b450`) como acento principal**. Cada grupo de resaltado está definido explícitamente — nada heredado de una distro.

| Rol | Hex |
|---|---|
| fondo (editor) | `#0a0e14` |
| fondo (floats, menús) | `#10151d` |
| fondo (statusline, barras) | `#1f2430` |
| texto principal | `#b3b1ad` |
| gold — acento principal | `#e6b450` |
| cyan — acento secundario | `#59c2ff` |
| red — errores, borrados | `#ff3333` |
| disabled | `#475266` |
| green — strings | `#aad94c` |
| orange — números, warnings | `#ff8f40` |
| purple — hints | `#d2a6ff` |
| comment — comentarios, puntuación | `#565b66` |
| línea del cursor | `#131721` |
| selección | `#253340` |
| borde | `#2d3640` |

Mapeo semántico: **gold** keywords / funciones / condicionales (acento principal), **cyan** tipos / operadores (secundario), **green** strings, **orange** números / constantes, **purple** hints / atributos, **red** errores / borrados, **comment** puntuación.

Jerarquía de superficies: editor `#0a0e14` < floats / menús `#10151d` < barras activas `#1f2430`.

## Comportamientos notables

- **Format on save** corre solo cuando un servidor conectado puede formatear — Python formatea vía `ruff` (ty no puede); Go, Zig, Bash, JS/TS (biome) y TOML (tombi) formatean de forma nativa.
- **Inlay hints** se habilitan automáticamente al conectar cuando el servidor los soporta.
- **Diagnósticos**: signos más una línea virtual bajo la línea actual únicamente.
- **Statusline** global (`laststatus=3`), hecho a mano: modo, archivo + icono de filetype, rama git (de gitsigns), contadores de error/warning, línea:columna y porcentaje.
