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
