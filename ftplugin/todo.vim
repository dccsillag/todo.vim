function g:TodoNewLineBelow()
    if match(getline('.'), '^\s*[+-\*] .\+') >= 0
        execute "normal! o- "
        startinsert!
    else
        execute "normal! o"
        startinsert!
    endif
endfunction

function g:TodoNewLineAbove()
    if match(getline('.'), '^\s*[+-\*] .\+') >= 0
        execute "normal! O- "
        startinsert!
    else
        execute "normal! O"
        startinsert!
    endif
endfunction

function g:TodoShiftRight()
    let l:line = line(".")
    let l:colno = col(".")
    normal! >>
    call cursor(l:line, l:colno + &sw)
endfunction

function g:TodoShiftLeft()
    let l:line = line(".")
    let l:colno = col(".")
    normal! <<
    call cursor(l:line, max([l:colno - &sw, 1]))
endfunction

function g:TodoCycleStatus()
    let l:colno = col(".")
    normal! 0
    if match(getline('.'), '^\s*- .\+') >= 0
        normal! f-
        normal! r*
    elseif match(getline('.'), '^\s*\* .\+') >= 0
        normal! f*
        normal! r+
    elseif match(getline('.'), '^\s*+ .\+') >= 0
        normal! f+
        normal! r-
    endif
    execute "normal! " .. l:colno .. "|"
endfunction

function g:TodoReverseCycleStatus()
    let l:colno = col(".")
    normal! 0
    if match(getline('.'), '^\s*- .\+') >= 0
        normal! f-
        normal! r+
    elseif match(getline('.'), '^\s*+ .\+') >= 0
        normal! f+
        normal! r*
    elseif match(getline('.'), '^\s*\* .\+') >= 0
        normal! f*
        normal! r-
    endif
    execute "normal! " .. l:colno .. "|"
endfunction


setlocal foldmethod=syntax
setlocal conceallevel=2

nnoremap <buffer><silent> o :call g:TodoNewLineBelow()<CR>
nnoremap <buffer><silent> O :call g:TodoNewLineAbove()<CR>
inoremap <buffer><silent> <CR> <ESC>:call g:TodoNewLineBelow()<CR>
inoremap <buffer><silent> <Tab> <C-O>:call g:TodoShiftRight()<CR>
inoremap <buffer><silent> <S-Tab> <C-O>:call g:TodoShiftLeft()<CR>
nnoremap <buffer><silent> <Space> :call g:TodoCycleStatus()<CR>
" Note: the following mapping will not work in a terminal (only in GVim)
nnoremap <buffer><silent> <S-Space> :call g:TodoReverseCycleStatus()<CR>
