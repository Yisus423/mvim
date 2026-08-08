-- Language registry: one file per language (see lua/config/langs/).
-- Each entry declares its parsers and filetypes; consumers (plugins like
-- nvim-treesitter) read this instead of hardcoding a language list.
-- Adding a language = adding one file here.
local langs = {
  "go",
  "python",
  "bash",
  "nim",
  "zig",
  "javascript",
}

local M = {}

for _, name in ipairs(langs) do
  M[name] = require("config.langs." .. name)
end

---All declared parsers, deduplicated.
function M.parsers()
  local parsers = {}
  for _, lang in pairs(M) do
    if type(lang) == "table" and lang.parsers then
      for _, parser in ipairs(lang.parsers) do
        parsers[parser] = true
      end
    end
  end
  return vim.tbl_keys(parsers)
end

---All declared filetypes, deduplicated.
function M.filetypes()
  local filetypes = {}
  for _, lang in pairs(M) do
    if type(lang) == "table" and lang.filetypes then
      for _, ft in ipairs(lang.filetypes) do
        filetypes[ft] = true
      end
    end
  end
  return vim.tbl_keys(filetypes)
end

return M
