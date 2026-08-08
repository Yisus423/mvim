-- Python: parser + filetype.
-- LSP (ty server) and keymaps live here.
return {
  parsers = { "python" },
  filetypes = { "python" },
  -- ty: the Astral type checker LSP (server subcommand).
  lsp = {
    name = "ty",
    cmd = { "ty", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
  },
}
