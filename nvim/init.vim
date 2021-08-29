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

call plug#end()
