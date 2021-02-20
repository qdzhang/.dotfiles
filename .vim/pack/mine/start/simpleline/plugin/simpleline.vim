" let g:currentmode={
"        \ 'n'  : 'NORMAL ',
"        \ 'v'  : 'VISUAL ',
"        \ 'V'  : 'V·Line ',
"        \ '' : 'V·Block ',
"        \ 'i'  : 'INSERT ',
"        \ 'R'  : 'R ',
"        \ 'Rv' : 'V·Replace ',
"        \ 'c'  : 'Command ',
"        \}

" function! s:statusline_expr()
"   let sta = "%{toupper(g:currentmode[mode()])}"
"   let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
"   let ro  = "%{&readonly ? '[RO] ' : ''}"
"   let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
"   let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
"   let sep = ' %= '
"   let encode = '%{''.(&fenc!=''?&fenc:&enc).''}'
"   let pos = ' %-12(%l : %c%V%) '
"   let pct = ' %P'

"   return sta.'[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
" endfunction
" let &statusline = s:statusline_expr()

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=#98971a guifg=#504945
  elseif a:mode == 'r'
    hi statusline guibg=#b16286 guifg=#504945
  elseif
    hi statusline guibg=#cc241d guifg=#504945
  endif
endfunction

function! VisualStatuslineColor()
    set updatetime=0
    hi statusline guibg=#fbf1c7 guifg=#d65d0e
endfunction
function! LeaveVisualStatuslineColor()
    set updatetime=250
    hi statusline guibg=#fbf1c7 guifg=#458588
endfunction
vnoremap <expr> <SID>VisualStatuslineColor VisualStatuslineColor()
nnoremap <script> v v<SID>VisualStatuslineColor
nnoremap <script> V V<SID>VisualStatuslineColor
nnoremap <script> <C-v> <C-v><SID>VisualStatuslineColor

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=#fbf1c7 guifg=#458588
au CursorHold * call LeaveVisualStatuslineColor()

hi statusline guibg=#fbf1c7 guifg=#458588

" Formats the statusline
set statusline=
set statusline+=[%n]                    " Buffer number
set statusline+=%f                           " file name
set statusline+=\ %y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=\ %{ReadOnly()}
" set statusline+=%r      "read only flag
set statusline+=%{fugitive#statusline()}

set statusline+=\ %=                        " align left
set statusline+=[%{strlen(&fenc)?&fenc:'none'},  "file encoding
set statusline+=%{&ff}] "file format
set statusline+=\ %-4(%c%)                    " current column
set statusline+=\ %l/%L[%p%%]           " line X of Y [percent of file]
" set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor
