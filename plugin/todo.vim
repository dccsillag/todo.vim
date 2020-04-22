" todo.vim
"
" Author: Daniel Csillag
" Description: Setting up options for `todo.vim`.

function s:GlobalOption(name, default_value)
    execute "let g:todovim_" .. a:name .. " = " .. a:default_value
endfunction


" Name: g:todovim_foldcolumn
" Default: 5
"
" The `foldcolumn` (`fdc`) to set in the start of the `ftplugin`.
"   If set to `-1`, then don't set the `fdc` at all.
call s:GlobalOption("foldcolumn", 5)
