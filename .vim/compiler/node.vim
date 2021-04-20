if exists("current_compiler")
  finish
endif
let current_compiler = "node"

CompilerSet makeprg=node\ %:S
CompilerSet errorformat&

" Use following line can always open quickfix windows after dispatch finished
" https://github.com/tpope/vim-dispatch/issues/96
" CompilerSet errorformat+=%+G%.%#
