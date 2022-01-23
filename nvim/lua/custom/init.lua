-- This is an example init file , its supposed to be placed in /lua/custom/

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so dont worry about it

-- Install plugins
local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
   -- use {
   --    "max397574/better-escape.nvim",
   --    event = "InsertEnter",
   -- }

 use {
      "williamboman/nvim-lsp-installer",
   }

 use {
     'ray-x/go.nvim'
   }

  use {
    'TovarishFin/vim-solidity'
  }

  use {
    'folke/tokyonight.nvim'
  }

  use {
    'patstockwell/vim-monokai-tasty'
  }

  use {
    'ishan9299/nvim-solarized-lua'
  }
 end)

-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event','cmd' fields)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
--
require('go').setup()
-- require("auto_cmds")
