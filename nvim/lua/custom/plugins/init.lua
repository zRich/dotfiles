return {
-- {
--      "williamboman/nvim-lsp-installer"
--    },

  {
    'fatih/vim-go'
  },

  {
    'TovarishFin/vim-solidity'
  },

  {
    'folke/tokyonight.nvim'
  },

  {
    'patstockwell/vim-monokai-tasty'
  },

  {
    'ishan9299/nvim-solarized-lua'
  },

  {
    'leafgarland/typescript-vim'
  },

  {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   },

  {
    'sbdchd/neoformat'
  },

  {
    'prettier/vim-prettier',
    run = 'yarn install',
  },

}
