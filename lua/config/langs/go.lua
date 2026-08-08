-- Go: parser + filetype.
-- LSP (gopls) and keymaps live here.
return {
  parsers = { "go" },
  filetypes = { "go" },
  -- gopls: the official Go LSP.
  lsp = {
    name = "gopls",
    cmd = { "gopls" },
    filetypes = { "go" },
    root_markers = { "go.mod", "go.work" },
  },
}
