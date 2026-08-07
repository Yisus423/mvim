-- lewis6991/gitsigns.nvim — git signs in the sign column. Classic ▎│▍ glyphs.
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "│" },
      delete = { text = "▍" },
      topdelete = { text = "▍" },
      changedelete = { text = "▍" },
    },
  },
}
