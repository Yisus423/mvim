-- JavaScript: parser + filetype.
-- ecma + jsx queries are pulled in automatically by nvim-treesitter (`requires`).
-- LSP (tsgo/biome/oxlint, anti-Node) and keymaps land here when the LSP layer is built.
return {
  parsers = { "javascript" },
  filetypes = { "javascript" },
}
