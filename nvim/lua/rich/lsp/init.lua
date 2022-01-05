local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("rich.lsp.lsp-installer")
require("rich.lsp.handlers").setup()
