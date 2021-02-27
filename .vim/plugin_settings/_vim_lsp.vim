" ----------------
" vim-lsp settings
" ----------------
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" let g:lsp_signs_enabled = 1         " enable signs
" " let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
" let g:lsp_diagnostics_float_cursor = 1

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/.vim/vim-lsp.log')

" " for asyncomplete.vim log
" let g:asyncomplete_log_file = expand('~/.vim/asyncomplete.log')

" if has('python3')
"     call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
"         \ 'name': 'ultisnips',
"         \ 'allowlist': ['*'],
"         \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
"         \ }))
" endif

" " if executable('clangd')
" "     au User lsp_setup call lsp#register_server({
" "         \ 'name': 'clangd',
" "         \ 'cmd': {server_info->['clangd', '-background-index']},
" "         \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
" "         \ })
" " endif

" if executable('ccls')
"    au User lsp_setup call lsp#register_server({
"       \ 'name': 'ccls',
"       \ 'cmd': {server_info->['ccls']},
"       \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"       \ 'initialization_options': {
"       \   'highlight': { 'lsRanges' : v:true },
"       \ },
"       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"       \ })
" endif

" if executable('pyls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
"         \ })
" endif

" if executable('gopls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'gopls',
"         \ 'cmd': {server_info->['gopls']},
"         \ 'whitelist': ['go'],
"         \ })
"     autocmd BufWritePre *.go LspDocumentFormatSync
" endif

" if executable('css-languageserver')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'css-languageserver',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
"         \ 'whitelist': ['css', 'less', 'sass'],
"         \ })
" endif

" function! s:on_lsp_buffer_enabled() abort
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"     nmap <buffer> <f2> <plug>(lsp-rename)
"     nmap <buffer> ld <plug>(lsp-document-diagnostics)
    
"     " refer to doc to add more commands
" endfunction

" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END
