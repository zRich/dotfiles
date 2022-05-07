-- This is an example init file , its supposed to be placed in /lua/custom/

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>rn", ":lua vim.lsp.buf.rename() <CR>")
map("n", "<C-DOWN>", ":m +1 <CR>==")
map("n", "<C-UP>", ":m -2 <CR>==")
map("v", "<C-Down>", ":m '>+1 <CR>gv=gv")
map("v", "<C-Up>", ":m '<-2 <CR>gv=gv")
-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so dont worry about it

--require('go').setup()
