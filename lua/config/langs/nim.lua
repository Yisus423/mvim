-- Nim: parser + filetype.
-- nim_format_string is pulled in automatically by nvim-treesitter (`requires`).
-- LSP (nimlangserver) and keymaps live here.
return {
  parsers = { "nim" },
  filetypes = { "nim" },
  -- nimlangserver: the community Nim LSP.
  lsp = {
    name = "nimlangserver",
    cmd = { "nimlangserver" },
    filetypes = { "nim" },
    root_markers = { "nimble.task", "*.nimble" },
  },
}
