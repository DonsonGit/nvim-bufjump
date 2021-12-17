" nvim-bufjump

if exists('g:loaded_bufjump') | finish | endif

if !has('nvim-0.5')
    echohl Error
    echomsg "bufjump.nvim is only available for Neovim versions 0.5 and above"
    echohl clear
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? BufJumpTo lua require'bufjump'.jumpTo(<q-args>)
command! BufCloseOthers lua require'bufjump'.close_others()
command! BufCloseCur lua require'bufjump'.close_current()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_bufjump = 1
