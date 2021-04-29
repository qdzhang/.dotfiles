" This file contains basic Vim settings and mappings

" Basic settings {{{
" ==================

set guioptions=M
syntax on
set noshowmode
set ignorecase
set showcmd
set mouse=a
set shortmess=I  "disable intro message

filetype on
set autoindent
filetype indent on
filetype plugin indent on

augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif

augroup END

" How to set tabstop
" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

set number
set relativenumber
set colorcolumn=80

set list listchars=tab:→\ ,extends:›,precedes:‹,nbsp:·,trail:·

if has('reltime')
    set incsearch
endif
set hlsearch

if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif

set ttimeout        " time out for key codes
set ttimeoutlen=10 " wait up to 10ms after Esc for special key

set updatetime=250

if exists('$TMUX')
    let &t_SI .= "\e[6 q"
    let &t_SR .= "\e[3 q"
    let &t_EI .= "\e[2 q"
endif

set cursorline
set cursorcolumn
set ruler
set backspace=2

set laststatus=2
set showtabline=2
set signcolumn=yes

" Use Vim as manpager. There are some errors when set fileformat and fileencoding for
" unmodifiable files, such as man pages.
" https://www.reddit.com/r/vim/comments/morzue/vim_has_a_native_plugin_that_allows_you_to_turn/
if &modifiable
    set fileformat=unix
    set fileencoding=utf-8
endif

set fileencodings=ucs-bom,utf-8,chinese,latin1
set langmenu=en_US
let $LANG = 'en_US.UTF-8'
language messages en_US.utf-8

set ignorecase
set smartcase
set noerrorbells
set visualbell
set visualbell t_vb=
set autoread
set nofixeol

set wildmenu wildmode=full 
set wildchar=<Tab> wildcharm=<C-Z>

set foldmethod=marker

if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" }}}

" Gvim settings {{{
" =================
if has('gui_running')
    set guioptions-=e  "tab bar
    set guioptions-=m  "menu bar
    set guioptions-=T  "toolbar
    set guioptions-=r  "scrollbar
    set guifont=monospace\ 14
    autocmd GUIEnter * set visualbell t_vb=
endif

" }}}

" Built-in terminal settings {{{
"===============================

" Use Ctrl+b to enter terminal normal mode
" Use i or a to enter terminal mode
tnoremap <c-b> <c-\><c-n>

" Add the ability to scroll with mouse in terminal mode
" https://github.com/vim/vim/issues/2490
function! ExitNormalMode()
    unmap <buffer> <silent> <RightMouse>
    call feedkeys("a")
endfunction

function! EnterNormalMode()
    if &buftype == 'terminal' && mode('') == 't'
        call feedkeys("\<c-w>N")
        call feedkeys("\<c-y>")
        map <buffer> <silent> <RightMouse> :call ExitNormalMode()<CR>
    endif
endfunction

tmap <silent> <ScrollWheelUp> <c-w>:call EnterNormalMode()<CR>

" }}}

" Key mappings {{{
" ================

let maplocalleader = ','

" Quick edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ee :vsplit ~/.vim/basic.vim<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Clear search pattern register
" See details in :help quote_/
noremap <leader>/ :let @/ = ""<CR>

set clipboard+=unnamed
noremap <leader>p "*p
noremap <leader>y "*y
noremap <leader>P "+p
noremap <leader>Y "+y

" Change to Directory of Current file {{{2
command CDC cd %:p:h

" Toggle quickfix
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" }}}

nnoremap <F2> :call ToggleQuickFix()<cr>

" Convert the current word to uppercase in insert mode
" This map avoid holding shift when enter uppercase word
inoremap <c-u> <esc>viwUea
" Same map but in normal mode
nnoremap <c-u> viwUe

" }}}
