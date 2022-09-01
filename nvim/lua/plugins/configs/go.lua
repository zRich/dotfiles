local M = {}

M.vimgo = function ()
  vim.g.go_addtags_transform = "camelcase"
end

return M
