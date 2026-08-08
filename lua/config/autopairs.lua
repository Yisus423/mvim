-- lua/config/autopairs.lua
-- Native auto-pairs: minimal hand-rolled replacement for nvim-autopairs /
-- mini.pairs. Insert-mode expr mappings open matching closers, jump over an
-- existing closer, and delete empty pairs with <BS>.
--
-- Rules modeled on mini.pairs (echasnovski):
-- - A pair opens only when the char left of the cursor is not `\` (escaped).
-- - `'` also refuses to open right after a word char, keeping `don't` intact.
-- - <BS> inside an empty pair deletes both chars.
-- - <C-g>U keeps undo and dot-repeat working across the cursor move.
-- <CR> is intentionally NOT handled here: blink.cmp already maps it to
-- accept+fallback and owns completion; an autopairs CR would fight it.

local M = {}

-- Per-key pair info: pair string + neighborhood pattern. The pattern is
-- matched against the two chars around the cursor (left, right); `\r`/`\n`
-- stand for line start/end. Default `..` (anything) is fine for closers.
local PAIRS = {
  ["("] = { pair = "()", pattern = "^[^\\]" },
  [")"] = { pair = "()", pattern = ".." },
  ["["] = { pair = "[]", pattern = "^[^\\]" },
  ["]"] = { pair = "[]", pattern = ".." },
  ["{"] = { pair = "{}", pattern = "^[^\\]" },
  ["}"] = { pair = "{}", pattern = ".." },
  ['"'] = { pair = '""', pattern = "^[^\\]" },
  ["'"] = { pair = "''", pattern = "^[^%a\\]" },
  ["`"] = { pair = "``", pattern = "^[^\\]" },
}

-- Set of recognized empty pairs for the smart <BS> (`open..close`).
local REGISTERED = {}
for _, info in pairs(PAIRS) do
  REGISTERED[info.pair] = true
end

-- Keys whose action is "closeopen" (symmetrical: `"` `'` `` ` ``).
local CLOSEOPEN_KEYS = { ['"'] = true, ["'"] = true, ["`"] = true }

-- Neighborhood helpers (multibyte-safe). In insert mode the cursor sits
-- between two chars: get_neigh('whole') = (left, right).
local function get_neigh(neigh_type)
  local line = "\r" .. vim.api.nvim_get_current_line() .. "\n"
  local col = vim.fn.charcol(".")
  local start = col - 1 -- 0-based index of the char left of the cursor
  if neigh_type == "right" then
    return vim.fn.strcharpart(line, start + 1, 1)
  end
  return vim.fn.strcharpart(line, start, 2)
end

local function matches(info)
  return get_neigh("whole"):find(info.pattern) ~= nil
end

local function open_pair(info)
  if not matches(info) then
    return vim.fn.strcharpart(info.pair, 0, 1)
  end
  -- Insert the full pair, then move back inside it without breaking undo.
  return info.pair .. "<C-g>U<Left>"
end

local function close_pair(info)
  local close = vim.fn.strcharpart(info.pair, 1, 1)
  if get_neigh("right") == close then
    return "<C-g>U<Right>"
  end
  return close
end

local function closeopen_pair(info)
  local close = vim.fn.strcharpart(info.pair, 1, 1)
  if get_neigh("right") == close then
    return "<C-g>U<Right>"
  end
  return open_pair(info)
end

-- Map every key: brackets get open/close actions, quotes get closeopen.
for key, info in pairs(PAIRS) do
  local open, close = info.pair:sub(1, 1), info.pair:sub(2, 2)
  local action = CLOSEOPEN_KEYS[key] and closeopen_pair or (key == open and open_pair or close_pair)
  local desc = "Auto-pair " .. info.pair:sub(1, 1) .. "/" .. (close ~= "" and close or info.pair:sub(2, 2))
  vim.keymap.set("i", key, function() return action(info) end, { expr = true, desc = desc })
end

-- <BS>: if the two chars around the cursor are a recognized empty pair,
-- delete the closer too (feed <Del> after the normal <BS>).
local function bs(key)
  if REGISTERED[get_neigh("whole")] then
    return key .. "<Del>"
  end
  return key
end
vim.keymap.set("i", "<BS>", function() return bs("<BS>") end, {
  expr = true,
  desc = "Auto-pair: delete empty pair",
})

return M
