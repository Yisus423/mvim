local opt = vim.opt

-- Lines and columns
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Relative numbers for quick jumps
opt.signcolumn = "yes"    -- Always show the column simbols (avoid screen jumps)

-- Undo history persists across sessions (undo file in .local/state/mvim)
opt.undofile = true

-- Splits open below / to the right (modern behavior, not classic Vim)
opt.splitbelow = true
opt.splitright = true

-- Tabs and indentations
opt.tabstop = 2           -- 2 spaces per tab
opt.shiftwidth = 2        -- 2 spaces for automatic indentation
opt.expandtab = true      -- Convert tabs in spaces
opt.autoindent = true     -- Mantain the indentation of prev line

-- Search
opt.ignorecase = true     -- Ignore uppercase/lowercase in searchs
opt.smartcase = true      -- Case-sensitive if a uppercase is entered

-- Interface
opt.termguicolors = true  -- TrueColors of 24 bits
opt.mouse = "a"           -- Active the mouse support
opt.clipboard = "unnamedplus" -- Sync the system clipboard
opt.cursorline = true     -- Highlight the current line
opt.scrolloff = 8         -- Mantain the 8 lines margin to scroll
opt.syntax = "on"         -- Syntax highlighting
opt.whichwrap = "h,l,<,>,[,]" -- Allow h/l and arrow keys to wrap across lines

-- Responsiveness: CursorHold events (gitsigns refresh) fire at 300ms instead
-- of 4000ms; leader keymaps respond after 400ms instead of a full second.
opt.updatetime = 300
opt.timeoutlen = 400
