-- JavaScript: parser + filetype.
-- ecma + jsx queries are pulled in automatically by nvim-treesitter (`requires`).
-- LSP (biome, anti-Node) and keymaps live here.
return {
  parsers = { "javascript" },
  filetypes = { "javascript" },
  -- biome: Rust toolchain LSP, works for JS/TS/JSON/CSS/GraphQL.
  lsp = {
    name = "biome",
    cmd = { "biome", "lsp-proxy" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "jsonc",
      "css",
      "graphql",
    },
    root_markers = { "biome.json", "biome.jsonc", "package.json" },
  },
}
