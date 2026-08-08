-- Bash: parser + filetypes.
-- Neovim uses `sh` for shell scripts, so both `sh` and `bash` map to the bash parser.
-- LSP (bashls) and keymaps land here when the LSP layer is built.
return {
  parsers = { "bash" },
  filetypes = { "sh", "bash" },
}
