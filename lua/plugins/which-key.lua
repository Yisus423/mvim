-- folke/which-key.nvim — keymap discovery popups.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "+finder" },
      { "<leader>g", group = "+git" },
      { "<leader>u", group = "+ui" },
    },
  },
}
