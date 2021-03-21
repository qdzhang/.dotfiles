runtime! basic.vim

call plug#begin('~/.vim/plugged')
runtime! plugins.vim
call plug#end()

runtime! plugin_settings/*.vim
runtime! colorscheme.vim

lua require('stl')
lua require('treesitter')
