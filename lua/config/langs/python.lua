-- Python: parser + filetype.
-- LSPs (ty + ruff) and keymaps live here.
return {
  parsers = { "python" },
  filetypes = { "python" },
  -- Two servers: ty checks types only; ruff lints+formats (ty cannot format).
  lsp = {
    {
      name = "ty",
      cmd = { "ty", "server" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
    },
    {
      name = "ruff",
      cmd = { "ruff", "server" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
      settings = { format = { preview = true } },
    },
  },
}
