" ++++++++++++++++++++++++
" |    SET OPTIONS       |
" ++++++++++++++++++++++++
"
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set nohlsearch
set hidden
set noerrorbells
" nvim history, not important to know just take it as it is I guess
set noswapfile
set nobackup
set undodir=~/.nvim/undodir
set undofile
set mouse=a
set incsearch
set scrolloff=8
"set termguicolors
set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey
set formatoptions=tc " -- wrap text and comments using textwidth
set formatoptions+=r " -- continue comments when pressing ENTER in I mode
set formatoptions+=b " -- auto-wrap in insert mode, and do not wrap old long lines
syntax enable " -- enable syntax
filetype plugin indent on " -- file id, plugin and identing
