" todo.vim
"
" Author: Daniel Csillag
" Description: Syntax coloring and folding for `todo.vim`.

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" ------------------------------------------------------------------------------

" Matches some markup (bold/italic/underline)
syntax region markupItalic        matchgroup=Conceal start="\*"   skip="\\\*" end="\*"           concealends
syntax region markupBold          matchgroup=Conceal start="\*\*" skip="\\\*" end="\*\*"         concealends
syntax region markupItalic        matchgroup=Conceal start="_"    skip="\\_"  end="_"            concealends
syntax region markupUnderline     matchgroup=Conceal start="__"   skip="\\__" end="__"           concealends
syntax region markupVerbatim      matchgroup=Conceal start="`"    skip="\\`"  end="`"    oneline concealends
syntax region markupVerbatim      matchgroup=Conceal start="```"              end="```"          concealends cchar=¬
" " The following regex was taken from https://gist.github.com/tobym/584909:
syntax match  markupURL       /\<https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*\>/
syntax match  markupEmail     /\<[-A-Za-z0-9.]\+@[-A-Za-z0-9]\+\(\.[-A-Za-z0-9]\+\)\+\>/
syntax match  markupItemWhole /^ *\./ contains=markupItemDot
syntax match  markupItemDot   /\./ conceal cchar=• contained

" Matches some pretty concealing (arrows, ellipsis, etc.)
syntax match Conceal /\.\.\./ conceal cchar=…
syntax match Conceal /->/ conceal cchar=→
syntax match Conceal /<-/ conceal cchar=←
syntax match Conceal /<->/ conceal cchar=↔
syntax match Conceal /=>/ conceal cchar=⇒
syntax match Conceal /<=/ conceal cchar=⇐
syntax match Conceal /==>/ conceal cchar=⇒
syntax match Conceal /<==/ conceal cchar=⇐
syntax match Conceal /<=>/ conceal cchar=⇔

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

highlight link EntryTODO      Keyword
highlight link EntryWIP       Identifier
highlight link EntryDone      Comment

highlight markupBold      ctermfg=NONE      ctermbg=NONE cterm=bold           guifg=NONE       guibg=NONE gui=bold
highlight markupItalic    ctermfg=NONE      ctermbg=NONE cterm=italic         guifg=NONE       guibg=NONE gui=italic
highlight markupUnderline ctermfg=NONE      ctermbg=NONE cterm=underline      guifg=NONE       guibg=NONE gui=underline
highlight markupItem      ctermfg=NONE      ctermbg=NONE cterm=bold           guifg=NONE       guibg=NONE gui=bold
highlight markupVerbatim  ctermfg=gray      ctermbg=NONE cterm=bold           guifg=gray       guibg=NONE gui=bold
highlight markupURL       ctermfg=lightblue ctermbg=NONE cterm=bold,underline guifg=lightblue  guibg=NONE gui=bold,underline
highlight markupEmail     ctermfg=green     ctermbg=NONE cterm=bold,underline guifg=lightgreen guibg=NONE gui=bold,underline

" ------------------------------------------------------------------------------

let b:current_syntax = "todo"

let &cpo = s:cpo_save
unlet s:cpo_save
