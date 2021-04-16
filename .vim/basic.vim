" Basic settings

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

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set rnu
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
set nofixeol

set wildmenu wildmode=full 
set wildchar=<Tab> wildcharm=<C-Z>

"------------------------------------
" key maps
" -----------------------------------
noremap <leader>/ :let @/ = ""<CR>
