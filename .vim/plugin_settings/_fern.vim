" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

noremap <silent> <Leader>t :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
