" Appearance {{{
"------------------
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'morhetz/gruvbox'
" Plug 'lifepillar/vim-gruvbox8'

" Plug 'doums/barow'
" Plug 'zefei/vim-wintabs'
" Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'glepnir/dashboard-nvim'
" Plug 'rbong/vim-crystalline'
Plug 'https://gitlab.com/maister/skyline.vim'

" }}}

" File types {{{
"------------------
" Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
" Plug 'bfrg/vim-cpp-modern'
Plug 'dhruvasagar/vim-table-mode', {'for': ['markdown', 'pandoc']}
Plug 'lervag/vimtex', { 'for': 'tex' }
" Plug 'sheerun/vim-polyglot'
Plug 'SidOfc/mkdx', { 'for': 'markdown' }
Plug 'wlangstroth/vim-racket'
" Plug 'kovisoft/paredit'
Plug 'eraserhd/parinfer-rust', {'do':
        \  'cargo build --release'}
" }}}

" Edit and move {{{
"------------------
" Use Coc-pairs as auto-pairs plugin
" Plug 'jiangmiao/auto-pairs'
" Plug 'tmsvg/pear-tree'

Plug 'tpope/vim-commentary'
" Plug 'haya14busa/is.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'simnalamburt/vim-mundo'

Plug 'andymass/vim-matchup'

Plug 'stefandtw/quickfix-reflector.vim'
Plug 'machakann/vim-sandwich'
Plug 'chrisbra/NrrwRgn'

" }}}

" Compile and run {{{
Plug 'tpope/vim-dispatch'
" }}}

" Utils {{{
"------------------
Plug 'wfxr/minimap.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'Shougo/echodoc.vim'
" Plug 'eraserhd/parinfer-rust', {'do':
"         \  'cargo build --release'}
Plug 'justinmk/vim-sneak'
" Plug 'junegunn/vim-peekaboo'

" Plug 'mzlogin/vim-markdown-toc', {'for': ['markdown', 'pandoc']}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug', 'pandoc']}

" Plug 'jpalardy/vim-slime'
" Plug 'kassio/neoterm'
Plug 'axvr/zepl.vim'

" Plug 'HiPhish/info.vim'
" Plug 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5' }

" Plug 'dstein64/vim-startuptime'
Plug 'tweekmonster/startuptime.vim'
Plug 'dstein64/vim-win'
" Plug 'rlue/vim-barbaric'

" Plug 'ZSaberLv0/ZFVimIM'
" Plug 'ZSaberLv0/ZFVimJob'
" Plug 'qdzhang/ZFVimIM_xiaohe'

if exists(':terminal')
    if has('nvim-0.4.0') || has('patch-8.2.191')
        Plug 'chengzeyi/multiterm.vim'
    endif
endif

Plug 'vim-utils/vim-man'

" Plug 'editorconfig/editorconfig-vim'

" }}}

" Git {{{
"------------------
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'sodapopcan/vim-twiggy'

" }}}

" Lsp and complete {{{
"---------------------
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'mattn/vim-lsp-settings'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

" }}}

" Search and grep {{{
"------------------
" Plug 'vifm/vifm.vim'
Plug 'liuchengxu/vista.vim'
" Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'yegappan/mru'
" Plug 'tracyone/fzf-funky',{'on': 'FzfFunky'}

Plug 'markonm/traces.vim'

" }}}

" File explorer {{{
"-------------------
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
" Plug 'lambdalisue/nerdfont.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Plug 'lambdalisue/reword.vim'

" }}}
