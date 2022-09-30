local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
   return
end

local options = {
   ensure_installed = {
      "lua",
      "vim",
      "go"
   },
   -- ensure_installed = "all",
   highlight = {
      enable = true,
      use_languagetree = true,
   },
   indent = { enable = true },
}

treesitter.setup(options)
