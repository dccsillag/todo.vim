" todo.vim
"
" Author: Daniel Csillag
" Description: Handy functionality for `todo.vim`.

function g:TodoNewLineBelow(consider_insert_mode)
    let l:is_at_end = !a:consider_insert_mode || col(".") > len(getline("."))

    if !l:is_at_end
        execute "normal! i\n"
    elseif getline(".") =~ "^\\s*[-+\\*] .\\+"
        execute "normal! o- "
        startinsert!
    elseif getline(".") =~ "^\\s*\\. .\\+"
        execute "normal! o. "
        startinsert!
    else
        if getline(".") =~ "^\\s*[-+\\*.] "
            normal! S
        endif

        normal! o_
        normal! x
        startinsert!
    endif
endfunction

function g:TodoNewLineAbove()
    if getline(".") =~ "^\\s*[-+\\*] .\\+"
        execute "normal! O- "
        startinsert!
    elseif getline(".") =~ "^\\s*\\. .\\+"
        execute "normal! O. "
        startinsert!
    else
        if getline(".") =~ "^\\s*[-+\\*.] "
            normal! S
        endif

        normal! O_
        normal! x
        startinsert!
    endif
endfunction

function g:TodoShiftRight()
    if getline(".") =~ "^\\s*[-+\\*] .*"
        let l:line = line(".")
        let l:colno = col(".")
        normal! >>
        call cursor(l:line, l:colno + &sw)
    else
        if col(".") > len(getline("."))
            execute "normal! a\t"
        else
            execute "normal! i\t"
        endif
        call cursor(getline("."), col(".")+1)
    endif
endfunction

function g:TodoShiftLeft()
    if getline(".") =~ "^\\s*[-+\\*] .*"
        let l:line = line(".")
        let l:colno = col(".")
        normal! <<
        call cursor(l:line, max([l:colno - &sw, 1]))
    endif
endfunction

function g:TodoCycleStatus()
    let l:colno = col(".")
    normal! 0
    if getline(".") =~ "^\\s*- .\\+"
        normal! f-
        normal! r+
    elseif getline(".") =~ "^\\s*+ .\\+"
        normal! f+
        normal! r*
    elseif getline(".") =~ "^\\s*\\* .\\+"
        normal! f*
        normal! r-
    endif
    execute "normal! " .. l:colno .. "|"
endfunction

function g:TodoReverseCycleStatus()
    let l:colno = col(".")
    normal! 0
    if getline(".") =~ "^\\s*- .\\+"
        normal! f-
        normal! r*
    elseif getline(".") =~ "^\\s*\\* .\\+"
        normal! f*
        normal! r+
    elseif getline(".") =~ "^\\s*+ .\\+"
        normal! f+
        normal! r-
    endif
    execute "normal! " .. l:colno .. "|"
endfunction


setlocal foldmethod=syntax
setlocal conceallevel=2
setlocal autoindent

nnoremap <buffer><silent> o         :call g:TodoNewLineBelow(0)<CR>
nnoremap <buffer><silent> O         :call g:TodoNewLineAbove()<CR>
inoremap <buffer><silent> <CR>      <C-\><C-O>:call g:TodoNewLineBelow(1)<CR>
inoremap <buffer><silent> <Tab>     <C-\><C-O>:call g:TodoShiftRight()<CR>
inoremap <buffer><silent> <S-Tab>   <C-\><C-O>:call g:TodoShiftLeft()<CR>
nnoremap <buffer><silent> <Space>   :call g:TodoCycleStatus()<CR>
vnoremap <buffer><silent> <Space>   :call g:TodoCycleStatus()<CR>
" Note: the following mapping will not work in a terminal (only in GVim)
nnoremap <buffer><silent> <S-Space> :call g:TodoReverseCycleStatus()<CR>
vnoremap <buffer><silent> <S-Space> :call g:TodoReverseCycleStatus()<CR>
