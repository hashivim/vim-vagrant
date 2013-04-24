" vagrant.vim - basic vim/vagrant integration
" Maintainer: Mark Cornick <https://github.com/markcornick>

if exists("g:loaded_vagrant") || v:version < 700 || &cp
  finish
endif
let g:loaded_vagrant = 1

augroup vagrant
  autocmd!
  autocmd VimEnter *
        \ command! -buffer -nargs=+ -complete=file Vagrant execute '!vagrant '.<q-args>
augroup END

" vim:set et sw=2:
