set nocompatible
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

set encoding=utf-8

set history=500

if &t_Co =~ "256"
    colorscheme zenburn
    set termguicolors
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Don't redraw while executing macros (good performance config)
set lazyredraw

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

" highlight trailing whitespace
match ErrorMsg '\s\+$'

" search down into subfolders
" tab-completion for all file-related tasks
set path+=**
" display all matching files upon tab-completion
set wildmenu
" find:QUERY<Tab> will find by partial match
" find:*QUERY<Tab> for fuzzy find
" b:<Tab> autocompletes any open buffer

" create 'tags' file
command! MakeTags !ctags -R .
" <^]> to jump to the tag under the cursor
" <g^]> lists all instances of the tag under the current path
" <^t> to jump back in the tag stack

" from |ins-completion|:
" <^x^n> completion local to file
" <^x^f> filename completion
" <^x^]> tag completion
" <^n> next suggestion
" <^p> previous suggestion

" tweaks for file browsing
let g:netrw_banner=0              "disable banner
let g:netrw_browse_split=4        "open in existing window
let g:netrw_altv=1                "open splits to the right
let g:netrw_liststyle=3           "tree view
