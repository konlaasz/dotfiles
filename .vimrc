set nocompatible
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

set encoding=utf-8

colorscheme zenburn
set termguicolors

set ruler                      " show line and column information
"set number                     " show line numbers
syntax on
filetype plugin on
filetype indent on

"set incsearch                  " incremental search
set hlsearch                   " highlight search results
set showmatch                  " show matching brackets

set expandtab
set tabstop=4
set shiftwidth=4

set autoindent
set smartindent

" trailing whitespace
match ErrorMsg '\s\+$'
