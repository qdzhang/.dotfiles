" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" let g:fern#renderer = "nerdfont"
let g:fern#default_hidden = 1

noremap <silent> <Leader>t :Fern . -drawer -reveal=% -toggle <CR><C-w>=
