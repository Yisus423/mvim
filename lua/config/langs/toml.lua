-- TOML: parser + filetype.
-- LSP (tombi) and keymaps live here.
return {
  parsers = { "toml" },
  filetypes = { "toml" },
  -- tombi: the TOML toolkit (formatter + linter + language server), Rust.
  -- `tombi lsp` is the stdio language server; it also advertises formatting,
  -- so format-on-save in lsp.lua picks it up automatically.
  lsp = {
    name = "tombi",
    cmd = { "tombi", "lsp" },
    filetypes = { "toml" },
    root_markers = { ".git", "pyproject.toml", "Cargo.toml" },
  },
}
