" Basic settings
syntax on
set background=dark
"let g:one_allow_italics = 1
colorscheme gruvbox
set noshowmode
set ignorecase
set showcmd
set hlsearch
set mouse=a
set shortmess=I  "disable intro message
"set t_Co=256


" set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

filetype on
set autoindent
filetype indent on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set number
set rnu

if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif

set ttimeout        " time out for key codes
set ttimeoutlen=10 " wait up to 10ms after Esc for special key

if exists('$TMUX')
    let &t_SI .= "\e[6 q"
    let &t_SR .= "\e[3 q"
	let &t_EI .= "\e[2 q"
endif

set cursorline
set cursorcolumn
"hi Visual gui=reverse guifg=Black guibg=Grey
"hnighlight CursorLine ctermbg=242
set ruler
set backspace=2
set fileformat=unix

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
"   let pos = ' %-12(%l : %c%V%) '
"   let pct = ' %P'

"   return sta.'[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
" endfunction
" let &statusline = s:statusline_expr()

if has('gui_running')
set guioptions-=e  "tab bar
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
autocmd GUIEnter * set visualbell t_vb=
endif

set laststatus=2
set showtabline=2
set signcolumn=yes

set guifont=Monospace\ 14
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1
set langmenu=en_US
let $LANG = 'en_US.UTF-8'
language messages en_US.utf-8

set clipboard+=unnamed
noremap <leader>p "*p
noremap <leader>y "*y
noremap <leader>P "+p
noremap <leader>Y "+y

set ignorecase
set smartcase
set noerrorbells
set visualbell
set visualbell t_vb=
set autoread

set wildmenu wildmode=full 
set wildchar=<Tab> wildcharm=<C-Z>

"------------------------------------
" key maps
" -----------------------------------
noremap <leader>/ :let @/ = ""<CR>
