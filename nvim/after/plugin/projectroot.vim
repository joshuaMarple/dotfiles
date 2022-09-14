if exists('g:loaded_projectroot')
  augroup UpdateProjectRoot
    autocmd!
    autocmd BufEnter * :let b:projectroot = projectroot#guess()
  augroup END
endif

