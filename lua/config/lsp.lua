-- Native LSP layer: no plugin, no mason — Neovim's built-in vim.lsp.config
-- + vim.lsp.enable drive every server declared in the langs registry.
-- vim.lsp.config merges per-server settings without clobbering user config.
local langs = require("config.langs")

local configs = langs.lsp_configs()

for name, conf in pairs(configs) do
  vim.lsp.config(name, {
    cmd = conf.cmd,
    filetypes = conf.filetypes,
    root_markers = conf.root_markers,
  })
end

-- Enable every registered server; keys come from the registry (order stable).
vim.lsp.enable(vim.tbl_keys(configs))
