-- colors/mvim.lua
-- mvim — hand-rolled colorscheme, identity "Ayu Gold".
-- Built on the ayu-dark palette, with gold (#e6b450) as the primary accent.
-- Every group is set explicitly; nothing is inherited from a distro.

local vim = vim

-- Palette -----------------------------------------------------------------
local C = {
  -- Core (from ~/dotfiles/colors.md)
  bg       = "#0a0e14", -- Background (editor)
  bg_float = "#10151d", -- Subtle elevation: floats, menus, panels
  bg_alt   = "#1f2430", -- Active surfaces: statusline, winbar, tabline
  fg       = "#b3b1ad", -- Foreground
  gold     = "#e6b450", -- Primary: accents, keywords, active UI
  cyan     = "#59c2ff", -- Secondary: types, info, links
  red      = "#ff3333", -- Alert: errors, deletions
  disabled = "#475266", -- Inactive text, line numbers

  -- Extensions from the ayu-dark palette (same identity)
  green     = "#aad94c", -- Strings, additions
  orange    = "#ff8f40", -- Numbers, warnings
  purple    = "#d2a6ff", -- Hints, rare accents
  comment   = "#565b66", -- Comments, punctuation
  line      = "#131721", -- Cursorline
  selection = "#253340", -- Visual selection
  border    = "#2d3640", -- Window separators, borders
}

local function hl(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

vim.o.background = "dark"

-- Editor core -------------------------------------------------------------
hl("Normal",        { fg = C.fg, bg = C.bg })
hl("NormalNC",      { fg = C.fg, bg = C.bg })
hl("NormalFloat",   { fg = C.fg, bg = C.bg_float })
hl("FloatNormal",   { fg = C.fg, bg = C.bg_float })
hl("FloatBorder",   { fg = C.border, bg = C.bg_float })
hl("FloatTitle",    { fg = C.gold, bg = C.bg_float })
hl("LineNr",        { fg = C.disabled, bg = C.bg })
hl("CursorLineNr",  { fg = C.gold, bg = C.bg })
hl("CursorLine",    { bg = C.line })
hl("CursorColumn",  { bg = C.line })
hl("Cursor",        { fg = C.bg, bg = C.gold })
hl("lCursor",       { fg = C.bg, bg = C.gold })
hl("SignColumn",    { fg = C.fg, bg = C.bg })
hl("ColorColumn",   { bg = C.line })
hl("EndOfBuffer",   { fg = C.bg_alt, bg = C.bg })
hl("WinSeparator",  { fg = C.border })
hl("VertSplit",     { fg = C.border })
hl("WinBar",        { fg = C.fg, bg = C.bg })
hl("WinBarNC",      { fg = C.disabled, bg = C.bg })
hl("StatusLine",    { fg = C.fg, bg = C.bg_alt })
hl("StatusLineNC",  { fg = C.disabled, bg = C.bg })
hl("MsgArea",       { fg = C.fg, bg = C.bg })
hl("ModeMsg",       { fg = C.gold, bold = true })
hl("MoreMsg",       { fg = C.cyan })
hl("Question",      { fg = C.gold })
hl("Title",         { fg = C.gold, bold = true })
hl("Directory",     { fg = C.cyan })
hl("ErrorMsg",      { fg = C.red, bg = C.bg })
hl("WarningMsg",    { fg = C.orange })

-- Search ------------------------------------------------------------------
hl("Search",        { fg = C.bg, bg = C.gold })
hl("CurSearch",     { fg = C.bg, bg = C.cyan })
hl("IncSearch",     { fg = C.bg, bg = C.cyan })
hl("QuickFixLine",  { fg = C.gold, bg = C.selection })

-- Selection and menus ------------------------------------------------------
hl("Visual",        { bg = C.selection })
hl("VisualNOS",     { bg = C.selection })
hl("Pmenu",         { fg = C.fg, bg = C.bg_float })
hl("PmenuSel",      { fg = C.bg, bg = C.gold })
hl("PmenuSbar",     { bg = C.bg })
hl("PmenuThumb",    { bg = C.disabled })
hl("WildMenu",      { fg = C.bg, bg = C.gold })

-- Gutter and fill ----------------------------------------------------------
hl("NonText",       { fg = C.disabled })
hl("SpecialKey",    { fg = C.disabled })
hl("Whitespace",    { fg = C.border })
hl("Conceal",       { fg = C.disabled })
hl("MatchParen",    { fg = C.gold, bg = C.selection, bold = true })
hl("Folded",        { fg = C.disabled, bg = C.bg_alt })
hl("FoldColumn",    { fg = C.disabled, bg = C.bg })
hl("TabLine",       { fg = C.disabled, bg = C.bg_alt })
hl("TabLineSel",    { fg = C.gold, bg = C.bg })
hl("TabLineFill",   { bg = C.bg_alt })
hl("TermCursor",    { fg = C.bg, bg = C.gold })

-- Syntax ------------------------------------------------------------------
hl("Comment",       { fg = C.comment, italic = true })
hl("Constant",      { fg = C.orange })
hl("String",        { fg = C.green })
hl("Character",     { fg = C.orange })
hl("Number",        { fg = C.orange })
hl("Boolean",       { fg = C.orange })
hl("Float",         { fg = C.orange })
hl("Identifier",    { fg = C.fg })
hl("Function",      { fg = C.gold })
hl("Statement",     { fg = C.gold })
hl("Conditional",   { fg = C.gold })
hl("Repeat",        { fg = C.gold })
hl("Label",         { fg = C.gold })
hl("Operator",      { fg = C.cyan })
hl("Keyword",       { fg = C.gold })
hl("Exception",     { fg = C.orange })
hl("PreProc",       { fg = C.orange })
hl("Include",       { fg = C.orange })
hl("Define",        { fg = C.orange })
hl("Macro",         { fg = C.orange })
hl("PreCondit",     { fg = C.orange })
hl("Type",          { fg = C.cyan })
hl("StorageClass",  { fg = C.cyan })
hl("Structure",     { fg = C.cyan })
hl("Typedef",       { fg = C.cyan })
hl("Special",       { fg = C.gold })
hl("SpecialChar",   { fg = C.gold })
hl("Tag",           { fg = C.gold })
hl("Delimiter",     { fg = C.comment })
hl("SpecialComment",{ fg = C.cyan, italic = true })
hl("Debug",         { fg = C.orange })
hl("Underlined",    { fg = C.cyan, underline = true })
hl("Error",         { fg = C.red })
hl("Todo",          { fg = C.gold, bg = C.bg_alt, bold = true })

-- Treesitter --------------------------------------------------------------
hl("@comment",             { fg = C.comment, italic = true })
hl("@keyword",             { fg = C.gold })
hl("@keyword.function",    { fg = C.gold })
hl("@keyword.return",      { fg = C.gold })
hl("@keyword.operator",    { fg = C.gold })
hl("@keyword.exception",   { fg = C.orange })
hl("@conditional",         { fg = C.gold })
hl("@repeat",              { fg = C.gold })
hl("@exception",           { fg = C.orange })
hl("@label",               { fg = C.gold })
hl("@include",             { fg = C.orange })
hl("@string",              { fg = C.green })
hl("@string.escape",       { fg = C.gold })
hl("@string.regex",        { fg = C.orange })
hl("@string.special",      { fg = C.orange })
hl("@character",           { fg = C.orange })
hl("@number",              { fg = C.orange })
hl("@boolean",             { fg = C.orange })
hl("@float",               { fg = C.orange })
hl("@function",            { fg = C.gold })
hl("@function.builtin",    { fg = C.cyan })
hl("@function.macro",      { fg = C.gold })
hl("@method",              { fg = C.gold })
hl("@type",                { fg = C.cyan })
hl("@type.builtin",        { fg = C.cyan })
hl("@type.qualifier",      { fg = C.gold })
hl("@constant",            { fg = C.orange })
hl("@constant.builtin",    { fg = C.orange })
hl("@constructor",         { fg = C.cyan })
hl("@operator",            { fg = C.cyan })
hl("@property",            { fg = C.cyan })
hl("@field",               { fg = C.fg })
hl("@variable",            { fg = C.fg })
hl("@variable.builtin",    { fg = C.cyan })
hl("@variable.member",     { fg = C.fg })
hl("@variable.parameter",  { fg = C.fg })
hl("@namespace",           { fg = C.cyan })
hl("@attribute",           { fg = C.purple })
hl("@tag",                 { fg = C.gold })
hl("@tag.attribute",       { fg = C.cyan })
hl("@tag.delimiter",       { fg = C.comment })
hl("@punctuation",         { fg = C.comment })
hl("@punctuation.delimiter", { fg = C.comment })
hl("@punctuation.bracket", { fg = C.comment })
hl("@punctuation.special", { fg = C.gold })
hl("@error",               { fg = C.red })

-- Markdown / text ----------------------------------------------------------
hl("@text",            { fg = C.fg })
hl("@text.title",      { fg = C.gold, bold = true })
hl("@text.uri",        { fg = C.cyan, underline = true })
hl("@text.literal",    { fg = C.green })
hl("@text.reference",  { fg = C.gold })
hl("@text.emphasis",   { italic = true })
hl("@text.strong",     { bold = true })
hl("@text.underline",  { underline = true })
hl("@text.diff.add",   { fg = C.green })
hl("@text.diff.delete",{ fg = C.red })
hl("@markup.heading",  { fg = C.gold, bold = true })
hl("@markup.link",     { fg = C.cyan, underline = true })
hl("@markup.italic",   { italic = true })
hl("@markup.bold",     { bold = true })
hl("@markup.strikethrough", { strikethrough = true })
hl("@markup.list",     { fg = C.gold })
hl("@markup.raw",      { fg = C.green })
hl("@markup.quote",    { fg = C.comment, italic = true })

-- Diff --------------------------------------------------------------------
hl("DiffAdd",    { fg = C.green, bg = "#1c2b16" })
hl("DiffChange", { fg = C.fg, bg = "#2b3342" })
hl("DiffDelete", { fg = C.red, bg = "#3a2020" })
hl("DiffText",   { fg = C.gold, bg = "#453a12" })

-- Diagnostics and LSP ------------------------------------------------------
hl("DiagnosticError",           { fg = C.red })
hl("DiagnosticWarn",            { fg = C.orange })
hl("DiagnosticInfo",            { fg = C.cyan })
hl("DiagnosticHint",            { fg = C.purple })
hl("DiagnosticOk",              { fg = C.green })
hl("DiagnosticUnderlineError",  { undercurl = true, sp = C.red })
hl("DiagnosticUnderlineWarn",   { undercurl = true, sp = C.orange })
hl("DiagnosticUnderlineInfo",   { undercurl = true, sp = C.cyan })
hl("DiagnosticUnderlineHint",   { undercurl = true, sp = C.purple })
hl("DiagnosticVirtualTextError",{ fg = C.red })
hl("DiagnosticVirtualTextWarn", { fg = C.orange })
hl("DiagnosticVirtualTextInfo", { fg = C.cyan })
hl("DiagnosticVirtualTextHint", { fg = C.purple })
hl("LspReferenceText",          { bg = C.selection })
hl("LspReferenceRead",          { bg = C.selection })
hl("LspReferenceWrite",         { bg = C.selection })
hl("LspSignatureActiveParameter", { fg = C.gold, bold = true, underline = true })

-- Git signs (gitsigns.nvim) ------------------------------------------------
hl("GitSignsAdd",    { fg = C.green })
hl("GitSignsChange", { fg = C.gold })
hl("GitSignsDelete", { fg = C.red })

-- Spelling ----------------------------------------------------------------
hl("SpellBad",   { undercurl = true, sp = C.red })
hl("SpellCap",   { undercurl = true, sp = C.cyan })
hl("SpellLocal", { undercurl = true, sp = C.gold })
hl("SpellRare",  { undercurl = true, sp = C.purple })

-- Plugin UI (snacks.nvim windows, picker, terminal, blink.cmp menus) -------
-- snacks sets these with default=true, so our definitions win and keep the
-- Ayu Gold identity instead of falling back to its built-in defaults.
-- Surface hierarchy: editor (bg) < floats (bg_float) < bars (bg_alt).
-- NOTE: picker chrome uses SnacksPicker* groups; other floats use Snacks*.
hl("FloatFooter",           { fg = C.disabled, bg = C.bg_float })
hl("SnacksBackdrop",        { bg = C.bg })
hl("SnacksNormal",          { fg = C.fg, bg = C.bg_float })
hl("SnacksNormalNC",        { fg = C.disabled, bg = C.bg_float })
hl("SnacksTitle",           { fg = C.gold, bg = C.bg_float })
hl("SnacksFooter",          { fg = C.disabled, bg = C.bg_float })
hl("SnacksWinBar",          { fg = C.gold, bg = C.bg_float })
hl("SnacksWinBarNC",        { fg = C.disabled, bg = C.bg_float })
hl("SnacksWinSeparator",    { fg = C.border, bg = C.bg_float })
hl("SnacksWinKey",          { fg = C.gold })
hl("SnacksWinKeyDesc",      { fg = C.fg })
hl("SnacksPicker",          { fg = C.fg, bg = C.bg_float })
hl("SnacksPickerTitle",     { fg = C.gold, bg = C.bg_float })
hl("SnacksPickerBorder",    { fg = C.border, bg = C.bg_float })
hl("SnacksPickerFooter",    { fg = C.disabled, bg = C.bg_float })
hl("SnacksPickerCursorLine",{ bg = C.line })
hl("BlinkCmpMenuBorder",    { fg = C.border, bg = C.bg_float })
hl("BlinkCmpDocBorder",     { fg = C.border, bg = C.bg_float })
