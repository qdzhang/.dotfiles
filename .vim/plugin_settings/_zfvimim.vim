function! s:myLocalDb()
    let db = ZFVimIM_dbInit({
                \   'name' : 'xhup',
                \ })
    call ZFVimIM_cloudRegister({
                \   'mode' : 'local',
                \   'dbId' : db['dbId'],
                \   'repoPath' : '~/dev/vim/ZFVimIM_xiaohe',
                \   'dbFile' : '/xhup.txt',
                \ })
endfunction
autocmd User ZFVimIM_event_OnDbInit call s:myLocalDb()

let g:ZFVimIM_symbolMap = {
            \   ' ' : [''],
            \   '`' : ['·'],
            \   '!' : ['！'],
            \   '$' : ['￥'],
            \   '^' : ['……'],
            \   '-' : [''],
            \   '_' : ['——'],
            \   '(' : ['（'],
            \   ')' : ['）'],
            \   '[' : ['【'],
            \   ']' : ['】'],
            \   '<' : ['《'],
            \   '>' : ['》'],
            \   ';' : ['；'],
            \   ':' : ['：'],
            \   ',' : ['，'],
            \   '.' : ['。'],
            \   '?' : ['？'],
            \   "'" : ['‘', '’'],
            \   '"' : ['“', '”'],
            \   '0' : [''],
            \   '1' : [''],
            \   '2' : [''],
            \   '3' : [''],
            \   '4' : [''],
            \   '5' : [''],
            \   '6' : [''],
            \   '7' : [''],
            \   '8' : [''],
            \   '9' : [''],
            \ }
