if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" ------------------------------------------------------------------------------

" Matches some markup (bold/italic/underline)
syntax region markupItalic    matchgroup=Conceal start="\*"   skip="\\\*" end="\*"   concealends
syntax region markupBold      matchgroup=Conceal start="\*\*" skip="\\\*" end="\*\*" concealends
syntax region markupItalic    matchgroup=Conceal start="_"    skip="\\_"  end="_"    concealends
syntax region markupUnderline matchgroup=Conceal start="__"   skip="\\__" end="__"   concealends

" Matches todo/wip/done entries:
syntax match EntryTODO /^\s*- .\+/
syntax match EntryWIP /^\s*\* .\+/
syntax match EntryDone /^\s*+ .\+/

" Matches the whole entries, for various multiples of `shiftwidth`, for proper
" folding:
for level in range(0, 8)
    let indent = &sw * level
    if level == 0
        execute "syntax match toFold /^[-+\\*] .\\+\\n\\([^-+\\*].*\\n\\| \+.*\\n\\|\\n\\)\\+/ transparent fold"
    else
        execute "syntax match toFold /^ \\{" .. indent .. "}[-+\\*] .\\+\\n\\( \\{" .. indent .. "}[^-+\\*].*\\n\\| \\{" .. (indent+1) .. ",}[^ ].*\\n\\|\\n\\)\\+/ transparent fold"
    endif
endfor
syntax sync fromstart

" Matches titles
syntax match Title /.\+\n===\+\n/
syntax match Title /.\+\n---\+\n/

" Matches properties
syntax match Special /[a-z-]:\s\+.\+\n/

" ------------------------------------------------------------------------------

highlight link EntryTODO Keyword
highlight link EntryWIP  Identifier
highlight link EntryDone Comment
highlight markupBold ctermfg=NONE ctermbg=NONE cterm=bold guifg=NONE guibg=NONE gui=bold
highlight markupItalic ctermfg=NONE ctermbg=NONE cterm=italic guifg=NONE guibg=NONE gui=italic
highlight markupUnderline ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline

" ------------------------------------------------------------------------------

let b:current_syntax = "todo"

let &cpo = s:cpo_save
unlet s:cpo_save
