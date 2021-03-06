" ------------
" fzf settings
" ------------
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = ['up:80%:hidden', 'ctrl-/']

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>rg :Rg<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>m :MRU<cr>
nnoremap <silent> <leader>c :Commands<cr>
nnoremap <silent> <leader>l :BLines<cr>
nnoremap <silent> <leader>L :Lines<cr>
nnoremap <silent> <leader>o :BTags<cr>
