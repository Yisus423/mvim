-- Zig: parser + filetype.
-- LSP (zls) and keymaps live here.
return {
  parsers = { "zig" },
  filetypes = { "zig" },
  -- zls: the official Zig language server.
  lsp = {
    name = "zls",
    cmd = { "zls" },
    filetypes = { "zig" },
    root_markers = { "build.zig", "build.zig.zon" },
  },
}
