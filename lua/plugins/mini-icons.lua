-- nvim-mini/mini.icons — icon provider (filetype, file, LSP kinds).
-- snacks.nvim's picker auto-detects MiniIcons; the hand-rolled statusline
-- (lua/config/statusline.lua) reads it directly for file/diagnostic icons.
-- Not lazy: the global statusline queries it from the first redraw, so an
-- eager, cached require is simpler than a lazy-load race.
return {
  "nvim-mini/mini.icons",
  lazy = false,
  opts = {},
}
