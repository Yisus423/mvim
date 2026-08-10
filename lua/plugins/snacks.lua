-- folke/snacks.nvim — UI layer: dashboard, notifier, picker, quickfile.
-- Only the modules we need are enabled; the rest stay off (image, indent, scope, etc.).
-- NOTE: snacks dropped its statusline module in v2.x, so the statusline is a native
-- hand-rolled one (lua/config/statusline.lua) wired up in `config` below.

-- Nerd Font glyphs (fa set), verified present in JetBrainsMono Nerd Font.
-- Built via nr2char so the source stays ASCII (no multibyte literal risk).
local ic = vim.fn.nr2char

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  config = function(_, opts)
    vim.o.laststatus = 3
    vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"
    require("snacks").setup(opts)

    -- Dim inactive windows only while in Insert mode: a focus aid while
    -- typing, without fighting you while reading/navigating. Snacks.toggle.dim()
    -- stays available for a manual on/off.
    local group = vim.api.nvim_create_augroup("snacks_dim_insert", { clear = true })
    vim.api.nvim_create_autocmd("InsertEnter", {
      group = group,
      callback = function()
        Snacks.dim.enable()
      end,
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
      group = group,
      callback = function()
        Snacks.dim.disable()
      end,
    })
  end,

  opts = {
    dashboard = {
      enabled = true,
      preset = {
        -- Small "mvim" block letters. Rendered with the SnacksDashboardHeader hl,
        -- which links to `Title` (gold in the mvim colorscheme).
        header = [[
███╗   ███╗██╗   ██╗██╗███╗   ███╗
████╗ ████║██║   ██║██║████╗ ████║
██╔████╔██║██║   ██║██║██╔████╔██║
██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        keys = {
          { icon = ic(0xf016) .. " ", key = "f", desc = "Buscar archivos", action = ":lua Snacks.picker.files()" },
          { icon = ic(0xf002) .. " ", key = "g", desc = "Buscar en archivos", action = ":lua Snacks.picker.grep()" },
          { icon = ic(0xf017) .. " ", key = "r", desc = "Archivos recientes", action = ":lua Snacks.picker.recent()" },
          { icon = ic(0xf0db) .. " ", key = "b", desc = "Listar buffers", action = ":lua Snacks.picker.buffers()" },
          { icon = ic(0xf013) .. " ", key = "c", desc = "Config mvim", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
          { icon = ic(0xf011) .. " ", key = "q", desc = "Salir", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        {
          align = "center",
          text = { { os.date("%A %d de %B, %Y"), hl = "footer" } },
        },
        { section = "startup" },
      },
    },

    notifier = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    terminal = { enabled = true },

    -- Disable heavy features (fold, syntax, completion) on big files.
    bigfile = { enabled = true },

    -- Indent guides + scope highlight (snacks.indent).
    indent = { enabled = true, scope = { enabled = true } },

    -- Smooth scrolling (snacks.scroll); terminals are excluded by default.
    scroll = { enabled = true },

    -- Highlight LSP references of the word under the cursor (snacks.words).
    words = { enabled = true },

    -- Floating input dialog (base for picker inputs and other prompts).
    input = { enabled = true },

    -- Status column: unifies signcolumn + folds + git signs in one coherent
    -- column (snacks sets vim.o.statuscolumn when enabled). gitsigns signs
    -- are matched via the GitSign hl pattern by default.
    statuscolumn = { enabled = true },
  },
}
