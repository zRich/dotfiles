local function map(mode, keys, command, opt)
   -- local options = { silent = true }
   local options = { noremap = true, silent = true }

   if opt then
      options = vim.tbl_extend("force", options, opt)
   end

   if type(keys) == "table" then
      for _, keymap in ipairs(keys) do
         map(mode, keymap, command, opt)
      end
      return
   end

   vim.keymap.set(mode, keys, command, opt)
end


local function close_buffer(force)
   if vim.bo.buftype == "terminal" then
      vim.api.nvim_win_hide(0)
      return
   end

   local fileExists = vim.fn.filereadable(vim.fn.expand "%p")
   local modified = vim.api.nvim_buf_get_option(vim.fn.bufnr(), "modified")

   -- if file doesnt exist & its modified
   if fileExists == 0 and modified then
      print "no file name? add it now!"
      return
   end

   force = force or not vim.bo.buflisted or vim.bo.buftype == "nofile"

   -- if not force, change to prev buf and then close current
   local close_cmd = force and ":bd!" or ":bp | bd" .. vim.fn.bufnr()
   vim.cmd(close_cmd)
end


local user_cmd = vim.api.nvim_create_user_command
-- move line & block
map("n", "<S-Up>", ":m -2<CR>")
map("n", "<S-Down>", ":m +2<CR>")
map("v", "<S-Up>", ":'<,'>m -2<CR>gv=gv")
map("v", "<S-Down>", ":'<,'>m +2<CR>gv=gv")

-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
-- map("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http<cmd> ://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour

map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- use ESC to turn off search highlighting
map("n", "<Esc>", "<cmd> :noh <CR>")

-- move cursor within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-e>", "<End>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-a>", "<ESC>^i")

-- navigation between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

map("n", "<leader>x", function()
   close_buffer()
end)

map("n", "<C-c>", "<cmd> :%y+ <CR>") -- copy whole file content
map("n", "<S-t>", "<cmd> :enew <CR>") -- new buffer
map("n", "<C-t>b", "<cmd> :tabnew <CR>") -- new tabs
map("n", "<leader>n", "<cmd> :set nu! <CR>")
map("n", "<leader>rn", "<cmd> :set rnu! <CR>") -- relative line numbers
map("n", "<C-s>", "<cmd> :w <CR>") -- ctrl + s to save file

-- terminal mappings

-- get out of terminal mode
map("t", { "jk" }, "<C-\\><C-n>")

-- Add Packer commands because we are not loading it at startup
local packer_cmd = function(callback)
   return function()
      require "plugins"
      require("packer")[callback]()
   end
end

-- snapshot stuff
user_cmd("PackerSnapshot", function(info)
   require "plugins"
   require("packer").snapshot(info.args)
end, { nargs = "+" })

user_cmd("PackerSnapshotDelete", function(info)
   require "plugins"
   require("packer.snapshot").delete(info.args)
end, { nargs = "+" })

user_cmd("PackerSnapshotRollback", function(info)
   require "plugins"
   require("packer").rollback(info.args)
end, { nargs = "+" })

user_cmd("PackerClean", packer_cmd "clean", {})
user_cmd("PackerCompile", packer_cmd "compile", {})
user_cmd("PackerInstall", packer_cmd "install", {})
user_cmd("PackerStatus", packer_cmd "status", {})
user_cmd("PackerSync", packer_cmd "sync", {})
user_cmd("PackerUpdate", packer_cmd "update", {})

local M = {}

-- below are all plugin related mappings

M.bufferline = function()
   map("n", "<TAB>", ":bnext<CR>")
   map("n", "<S-Tab>", ":bprevious<CR>")
   -- map("n", "<TAB>", "<cmd> :BufferLineCycleNext <CR>")
   -- map("n", "<S-Tab>", "<cmd> :BufferLineCyclePrev <CR>")
end

M.lspconfig = function()
   -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
   map("n", "gD", function()
      vim.lsp.buf.declaration()
   end)

   map("n", "gd", function()
      vim.lsp.buf.definition()
   end)

   map("n", "K", function()
      vim.lsp.buf.hover()
   end)

   map("n", "gi", function()
      vim.lsp.buf.implementation()
   end)

   map("n", "<C-k>", function()
      vim.lsp.buf.signature_help()
   end)

   map("n", "<leader>D", function()
      vim.lsp.buf.type_definition()
   end)

   map("n", "<leader>ra", function()
      vim.lsp.buf.rename()
   end)

   map("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
   end)

   map("n", "gr", function()
      vim.lsp.buf.references()
   end)

   map("n", "<leader>f", function()
      vim.diagnostic.open_float()
   end)

   map("n", "[d", function()
      vim.diagnostic.goto_prev()
   end)

   map("n", "d]", function()
      vim.diagnostic.goto_next()
   end)

   map("n", "<leader>q", function()
      vim.diagnostic.setloclist()
   end)

   map("n", "<leader>fm", function()
      vim.lsp.buf.format{}
      -- vim.lsp.buf.formatting()
   end)

   map("n", "<leader>wa", function()
      vim.lsp.buf.add_workspace_folder()
   end)

   map("n", "<leader>wr", function()
      vim.lsp.buf.remove_workspace_folder()
   end)

   map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end)
end

M.nvimtree = function()
   map("n", "<C-n>", "<cmd> :NvimTreeToggle <CR>")
   map("n", "<leader>e", "<cmd> :NvimTreeFocus <CR>")
end

M.godebug = function()
  map("n", "<leader>1", ":lua require('dap.ui.widgets').hover()<CR>")
  map("n", "<leader>3", ":lua require('dap').step_out()<CR>")
  map("n", "<leader>4", ":lua require('dapui').toggle()<CR>")
  map("n", "<leader>5", ":lua require('dap').continue()<CR>")
  map("n", "<leader>6", ":lua require('dap').step_over()<CR>")
  map("n", "<leader>7", ":lua require('dap').step_into()<CR>")
  map("n", "<leader>8", ":lua require('dap.ui.variables').hover()<CR>")
  map("n", "<leader>9", ":lua require('dap').toggle_breakpoint()<CR>")
  map("n", "<Leader>dsc", ":lua require('dap').continue()<CR>")
  map("n", "<Leader>dsv", ":lua require('dap').step_over()<CR>")
  map("n", "<Leader>dsi", ":lua require('dap').step_into()<CR>")
  map("n", "<Leader>dso", ":lua require('dap').step_out()<CR>")
  map("v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")
  map("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
  map("n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")
  map("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>")
  map("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")
  map("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
  map("n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: '))<CR>")
  map("n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")
  map("n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>")
  map("n", "<Leader>di", ":lua require('dapui').toggle()<CR>")
  map("n", "<leader>td", ":lua require('dap-go').debug_test()<CR>")
end

M.telescope = function()
   map("n", "<leader>fb", "<cmd> :Telescope buffers <CR>")
   map("n", "<leader>ff", "<cmd> :Telescope find_files <CR>")
   map("n", "<leader>fa", "<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>")
   map("n", "<leader>cm", "<cmd> :Telescope git_commits <CR>")
   map("n", "<leader>gt", "<cmd> :Telescope git_status <CR>")
   map("n", "<leader>fh", "<cmd> :Telescope help_tags <CR>")
   map("n", "<leader>fw", "<cmd> :Telescope live_grep <CR>")
   map("n", "<leader>fo", "<cmd> :Telescope oldfiles <CR>")
   map("n", "<leader>th", "<cmd> :Telescope themes <CR>")
   map("n", "<leader>tk", "<cmd> :Telescope keymaps <CR>")
end

map("n", "<leader>to", "<cmd> :TagbarToggle <CR>")
map("n", "<leader>tc", "<cmd> :TagbarClose <CR>")

return M