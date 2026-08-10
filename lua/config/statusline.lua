-- lua/config/statusline.lua
-- Minimal hand-rolled global statusline.
-- snacks.nvim removed its statusline module in v2.x, so this is the native
-- replacement. Git branch comes from gitsigns' cached per-buffer dict.
-- Icons: filetype icon comes from mini.icons (colored with its own hl
-- group). Diagnostic severity icons are hardcoded Nerd glyphs because
-- mini.icons' 'lsp' category covers LSP kinds, not DiagnosticSeverity names.

local M = {}

local ok_icons, icons = pcall(require, "mini.icons")
if not ok_icons then
  icons = nil
end

local MODES = {
  n = "N", i = "I", v = "V", V = "V-L", ["\22"] = "V-B", c = "C",
  R = "R", r = "R-P", t = "T", s = "S", S = "S-L", ["\19"] = "S-B",
  ["!"] = "SH", ["?"] = "CF",
}

-- Nerd Font glyphs (fa set), verified present in JetBrainsMono Nerd Font.
-- Built via nr2char so the source stays ASCII (no multibyte literal risk).
local DIAG_ICONS = {
  [1] = vim.fn.nr2char(0xf057), -- Error: fa-times-circle
  [2] = vim.fn.nr2char(0xf071), -- Warn: fa-exclamation-triangle
}

function M.statusline()
  local mode = vim.api.nvim_get_mode().mode
  local mode_str = MODES[mode] or mode:upper()

  local file = vim.fn.expand("%:~:.")
  if file == "" then
    file = "[Sin nombre]"
  end
  if vim.bo.modified then
    file = file .. " +"
  elseif vim.bo.readonly then
    file = file .. " [RO]"
  end
  file = file:gsub("%%", "%%%%")

  -- Filetype icon, colored with mini.icons' own hl group (e.g. MiniIconsAzure).
  -- `icons` is nil only if mini.icons failed to load; fall back to no icon.
  if icons then
    local icon, icon_hl = icons.get("filetype", vim.bo.filetype)
    file = ("%%#%s# %s %%*%s"):format(icon_hl, icon, file)
  end

  local branch = ""
  local dict = vim.b.gitsigns_status_dict
  if dict and dict.head then
    branch = " " .. dict.head
  end

  local diag = vim.diagnostic.count(0)
  local errs, warns = diag[1] or 0, diag[2] or 0

  local line, col = vim.fn.line("."), vim.fn.col(".")
  local total = vim.fn.line("$")
  local pct = total > 0 and ("%d%%%%"):format(math.floor((line / total) * 100)) or ""

  local left = "%#Title# " .. mode_str .. "%*  " .. file .. branch
  local right = ""
  if errs > 0 then
    right = right .. ("%%#DiagnosticError# %s %d %%*"):format(DIAG_ICONS[1], errs)
  end
  if warns > 0 then
    right = right .. ("%%#DiagnosticWarn# %s %d %%*"):format(DIAG_ICONS[2], warns)
  end
  right = right .. ("  %d:%d  %s "):format(line, col, pct)

  return left .. "%=" .. right
end

return M
