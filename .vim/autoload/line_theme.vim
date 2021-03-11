" ======================================================================================================
" https://github.com/rbong/vim-crystalline/wiki/Porting-Airline-Themes
"
" A function to port airline theme to crystalline theme
" Written by rbong (https://raw.githubusercontent.com/wiki/rbong/vim-crystalline/scripts/airline.vimrc)
"
" How to use:
" 1. Install airline and airline theme plugin
" 2. Set airline theme you want to port
" 3. Use :call line_theme#StealAirlineTheme() to 'steal' current airline theme
"    to clipboard
" 4. Paste the highlight groups to crystalline theme file
" ======================================================================================================

function! s:Attr(hi, attr)
  return matchstr(a:hi, '\<' . a:attr . '=\zs[0-9#a-zA-Z,]*')
endfunction

function! s:Group(mode, group, new_group)
  call airline#highlighter#highlight([a:mode], bufnr('%'))
  redir @a | exec 'hi airline_' . a:group | redir END
  let l:hi = @a

  let l:extra = join([s:Attr(l:hi, 'term'), s:Attr(l:hi, 'cterm'), s:Attr(l:hi, 'gui')], ' ')
  if l:extra !~# ' \+'
    let l:extra = ", '" . l:extra . "'"
  else
    let l:extra = ''
  endif

  let l:ret = "        \\ '" . a:new_group . "':"
  let l:ret .= ' [[' . s:Attr(l:hi, 'ctermfg') . ', ' . s:Attr(l:hi, 'ctermbg') . ']'
  let l:ret .= ", ['" . s:Attr(l:hi, 'guifg') . "', '" . s:Attr(l:hi, 'guibg') . "']"
  let l:ret .= l:extra . "],\n"

  return l:ret
endfunction

function! line_theme#StealAirlineTheme()
  let l:c = ''

  let l:c .= "  call crystalline#generate_theme({\n"
  let l:c .= s:Group('normal', 'a', 'NormalMode')
  let l:c .= s:Group('insert', 'a', 'InsertMode')
  let l:c .= s:Group('visual', 'a', 'VisualMode')
  let l:c .= s:Group('replace', 'a', 'ReplaceMode')
  let l:c .= s:Group('normal', 'b', '')
  let l:c .= s:Group('normal', 'a_inactive', 'Inactive')
  let l:c .= s:Group('normal', 'c', 'Fill')
  let l:c .= s:Group('normal', 'tab', 'Tab')
  let l:c .= s:Group('normal', 'tabtype', 'TabType')
  let l:c .= s:Group('normal', 'tabsel', 'TabSel')
  let l:c .= s:Group('normal', 'tabfill', 'TabFill')
  let l:c .= '        \ })'

  let @+ = l:c
endfunction
