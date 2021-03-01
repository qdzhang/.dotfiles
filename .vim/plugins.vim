"------------------
" Appearance
"------------------
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'

" Plug 'doums/barow'
" Plug 'zefei/vim-wintabs'
" Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'glepnir/dashboard-nvim'
" Plug 'rbong/vim-crystalline'

"------------------
" File types
"------------------
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
" Plug 'bfrg/vim-cpp-modern'
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'cespare/vim-toml'

"------------------
" Edit and move
"------------------
" Plug 'jiangmiao/auto-pairs'
Plug 'tmsvg/pear-tree'

Plug 'tpope/vim-commentary'
Plug 'haya14busa/is.vim'
Plug 'simnalamburt/vim-mundo'

"------------------
" Utils 
"------------------
Plug 'wfxr/minimap.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'Shougo/echodoc.vim'
" Plug 'eraserhd/parinfer-rust', {'do':
"         \  'cargo build --release'}
Plug 'justinmk/vim-sneak'

Plug 'jpalardy/vim-slime'
" Plug 'kassio/neoterm'

Plug 'HiPhish/info.vim'
" Plug 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5' }

Plug 'dstein64/vim-startuptime'
Plug 'dstein64/vim-win'

"------------------
" Git
"------------------
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'sodapopcan/vim-twiggy'

"------------------
" Lsp and complete
"------------------
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'mattn/vim-lsp-settings'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

"------------------
" Search and grep
"------------------
" Plug 'vifm/vifm.vim'
Plug 'liuchengxu/vista.vim'
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
"Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yegappan/mru'
" Plug 'tracyone/fzf-funky',{'on': 'FzfFunky'}

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/reword.vim'
