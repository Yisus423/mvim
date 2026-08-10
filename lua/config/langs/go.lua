-- Go: parser + filetype.
-- LSP (gopls) and keymaps live here.
return {
  parsers = { "go" },
  filetypes = { "go" },
  -- gopls: the official Go LSP. Inlay hints are OFF by default in gopls,
  -- so they must be requested explicitly (the LspAttach hook in lsp.lua
  -- enables the client-side inlay hint provider).
  lsp = {
    name = "gopls",
    cmd = { "gopls" },
    filetypes = { "go" },
    root_markers = { "go.mod", "go.work" },
    settings = {
      -- gopls reads its config via workspace/configuration with section "gopls",
      -- so settings MUST be nested under `gopls` (same shape lspconfig uses).
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
}
