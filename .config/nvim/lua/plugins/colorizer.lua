return { -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "css",
          "javascript",
          html = { mode = "foreground" },
        },
      })
    end,
  },
}
