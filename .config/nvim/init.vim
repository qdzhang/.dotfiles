runtime! basic.vim

call plug#begin('~/.vim/plugged')
runtime! plugins.vim
call plug#end()

runtime! plugin_settings/*.vim
runtime! colorscheme.vim

lua <<EOF
require'nvim-treesitter.configs'.setup {
-- Modules and its options go here
highlight = { enable = true },
incremental_selection = { enable = true },
textobjects = { enable = true },
}
EOF
