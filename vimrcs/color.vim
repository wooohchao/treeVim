" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Colorscheme
set background=dark
colorscheme peaksea


" 开启高亮光标行
set cursorline
hi CursorLine   cterm=NONE ctermbg=237 ctermfg=NONE guibg=darkred guifg=white
highlight EndOfBuffer ctermfg=bg
highlight clear LineNr
highlight LineNr cterm=NONE ctermfg=red ctermbg=NONE guibg=darkred guifg=white
hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

" highlight clear SignColumn
" highlight SignColumn cterm=NONE ctermbg=237 ctermfg=NONE guibg=darkred guifg=white
" hi LineNr         ctermfg=DarkMagenta guifg=#2b506e guibg=#000000
" hi LineNr   cterm=NONE ctermbg=0 ctermfg=NONE guibg=darkred guifg=white
" highlight LineNr ctermbg=black

" 设置分隔线样式
hi VertSplit    term=reverse        cterm=reverse          gui=none

" 设置分隔线字符
" set fillchars=vert:┆ 


" 开启高亮光标列
" set cursorcolumn
" hi CursorColumn cterm=NONE ctermbg=237 ctermfg=NONE guibg=darkred guifg=white


function! CustomizedTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        let s .= (i == t ? '%1*' : '%2*')
        let s .= ' '
        let s .= i . ':'
        let s .= '%*'
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        let file = bufname(buflist[winnr - 1])
        let file = fnamemodify(file, ':p:t')
        if file == ''
            let file = '[No Name]'
        endif
        let s .= file
        let s .= ' '
        let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction

" Always show the tablilne 
set stal=2
set tabline=%!CustomizedTabLine()
