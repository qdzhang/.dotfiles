setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

" dispatch.vim settings
" Set 'node' as default dispatch for javascript filetype
let b:dispatch = "node %"

" Set node as default compiler
compiler node

" zepl.vim settings
" Set 'node' as default repl for javascript filetype
let b:repl_config = { 'cmd': 'node' }
