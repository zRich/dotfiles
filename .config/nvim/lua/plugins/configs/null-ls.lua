local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

  b.formatting.prettier.with {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "yaml", "markdown", "graphql", "sh" },
    extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
  -- b.formatting.deno_fmt,

  -- Lua
  -- b.formatting.stylua,
  -- b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function()
  null_ls.setup {
    debug = true,
    sources = sources,

    -- format on save
    on_attach = function(client)
      if client.server_capabilities.document_formatting then
        vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
      end
    end,
  }
end

return M
