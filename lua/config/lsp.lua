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
    settings = conf.settings,
  })
end

-- Enable every registered server; keys come from the registry (order stable).
vim.lsp.enable(vim.tbl_keys(configs))

-- Format on save, but only when an attached server can actually format:
-- ty cannot, so Python buffers format via ruff only; gopls/zls/bashd/biome
-- format natively. Neovim already filters clients without the capability; the
-- pre-check avoids the "no formatting provider" no-op/error path.
local function format_on_save()
  local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" })
  if vim.tbl_isempty(clients) then
    return
  end
  vim.lsp.buf.format({ bufnr = 0 })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = format_on_save,
})
