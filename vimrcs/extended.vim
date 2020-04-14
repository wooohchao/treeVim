
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" 粘贴yank寄存器的值
map! <C-r> <C-r>0
