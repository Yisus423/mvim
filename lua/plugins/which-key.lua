-- folke/which-key.nvim — keymap discovery popups.
-- Only groups with real keymaps are declared; empty groups are noise.
-- Nerd Font glyphs (fa set), verified present in JetBrainsMono Nerd Font.
local ic = vim.fn.nr2char
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "+buscar", icon = ic(0xf002) },
      { "<leader>b", group = "+buffer", icon = ic(0xf0db) },
      { "<leader>g", group = "+git", icon = ic(0xf126) },
      { "<leader>r", group = "+refactor", icon = ic(0xf0ad) },
      { "<leader>c", group = "+código", icon = ic(0xf121) },
      { "<leader>n", group = "+notas", icon = ic(0xf02d) },
    },
  },
}
