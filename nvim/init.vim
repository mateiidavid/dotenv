" ++++++++++++++++++
" | MAIN NVIM FILE |
" ++++++++++++++++++
"
let mapleader = " " " -- leader set to <space>

" ++++++++++++++++++++++++
" |    SET OPTIONS       |
" ++++++++++++++++++++++++
"
set tabstop=4 softtabstop=2
set shiftwidth=2
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

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" Ayu Nvim color scheme
Plug 'ayu-theme/ayu-vim'

" Moonlight colour scheme
Plug 'shaunsingh/moonlight.nvim'

" This is the way
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Nightfly colors 
Plug 'bluz71/vim-nightfly-guicolors'

" Vim telescope & treesitterc
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'hoob3rt/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
" ayu
"let ayucolor="mirage"
"colorscheme ayu
" moonlight
 "colorscheme moonlight
" nightfly
"colorscheme nightfly
" Tokyo night
let g:tokyonight_style = "night"
colorscheme tokyonight
" ++++++++++++++
" |  KEY MAPS  |
" ++++++++++++++
"
" Move between windows with <space> + h,k,j,l
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Buffers
nnoremap <leader>c :bd <CR>

" NOTE: use ':verbose imap <tab>' to make sure
" it is not mapped to something else.
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> [g    <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]g    <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>

" Vim telescope
"
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ++++++++++++
" |   LSP    |
" ++++++++++++
"
"

lua << EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    capabilities=capabilities,
    on_attach=on_attach
})

-- Enable gopls
nvim_lsp.gopls.setup{
    cmd = {"gopls", "--remote=auto"},
    capabilities=capabilities,
    on_attach=on_attach,
    init_options = {
        usePlaceholders=true,
        completeUnimported=true,
    }
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)


EOF

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

"
" +++++++++
" |  LUA  |
" +++++++++
lua << EOF
-- set-up lua line
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = {'|', '|'},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch',{'filename', file_status=true, path = 1}},
    lualine_c = {'diagnostics'},
    lualine_x = {
        'encoding', 
        'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}


EOF
