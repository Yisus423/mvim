local map = vim.keymap.set
-- Fast window navigation with Ctrl + direction
map("n", "<C-h>", "<C-w>h", { desc = "Ir a ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ir a ventana abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ir a ventana arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Ir a ventana derecha" })

-- Escape of insert mode with 'jk'
map("i", "jk", "<ESC>", { desc = "Salir del modo insertar" })

-- Mantain selection when indent blocks in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Snacks picker (native rg/fd, no telescope)
map("n", "<leader>ff", function() require("snacks.picker").files() end, { desc = "Buscar archivos" })
map("n", "<leader>fg", function() require("snacks.picker").grep() end, { desc = "Buscar en archivos (grep)" })
map("n", "<leader>fb", function() require("snacks.picker").buffers() end, { desc = "Listar buffers" })
map("n", "<leader>fr", function() require("snacks.picker").recent() end, { desc = "Archivos recientes" })

-- Terminals (snacks.terminal, Alt + h/v/i)
map("n", "<M-h>", function() require("snacks.terminal").toggle(nil, { win = { position = "bottom" } }) end, { desc = "Terminal en split horizontal" })
map("n", "<M-v>", function() require("snacks.terminal").toggle(nil, { win = { position = "right" } }) end, { desc = "Terminal en split vertical" })
map("n", "<M-i>", function() require("snacks.terminal").toggle(nil, { win = { position = "float", width = 0.75, height = 0.6 } }) end, { desc = "Terminal flotante" })

-- Buffers: cycle, list, close (the NvChad-tab replacement)
map("n", "]b", function() vim.cmd.bnext() end, { desc = "Siguiente buffer" })
map("n", "[b", function() vim.cmd.bprev() end, { desc = "Anterior buffer" })
map("n", "<leader>bd", function() vim.cmd.bd() end, { desc = "Cerrar buffer" })

-- LSP: diagnostics navigation + detail
map("n", "K", vim.lsp.buf.hover, { desc = "Detalle bajo el cursor (LSP)" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Diagnóstico anterior" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Diagnóstico siguiente" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Detalle de diagnóstico (flotante)" })

-- LSP: navigation + refactor (native, no plugin)
map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a la definición" })
map("n", "gr", vim.lsp.buf.references, { desc = "Referencias del símbolo" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Ir a la implementación" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar símbolo" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action (LSP)" })
