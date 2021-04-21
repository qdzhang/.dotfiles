command! -nargs=* -bang -range -complete=filetype NN
          \ :<line1>,<line2> call nrrwrgn#NrrwRgn('',<q-bang>)
          \ | set filetype=<args>
