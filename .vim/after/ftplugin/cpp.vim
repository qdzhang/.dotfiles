" Use clang-format to format C++ files
" Key mappings:
" gq{motion}:  format using formatprg
" ={motion}: format current line to movement position
" For example: to format whole buffer, use gg=G
setlocal formatprg=clang-format\ --style='LLVM'\ 2>/dev/null
setlocal equalprg=clang-format\ --style='LLVM'\ 2>/dev/null
