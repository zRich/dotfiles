require "modules.options"
require "modules.keymaps"
require "modules.plugins"
require "modules.colorscheme"
require "modules.cmp"
require "modules.lsp"
require "modules.telescope"
require "modules.treesitter"
require "modules.autopairs"
require("modules.go").setup()

-- Format on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)

-- Import on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
