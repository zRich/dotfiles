local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local options = {
  ensure_installed = {
    "lua",
    "vim",
    "go",
    "toml",
    "css",
    "tsx",
    "css",
    "html",
    "lua"
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  autotag = {
    enable = true,
  },
  indent = { enable = true },
}

treesitter.setup(options)
