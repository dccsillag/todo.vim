if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" ------------------------------------------------------------------------------

" Matches todo/wip/done entries:
syn match EntryTODO /^\s*- .\+/
syn match EntryWIP /^\s*\* .\+/
syn match EntryDone /^\s*+ .\+/

" Matches the whole entries, for various multiples of `shiftwidth`, for proper
" folding:
for level in [0, 1, 2, 3, 4]
    let indent = &sw * level
    if level == 0
        execute "syn match toFold /^[-+\\*] .\\+\\n\\([^-+\\*].*\\n\\| \+.*\\n\\|\\n\\)\\+/ transparent fold"
    else
        execute "syn match toFold /^ \\{" .. indent .. "}[-+\\*] .\\+\\n\\( \\{" .. indent .. "}[^-+\\*].*\\n\\| \\{," .. (indent-1) .. "}[^ ].*\\n\\| \\{" .. (indent+1) .. ",}[^ ].*\\n\\|\\n\\)\\+/ transparent fold"
    endif
endfor
syn sync fromstart

" Matches titles
syn match Title /.\+\n===\+\n/
syn match Title /.\+\n---\+\n/

" Matches properties
syn match Special /[a-z-]:\s\+.\+\n/

" ------------------------------------------------------------------------------

hi link EntryTODO Keyword
hi link EntryWIP  Identifier
hi link EntryDone Comment

" ------------------------------------------------------------------------------

let b:current_syntax = "todo"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: tw=80 cc=+1
