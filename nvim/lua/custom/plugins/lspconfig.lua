local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config

  local servers = { "gopls", "sumneko_lua" }
   -- local servers = { "gopls" }

  -- for _, lsp in ipairs(servers) do
  --     lspconfig[lsp].setup {
  --        on_attach = attach,
  --        capabilities = capabilities,
  --        flags = {
  --           debounce_text_changes = 150,
  --        },
  --     }
  -- end
   
  lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }

  local sumneko_root_path = "/usr/local/bin/lua-language-server/"
  local sumneko_binary = "/usr/local/bin/lua-language-server/bin/lua-language-server"

  require'lspconfig'.sumneko_lua.setup {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
      Lua = {
        runtime = {
          version = "Lua 5.3",
          path = vim.split(package.path, ';')
          },
        diagnostics = {
          globals = {"vim"},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file(';', true),
        },
      },
    },
  }
end

return M

