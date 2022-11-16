vim.cmd [[packadd packer.nvim]]

-- usage https://github.com/wbthomason/packer.nvim
-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

return require('packer').startup(function(use)
  use { "morhetz/gruvbox" }

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
    config = function()
      require "plugins.configs.icons"
    end,
  }

  -- use {
  --   'stevearc/aerial.nvim',
  --   config = function()
  --     require('aerial').setup()
  --   end
  -- }

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
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("plugins.configs.lualine")
    end
  }

  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    setup = function()
      require("core.mappings").bufferline()
    end,
    config = function()
      require("plugins.configs.bufferline")
    end,
  }

  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("plugins.configs.terminal")
    end
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
  }

  use {
    "windwp/nvim-ts-autotag",
    config = function()
      require("plugins.configs.treesitter")
    end,
  }

  -- git stuff
  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  }


  use {
    "preservim/tagbar",
  }
  -- lsp stuff

  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }

  use {
    'williamboman/mason-lspconfig.nvim'
  }


  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
    setup = function()
      require("core.mappings").lspconfig()
    end
  }

  use {
    "andymass/vim-matchup",
    opt = true,
  }

  -- go lang
  use {
    "fatih/vim-go",
    setup = function()
      require("plugins.configs.go").vimgo()
    end
  }

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
    config = function()
      require("plugins.configs.dap-ui")
    end
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

  use {
    "onsails/lspkind-nvim"
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


  use {
    'aklt/plantuml-syntax'
  }

  use {
    'tyru/open-browser.vim'
  }

  use {
    'weirongxu/plantuml-previewer.vim'
  }

end)
