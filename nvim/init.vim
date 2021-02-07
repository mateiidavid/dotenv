" =======================
"  VIM OPTIONS
" ========================
syntax on
syntax enable
set tabstop=4 softtabstop=4
set smartindent
set autoindent
set shiftwidth=2
set expandtab
set smartcase
set noswapfile

" look into what these do
" ======
set nobackup
set undodir=~/.vim/undodir
set undofile
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" =======
set incsearch
set ignorecase
set smartcase
filetype plugin indent on
set relativenumber
set number
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=120 " and give me a colored column
highlight ColorColumn ctermbg=0 guibg=lightgrey
set mouse=a

" Experimental
" ============
set nohlsearch
set clipboard+=unnamedplus

" =========================
" PLUGINS
" ==========================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Must have
Plug 'neoclide/coc.nvim', {'branch': 'release'}"
"Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" =============================
" VISUAL PLUGINS
" =============================
Plug 'ayu-theme/ayu-vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'Rigellute/rigel'
Plug 'itchyny/lightline.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'sainnhe/sonokai'
" ==============================
"      MISC
" ==============================
"Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim' 
Plug 'vim-utils/vim-man'
"Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'vuciv/vim-bujo'

" =============================
" LANGUAGE SPECIFIC PLUGINS
" =============================
Plug 'sheerun/vim-polyglot'
"Plug 'tweekmonster/gofmt.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'rust-lang/rust.vim'
" Initialize plugin system
call plug#end()

" =============================
" COLOURS
" =============================
set termguicolors
set updatetime=300
colorscheme rigel
"let ayucolor="mirage"
"colorscheme ayu
" lightligne: ayu
" colorscheme nightfly
let g:nightflyUnderlineMatchParen = 1
" let g:lightline = { 'colorscheme': 'challenger_deep'}
" ex scheme: nightgly
let g:lightline={
      \ 'colorscheme':'ayu_mirage',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" removed LightlineFilename from comp function
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction
if executable('rg')
  let g:rg_derive_root='true'
endif

let mapleader = " "
let g:netrw_browse_split=2
let g:netrw_winsize=25

" ============================
" KEY MAPPINGS
" ============================
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
"nnoremap <silent><leader>c :close<CR>
nnoremap <silent><leader>c :bd<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>
" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
" =========================
" LANGUAGE SPECIFIC
" =========================
" Automatically closing braces
"inoremap {<CR> {<CR>}<Esc>ko<tab>
"inoremap [<CR> [<CR>]<Esc>ko<tab>
"inoremap (<CR> (<CR>)<Esc>ko<tab>
let g:rust_recommended_style = 0

" Always run rustfmt is applicable and always use stable.
"let g:rustfmt_autosave_if_config_present = 1
let g:rustfmt_command = "rustfmt +stable"
let g:rustfmt_autosave = 1
" Follow Rust code style rules
au Filetype rust set colorcolumn=100
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = "goimports"
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0

" ========================
" COC-VIM
" =======================
set cmdheight=2

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <silent><expr> <S-TAB>
  \ pumvisible() ? "\<C-p>" :
  \ <SID>check_back_space() ? "\<S-TAB>" :
  \ coc#refresh()
" Make <CR> confirm completion.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" Use <c-space> to trigger completion.
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Make CTRL - T work with goto-def

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction


nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
else
  call CocActionAsync('doHover')
endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
" Formatting selected code <space-f>.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>s  v<Plug>(coc-codeaction-selected)
command! -nargs=0 Format :call CocAction('format')
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" ==================================
" Other Plugin Configs
" ==================================
nmap <leader>t :NERDTree<CR>
nmap <leader>o :NERDTreeFind<CR>
let g:blamer_enabled = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Quit NERDTree when only left window open
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" ===============================
" FZF
" ===============================
nnoremap <silent><C-p> :Files<CR>
"nnoremap <silent><leader>s :Rg<CR>
let g:fzf_preview_window = 'right:30%'
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
