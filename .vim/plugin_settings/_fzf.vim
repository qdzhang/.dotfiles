"=============
" fzf settings
"=============

" Redefine Rg command
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '!{node_modules/**,.git/**}' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Fzf as a selector, not as fuzzy finder. Use ripgrep directly
" Fzf will restart ripgrep whenever the query string is updated
" NOTICE: Not fuzzy
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading -g "!{node_modules/**,.git/**}" --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Fzf default uses popup window, and there is no need to configure it
" https://github.com/junegunn/fzf/commit/c60ed1758315f0d993fbcbf04459944c87e19a48

"--------------------------------------------------------------------------
" Force to use vim8 built-in terminal, and fzf will respect vim colorscheme
" For details, see: https://github.com/junegunn/fzf/issues/1860
" The issue is not closed yet, the options will be implemented later
"--------------------------------------------------------------------------
" let g:fzf_layout = { 'window': 'bot'.float2nr(&lines * 0.4).'new' }

" Use Popup window (anchored to the bottom of the current window)
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'relative': v:true, 'yoffset': 1, 'border': 'top' } }
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']


nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>F :Files ~<cr>
nnoremap <silent> <leader>rg :Rg<cr>
nnoremap <silent> <leader>rt :RG<cr>
nnoremap <leader>rr :RgRaw 
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>m :History<cr>
nnoremap <silent> <leader>c :Commands<cr>
nnoremap <silent> <leader>l :BLines<cr>
nnoremap <silent> <leader>L :Lines<cr>
nnoremap <silent> <leader>o :BTags<cr>
