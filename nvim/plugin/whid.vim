if exists('g:loaded_wid') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo "save user coptions
set cpo&vim " reset them to defaults
hi def link WhidHeader Number
hi def link WhidSubHeader Identifier
      
" command to run plugin
command! Whid lua require'whid'.whid()

let &cpo = s:save_cpo " and restore after unlet s:save_cpo
let g:loaded_whid = 1

" custom coptions -- sequence of single character flags

