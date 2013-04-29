" vagrant.vim - basic vim/vagrant integration
" Maintainer: Mark Cornick <https://github.com/markcornick>

if exists("g:loaded_vagrant") || v:version < 700 || &cp || !executable('vagrant')
  finish
endif
let g:loaded_vagrant = 1

function! s:commands(A, L, P)
  return "box\ndestroy\nhalt\ninit\npackage\nplugin\nprovision\nreload\nresume\nssh\nssh-config\nstatus\nsuspend\nup"
endfunction

augroup vagrant
  autocmd!
  autocmd VimEnter *
        \ command! -nargs=+ -complete=custom,s:commands Vagrant execute '!vagrant '.<q-args>
augroup END

" vim:set et sw=2:
