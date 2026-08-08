-- saghen/blink.cmp — completion. Pinned to the stable v1 line (v2 requires blink.lib
-- and is under active breaking changes). No LSP sources yet: buffer, path, snippets only.
return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function(_, opts)
    vim.opt.completeopt = "menu,menuone,noselect"
    require("blink.cmp").setup(opts)
  end,
  opts = {
    -- 'default': C-space trigger, C-n/C-p next/prev, C-e hide, C-y accept.
    -- Tab/Shift-Tab snippet placeholder navigation is built in.
    keymap = { preset = "default" },
    appearance = {
      nerd_font_variant = "mono",
    },
    sources = {
      -- `lsp` is built-in (blink.cmp.sources.lsp); the rest are fallbacks.
      -- buffer only shows when LSP returns no items.
      default = { "lsp", "buffer", "path", "snippets" },
    },
    completion = {
      documentation = { auto_show = false },
    },
    -- v1 ships a prebuilt binary on tags; falls back to Lua with a warning if missing.
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
