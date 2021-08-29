" ++++++++++++++++++
" | MAIN NVIM FILE |
" ++++++++++++++++++
"
let mapleader = " " " -- leader set to <space>

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
call plug#begin(stdpath('data').'/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, e.g inlay hints.
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

call plug#end()


" ++++++++++++++++++++
" |     LSP          |
" ++++++++++++++++++++
"
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer

lua << EOF
local nvim_lsp = require'lspconfig'

local on_attach = function(client)
    require'completion'.on_attach(client)
end

nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})
EOF
