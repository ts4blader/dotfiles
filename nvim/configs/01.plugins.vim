call plug#begin('~/.config/nvim/bundle')

" Language Server Protocol
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File Management
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'kyazdani42/nvim-tree.lua'

" Custom Motions
Plug 'easymotion/vim-easymotion'

" Status Line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Utils
Plug 'matze/vim-move'
Plug 'jdhao/better-escape.vim'
Plug 'akinsho/toggleterm.nvim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'

" tpope plugins
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-unimpaired' " helpful shorthand like [b ]b
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'

"Visual Enchant
Plug 'Mofiqul/dracula.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'norcalli/nvim-colorizer.lua', { 'branch': 'color-editor' }
Plug 'rcarriga/nvim-notify'
Plug 'folke/which-key.nvim'
Plug 'APZelos/blamer.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'stevearc/dressing.nvim'
Plug 'romgrk/barbar.nvim'


" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'MaxMEllon/vim-jsx-pretty' " fix indentation in jsx until treesitter can
Plug 'jxnblk/vim-mdx-js'
Plug 'HerringtonDarkholme/yats.vim'

" Emmet and tag playing
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

call plug#end()

