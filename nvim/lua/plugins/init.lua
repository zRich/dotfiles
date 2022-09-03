vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use { "fatih/molokai" }

  use {
    "prettier/vim-prettier",
    run = "yarn install",
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.configs.null-ls").setup()
    end,
  }
  use { "nvim-lua/plenary.nvim" }
  use { "lewis6991/impatient.nvim" }

  use {
    "wbthomason/packer.nvim",
    event = "VimEnter",
  }

  use {
    "kyazdani42/nvim-web-devicons",
    -- after = "base46",
    config = function()
      require "plugins.configs.icons"
    end,
  }

  -- markdown
  use {
    'godlygeek/tabular',
  }

  use {
    'plasticboy/vim-markdown',
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  use {
    'vim-airline/vim-airline'
  }

  use {
    'vim-airline/vim-airline-themes'
  }


  -- use {
  --   "feline-nvim/feline.nvim",
  --   after = "nvim-web-devicons",
  --   config = function()
  --     require "plugins.configs.statusline"
  --   end,
  -- }

  use {
    'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons',
    setup = function()
      require("core.mappings").bufferline()
    end,
    config = function()
      require("plugins.configs.bufferline")
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.others").blankline()
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  }

  -- git stuff
  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
    setup = function()
      require("core.utils").packer_lazy_load "gitsigns.nvim"
    end,
  }

  -- lsp stuff

  use {
    "williamboman/nvim-lsp-installer",
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load "nvim-lsp-installer"
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
      end, 0)
    end,
  }

  use {
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
    module = "lspconfig",
    config = function()
      require "plugins.configs.lsp_installer"
      require "plugins.configs.lspconfig"
    end,
  }

  use {
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.configs.others").signature()
    end,
  }

  use {
    "andymass/vim-matchup",
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load "vim-matchup"
    end,
  }

  -- go lang
  use {
    "fatih/vim-go",
    setup = function()
      require("plugins.configs.go").vimgo()
    end
  }

  -- debug
  -- use {
  --   'sebdah/vim-delve'
  -- }

  -- use {
  --   'puremourning/vimspector'
  -- }

  use {
    "mfussenegger/nvim-dap",
  }

  use {
    "leoluz/nvim-dap-go",
    config = function()
      require("plugins.configs.dap")
    end,
    setup = function()
      require("core.mappings").godebug()
    end
  }

  use { "nvim-telescope/telescope-dap.nvim" }

  use {
    "rcarriga/nvim-dap-ui",
    -- requires = {"mfussenegger/nvim-dap"},
  }

  use {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("plugins.configs.others").better_escape()
    end,
  }

  -- load luasnips + cmp related in insert mode only

  use {
    "rafamadriz/friendly-snippets",
    module = "cmp_nvim_lsp",
    event = "InsertEnter",
  }

  use {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  }

  use {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  }

  use {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  }

  use {
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  }

  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  }

  use {
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  }

  use {
    "hrsh7th/cmp-path",
    after = "cmp-buffer",
  }

  -- misc plugins
  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  }

  use {
    "goolord/alpha-nvim",
    disable = true,
    config = function()
      require "plugins.configs.alpha"
    end,
  }

  use {
    "tpope/vim-commentary"
  }

  -- file managing , picker etc
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    setup = function()
      require("core.mappings").nvimtree()
    end,

    config = function()
      require "plugins.configs.nvimtree"
    end,
  }

  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",

    setup = function()
      require("core.mappings").telescope()
    end,

    config = function()
      require "plugins.configs.telescope"
    end,
  }
end)
