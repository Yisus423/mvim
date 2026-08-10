-- folke/which-key.nvim — keymap discovery popups.
-- Only groups with real keymaps are declared; empty groups are noise.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "+buscar" },
      { "<leader>b", group = "+buffer" },
      { "<leader>d", group = "+diagnóstico" },
      { "<leader>r", group = "+refactor" },
      { "<leader>c", group = "+código" },
    },
  },
}
