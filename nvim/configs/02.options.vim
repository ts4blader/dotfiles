set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set encoding=UTF-8
set nofoldenable
set mouse=a
set exrc
set nu
set formatoptions-=t
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=2
set noshowmode
set completeopt=menu,menuone,noselect
set signcolumn=yes
set updatetime=50
set clipboard=unnamed
set background=dark
set nojoinspaces " don't autoinsert two spaces after '.', '?', '!' for join command
set showcmd " extra info at end of command line
set wildignore+=*/node_modules/**
filetype plugin indent on

set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" attempt to speed-up vim
set ttyfast
set lazyredraw
" }}}

" Syntax
syntax enable
" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

"Map leader key to space
let mapleader = "\<Space>"

nnoremap <S-w> b
vnoremap <S-w> b
nnoremap <SPACE> <Nop>
imap <C-o> <esc>o
nnoremap <TAB> za

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
