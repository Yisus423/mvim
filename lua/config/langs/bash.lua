-- Bash: parser + filetypes.
-- Neovim uses `sh` for shell scripts, so both `sh` and `bash` map to the bash parser.
-- LSP (bashd) and keymaps live here.
return {
  parsers = { "bash" },
  filetypes = { "sh", "bash" },
  -- bashd: fast Rust shell language server.
  lsp = {
    name = "bashd",
    cmd = { "bashd" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
  },
}
