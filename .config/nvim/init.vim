call plug#begin('~/.local/share/nvim/plugged')
"Plug 'rakr/vim-one'
Plug 'ajmwagar/vim-deus'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'Yggdroot/indentLine'
"Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'tpope/vim-commentary'
Plug 'Shougo/echodoc.vim'
Plug 'jpalardy/vim-slime'
Plug 'haya14busa/is.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vifm/vifm.vim'
Plug 'liuchengxu/vista.vim'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'
if has('win32')
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
        \ }
else
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
endif
call plug#end()

" lightline and bufferline setting
let g:lightline = {
    \ 'colorscheme': 'darcula',
    \ }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number  = 1
"let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'

" Indent guides settings
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1
" let g:pandoc#modules#disabled = ["folding"]

" pandoc_syntax settings
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=pandoc
augroup END

" ----------------------------
"  vimtex settings
"  ---------------------------
"let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:tex_flavor = 'latex'

" UltiSnips and setting
let g:UltiSnipsExpandTrigger="<f5>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

"---------------------------------
"echodoc settings
"---------------------------------
let g:echodoc#enable_at_startup = 1

" -------------
" ncm2 settings
" -------------

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" ------------
" lsp settings
" ------------
set completeopt-=preview
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ 'go': ['~/go/bin/gopls']
    \ }

" Run gofmt on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

nmap <silent> <leader>l <Plug>(lcn-menu)
nmap <silent> <F2> <Plug>(lcn-rename)
nmap <silent> K <Plug>(lcn-hover)
nmap <silent> <F12> <Plug>(lcn-definition)
nmap <silent> <S-F12> <Plug>(lcn-references)

" vim-slime setting
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1

" -------------------
"  Vista.vim settings
" -------------------
nnoremap <leader>v :Vista 
nnoremap <leader>vq :Vista!<cr>
nnoremap <leader>vf :Vista finder fzf:

"------------------
" vim-clap settings
"------------------
let g:clap_theme = 'material_design_dark'
let g:clap_provider_dotfiles = {
      \ 'source': ['~/.vim/vimrc', '~/.config/nvim/init.vim', '~/.bashrc', '~/.tmux.conf'],
      \ 'sink': 'e',
      \ }

nnoremap <leader>c :Clap 

" ------------------------
"  NERD Commenter settings
" ------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" --------------
"  vifm settings
" --------------
let g:vifm_embed_term = 1
let g:vifm_embed_split = 1
noremap <leader>t :FloatermNew vifm<cr>

" ------------
" fzf settings
" ------------
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>rg :Rg<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" Basic settings
syntax on
"set background=dark
"let g:one_allow_italics = 1
colorscheme dracula
set noshowmode
set ignorecase
set showcmd
set hlsearch
set mouse=a
"set t_Co=256


"set termguicolors
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

if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif

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

if has('gui_running')
set guioptions-=e  "tab bar
"set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
autocmd GUIEnter * set visualbell t_vb=
endif

set laststatus=2
set showtabline=2
set signcolumn=yes

set guifont=Monospace\ 16
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

let g:python3_host_prog='/home/qdzhang/miniconda3/envs/neovim/bin/python'
