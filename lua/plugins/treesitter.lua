-- nvim-treesitter/nvim-treesitter — tree-sitter parsers + queries (rewrite, main).
-- The rewrite is a full, incompatible plugin: NO lazy-loading (README explicit),
-- highlighting is native to Neovim and is NOT enabled automatically.
-- Regex syntax (opt.syntax = "on") stays as fallback until a parser exists.
--
-- Languages are declared in lua/config/langs/ (one file per language); this
-- plugin spec consumes the registry and never hardcodes a language list.
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local langs = require("config.langs")

    -- Install parsers (async, no-op when already installed; resolves `requires`).
    require("nvim-treesitter").install(langs.parsers())

    -- Map each declared filetype to its parser (e.g. bash parser <-> `sh` filetype).
    for _, lang in pairs(langs) do
      if type(lang) == "table" and lang.parsers and lang.filetypes then
        for _, parser in ipairs(lang.parsers) do
          vim.treesitter.language.register(parser, lang.filetypes)
        end
      end
    end

    -- Enable native treesitter highlighting per declared filetype.
    -- pcall: vim.treesitter.start() asserts when the parser is missing, so fall
    -- back to regex silently until the parser is installed.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs.filetypes(),
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
