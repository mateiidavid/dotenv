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
set diffopt+=vertical
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
Plug 'folke/tokyonight.nvim'

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'davidpdrsn/vim-notable'


" =============================
" LANGUAGE SPECIFIC PLUGINS
" =============================
" Plug 'sheerun/vim-polyglot'
"Plug 'tweekmonster/gofmt.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Initialize plugin system
call plug#end()

" =============================
" COLOURS
" =============================
set termguicolors
set updatetime=300
"colorscheme rigel
colorscheme tokyonight
"let ayucolor="mirage"
"colorscheme ayu
" lightligne: ayu
" colorscheme nightfly
let g:nightflyUnderlineMatchParen = 1
" let g:lightline = { 'colorscheme': 'challenger_deep'}
" ex scheme: nightgly
let g:lightline={
      \ 'colorscheme':'tokyonight',
      \ 'active': {
      \   'right': [['lineinfo']],
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'relativepath', 'gitbranch' ],
      \             [ 'cocstatus', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename'
      \ },
      \ }

" removed LightlineFilename from comp function
function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
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
noremap <leader>sb :call notable#open_notes_file()<cr>
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
vnoremap <leader>y "+y
nnoremap  <leader>y  "+y
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
au Filetype rust set colorcolumn=120
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = "goimports"
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0
let g:notable_notes_folder = "~/notes/"

let g:go_doc_keywordprg_enabled = 0

" ========================
" COC-VIM
" =======================
set cmdheight=2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Formatting selected code <space-f>.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>s  v<Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

command! -nargs=0 Format :call CocAction('format')
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)
augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.5.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

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
nnoremap <silent><leader>p p:Rg<CR>
let g:fzf_preview_window = 'right:30%'
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

lua require'nvim-treesitter.configs'.setup { highlight = {enable = true} }
