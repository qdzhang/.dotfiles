Plug 'lifepillar/vim-gruvbox8'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"------------------
" Utils 
"------------------
Plug 'wfxr/minimap.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'justinmk/vim-sneak'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

"------------------
" Search and grep
"------------------
Plug 'liuchengxu/vista.vim'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yegappan/mru'

"------------------
" Neovim only
"------------------
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'hoob3rt/lualine.nvim'
" Plug 'ojroques/nvim-bufbar'
