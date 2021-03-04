function! StatusLine(current, width)
let l:s = ''

if a:current
  let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
else
  let l:s .= '%#CrystallineInactive#'
endif
let l:s .= ' %f%h%w%m%r '
if a:current
  let l:s .= '%{fugitive#head()}'
endif

let l:s .= '%='
if a:current
  let l:s .= ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
  let l:s .= ' %{&ft} ' 
  let l:s .= crystalline#left_mode_sep('')
endif
if a:width > 40
  let l:s .= ' %{&fenc!=#""?&fenc:&enc} | %{&ff} | %P %4l:%-3v '
else
  let l:s .= ' '
endif

return l:s
endfunction

function! TabLine()
    return crystalline#bufferline(0, 0, 1)
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_separators = ['', '']
let g:crystalline_tab_separator = '|' 
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'gruvbox'
let g:crystalline_mode_labels = {
            \ 'n': ' N ',
            \ 'i': ' I ',
            \ 'v': ' V ',
            \ 'R': ' R '
            \}

set showtabline=2
set guioptions-=e
set laststatus=2
