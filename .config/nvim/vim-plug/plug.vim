" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" ========================================
" == Plugins =============================
" ========================================

call plug#begin('~/.config/nvim/plugged')

" use auto-pais
" Plug 'Raimondi/delimitMate' 
" Plug 'Shougo/vimproc.vim'
Plug 'SirVer/ultisnips'
Plug 'andymass/vim-matchup'
Plug 'cespare/vim-toml'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/Vim-g-dot'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'davidpdrsn/vim-notable'
Plug 'davidpdrsn/vim-spectacular'
Plug 'ekalinin/Dockerfile.vim'
Plug 'google/vim-jsonnet'
Plug 'itchyny/lightline.vim'
Plug 'jgdavey/tslime.vim'
Plug 'kana/vim-textobj-entire' " ae
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'maximbaz/lightline-ale'
Plug 'mg979/vim-visual-multi'
Plug 'nanotech/jellybeans.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pbrisbin/vim-mkdir'
Plug 'plasticboy/vim-markdown'
" Plug 'rking/ag.vim'
Plug 'rust-lang/rust.vim'
" Plug 'tek/vim-textobj-ruby' " ir, if, ic, in
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'uarun/vim-protobuf'
" Plug 'vim-ruby/vim-ruby'
" Plug 'tiagovla/tokyodark.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/NERDTree'
Plug 'jiangmiao/auto-pairs'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

call plug#end()

" =========================================
" settings for SirVer/ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" =========================================