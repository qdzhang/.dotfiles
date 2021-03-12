" Put the following lines in your configuration file to map <F12> to use Multiterm
nmap <F12> <Plug>(Multiterm)
" In terminal mode `count` is impossible to press, but you can still use <F12>
" to close the current floating terminal window without specifying its tag
tmap <F12> <Plug>(Multiterm)
" If you want to toggle in insert mode and visual mode
imap <F12> <Plug>(Multiterm)
xmap <F12> <Plug>(Multiterm)
