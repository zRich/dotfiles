local M = {}

M.setup_lsp = function(attach, capabilities)
   local lsp_installer = require "nvim-lsp-installer"

   lsp_installer.settings {
      ui = {
         icons = {
            server_installed = "﫟" ,
            server_pending = "",
            server_uninstalled = "✗",
         },
      },
   }

   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
         settings = {},
      }

      if server.name == 'gopls' then 
        -- require('go').setup{}
        -- opts = require'go.lsp'.config()
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})  
      end
      
      if server.name == 'tsserver' then 
        opts.on_attach = function(client, bufnr)
           client.resolved_capabilities.document_formatting = false
        end
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end
      
    local sumneko_root_path = "/usr/local/bin/lua-language-server/"
    local sumneko_binary = "/usr/local/bin/lua-language-server/bin/lua-language-server"

    if server.name == 'sumneko_lua' then
    opts.cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua"}
    opts.settings = {
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
    }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
  end    

  server:setup(opts)
      -- vim.cmd [[ do User LspAttachBuffers ]]
   end)
end

return M
