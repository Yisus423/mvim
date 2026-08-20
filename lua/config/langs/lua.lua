-- Lua: parser + filetype.
-- LSP (lua_ls) lives here. The Neovim runtime library and the `vim` global
-- come from .luarc.json at the config root, NOT from global settings, so
-- standalone Lua projects are not polluted with nvim types.
return {
  parsers = { "lua" },
  filetypes = { "lua" },
  lsp = {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git" },
    settings = {
      Lua = {
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
      },
    },
  },
}