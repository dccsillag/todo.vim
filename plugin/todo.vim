function s:SetupTodo()
    setlocal foldmethod=syntax

    nnoremap <silent> o :call g:TodoNewLineBelow()<CR>
    nnoremap <silent> O :call g:TodoNewLineAbove()<CR>
    nnoremap <silent> <Space> :call g:TodoCycleStatus()<CR>
    " Note: the following mapping will not work in a terminal (only in GVim)
    nnoremap <silent> <S-Space> :call g:TodoReverseCycleStatus()<CR>
endfunction

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

function g:TodoCycleStatus()
    let l:colno = col(".")
    if match(getline('.'), '^\s*- .\+') >= 0
        let l:i = match(getline('.'), '- .\+')
        execute "normal! " .. l:i .. "|r*"
    elseif match(getline('.'), '^\s*\* .\+') >= 0
        let l:i = match(getline('.'), '\* .\+')
        execute "normal! " .. l:i .. "|r+"
    elseif match(getline('.'), '^\s*+ .\+') >= 0
        let l:i = match(getline('.'), '+ .\+')
        execute "normal! " .. l:i .. "|r-"
    endif
    execute "normal! " .. l:colno .. "|"
endfunction

function g:TodoReverseCycleStatus()
    let l:colno = col(".")
    if match(getline('.'), '^\s*- .\+') >= 0
        let l:i = match(getline('.'), '- .\+')
        execute "normal! " .. l:i .. "|r+"
    elseif match(getline('.'), '^\s*+ .\+') >= 0
        let l:i = match(getline('.'), '+ .\+')
        execute "normal! " .. l:i .. "|r*"
    elseif match(getline('.'), '^\s*\* .\+') >= 0
        let l:i = match(getline('.'), '\* .\+')
        execute "normal! " .. l:i .. "|r-"
    endif
    execute "normal! " .. l:colno .. "|"
endfunction

augroup todovim
    autocmd!
    autocmd FileType todo call s:SetupTodo()
augroup END
