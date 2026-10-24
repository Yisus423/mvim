-- obsidian-nvim/obsidian.nvim — note-taking on an Obsidian vault.
--
-- v4 ships obsidian-ls: an in-process LSP (Lua) that already covers markdown
-- PKM — completion for [[links]], #tags and ^blocks, definition, references,
-- rename, document/workspace symbols, folding, inlay hints and code actions.
-- It cannot be disabled (the plugin calls require("obsidian.lsp").start on every
-- vault buffer), so markdown-oxide is deliberately NOT installed: it would
-- duplicate every one of those features on the same buffer.
--
-- lazy = false on purpose: the plugin wires itself through a FileType autocmd, so
-- a lazy `ft = "markdown"` load would miss the first buffer opened from the CLI.
-- It is pure Lua and costs a few milliseconds at startup.
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,

  -- opts as a function so `require("obsidian.builtin")` resolves: lazy.nvim runs
  -- it with the plugin already on the runtimepath.
  opts = function()
    return {
      -- :Obsidian <action> instead of the legacy :ObsidianOpen / :ObsidianNew.
      legacy_commands = false,

      workspaces = {
        { name = "mental-box", path = "~/Documentos/mental-box" },
      },

      -- File name = note title (readable, greppable, git-friendly) instead of the
      -- default random zettel IDs.
      note_id_func = require("obsidian.builtin").title_id,
      notes_subdir = "notas",
      new_notes_location = "notes_subdir",

      daily_notes = {
        enabled = true,
        folder = "diario",
        date_format = "YYYY-MM-DD",
        template = "diaria",
        default_tags = { "diario" },
        workdays_only = false,
      },

      templates = {
        folder = "plantillas",
        date_format = "YYYY-MM-DD",
        time_format = "HH:mm",
      },

      -- Same picker as the rest of mvim (snacks), no extra dependency.
      picker = { name = "snacks.picker" },

      -- The plugin ships its own catppuccin-ish palette; override the groups so
      -- notes keep the Ayu Gold identity of colors/mvim.lua.
      ui = {
        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#ff8f40" },
          ObsidianDone = { bold = true, fg = "#aad94c" },
          ObsidianRightArrow = { bold = true, fg = "#e6b450" },
          ObsidianTilde = { bold = true, fg = "#ff3333" },
          ObsidianImportant = { bold = true, fg = "#ff3333" },
          ObsidianBullet = { bold = true, fg = "#59c2ff" },
          ObsidianRefText = { underline = true, fg = "#e6b450" },
          ObsidianExtLinkIcon = { fg = "#59c2ff" },
          ObsidianTag = { italic = true, fg = "#d2a6ff" },
          ObsidianBlockID = { italic = true, fg = "#565b66" },
          ObsidianHighlightText = { bg = "#1f2430" },
        },
      },
    }
  end,
}
