" ++++++++++++++++++
" | MAIN NVIM FILE |
" ++++++++++++++++++
"
let mapleader = " " " -- leader set to <space>

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
set termguicolors " -- won't get rid of this it seems, required by ayu

" ++++++++++++++++
" |   LSP SETS   |
" ++++++++++++++++
"
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
set shortmess+=c  " -- avoid showing extra messages when using completion
set cmdheight=2 " -- give more space for displaying messages
set updatetime=300 " -- longer updates lead to oticeable delays
set signcolumn=number " -- merge column + sign

" Remapping
" 
" mode <> lhs (what-to-execute-to-execute) rhs (thing-you-want-to-execute)
" n (normal mode) nore (no-recursive-execution, can execute other maps for you) map (maps)
" nnoremap <leader>ps

" autocommands, stuff that gets called automatically. e.g listen to keyboard event and each time do something.

" +++++++++++++++++
" |    PLUG       |
" +++++++++++++++++
"
call plug#begin('~/.vim/plugged')

" CoC Nvim release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ayu Nvim color scheme
Plug 'ayu-theme/ayu-vim'

call plug#end()
let ayucolor="mirage"
colorscheme ayu

" ++++++++++++
" |   LSP    |
" ++++++++++++
"
" Use tab to trigger completion.
" NOTE: use ':verbose imap <tab>' to make sure
" it is not mapped to something else.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"
" ++++++++++++++
" |  KEY MAPS  |
" ++++++++++++++
"
" Move between windows with <space> + h,k,j,l
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" Trigger completion using <c-space>
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>s  v<Plug>(coc-codeaction-selected)


