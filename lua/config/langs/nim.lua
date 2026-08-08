-- Nim: parser + filetype.
-- nim_format_string is pulled in automatically by nvim-treesitter (`requires`).
-- LSP and keymaps land here when the LSP layer is built.
return {
  parsers = { "nim" },
  filetypes = { "nim" },
}
