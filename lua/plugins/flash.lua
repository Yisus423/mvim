-- folke/flash.nvim — jump to any location with a few keystrokes.
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Saltar con flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Buscar con flash (treesitter)",
    },
  },
  opts = {},
}
