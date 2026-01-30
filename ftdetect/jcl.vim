" ftdetect/jcl.vim
augroup filetypedetect_jcl
  autocmd!
  autocmd BufRead,BufNewFile *.jcl,*.JCL setf jcl
augroup END
