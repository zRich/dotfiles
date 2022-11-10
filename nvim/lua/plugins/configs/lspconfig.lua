local present, lspconfig = pcall(require, "lspconfig")

if not present then
   return
end

local M = {}

require("plugins.configs.others").lsp_handlers()

-- function M.on_attach(client, _)
--    -- client.resolved_capabilities.document_formatting = false
--    -- client.resolved_capabilities.document_range_formatting = false

--    require("core.mappings").lspconfig()
-- end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

lspconfig.sumneko_lua.setup {
   -- on_attach = M.on_attach,
   capabilities = capabilities,

   settings = {
      Lua = {
         diagnostics = {
            globals = { "vim" },
         },
         workspace = {
            library = {
               [vim.fn.expand "$VIMRUNTIME/lua"] = true,
               [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
         },
      },
   },
}

lspconfig.tailwindcss.setup {
  -- on_attach = M.on_attach,
  capabilities = capabilities,
  filetypes = {"typescript", "typescriptreact", "typescript.tsx"}
}

local servers = { 'gopls', 'rust_analyzer', 'tsserver', 'astro', 'bufls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    -- on_attach = M.on_attach,
    capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end

return M
