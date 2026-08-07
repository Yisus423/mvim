-- folke/snacks.nvim — UI layer: dashboard, notifier, picker, quickfile.
-- Only the modules we need are enabled; the rest stay off (image, indent, scope, etc.).
-- NOTE: snacks dropped its statusline module in v2.x, so the statusline is a native
-- hand-rolled one (lua/config/statusline.lua) wired up in `config` below.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  config = function(_, opts)
    vim.o.laststatus = 3
    vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"
    require("snacks").setup(opts)
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
          { key = "f", desc = "Buscar archivos", action = ":lua Snacks.picker.files()" },
          { key = "g", desc = "Buscar en archivos", action = ":lua Snacks.picker.grep()" },
          { key = "r", desc = "Archivos recientes", action = ":lua Snacks.picker.recent()" },
          { key = "b", desc = "Listar buffers", action = ":lua Snacks.picker.buffers()" },
          { key = "c", desc = "Config mvim", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
          { key = "q", desc = "Salir", action = ":qa" },
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
  },
}
