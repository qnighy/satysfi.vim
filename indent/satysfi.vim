" Vim indent file
" Language:     SATySFi
" Author:       Masaki Hara <ackie.h.gmai@gmail.com>
" Date:         February 21, 2018
" File Types:   satysfi
" Version:      1
" Notes:

" This indent file is experimental under g:satysfi_indent.
if !exists("g:satysfi_indent") || g:satysfi_indent == 0
 finish
endif

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nocindent
setlocal expandtab
setlocal indentexpr=GetSATySFiIndent()
setlocal indentkeys+=0=and,0=constraint,0=else,0=end,0=if,0=in,0=let,0=let-block,0=let-inline,0=let-math,0=let-mutable,0=let-rec,0=then,0=type,0=val,0=with,0=\|>,0\|,0},0],0),0<>>
setlocal nolisp
setlocal nosmartindent

" Only define the function once.
if exists("*GetSATySFiIndent")
 finish
endif

" Indent pairs
function! s:FindPair(pstart, pmid, pend)
 call search(a:pend, 'W')
 " return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "literal\\|comment"'))
 return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn'))
endfunction

function! GetSATySFiIndent()
  " Search for the previous non-empty line
  " Lines starting with |> are also ignored
  call cursor(v:lnum, 1)
  let llnum = search('^\s*\%(|>\)\@![^ \t\r\n%]', 'bWn')
  call cursor(v:lnum, 1)
  if llnum == 0
    " 0 indent at the top
    return 0
  endif

  " Previous line and its indentation
  let lline = substitute(getline(llnum), '%.*', '', '')
  let lindent = indent(llnum)

  if lline =~ '^\s*@[a-z][-a-zA-Z0-9]*:'
    " 0 indent just below the headers
    return 0
  endif

  " Current line
  let line = getline(v:lnum)
  if line =~ '^\s*\%(let\|let-block\|let-inline\|let-math\|let-mutable\|let-rec\)\>'
    if lline =~ '\<in\s*$'
      " Align let-ins same
      return lindent
    elseif lline =~ '\<\%(not\|mod\|if\|then\|else\|let\|let-rec\|and\|fun\|before\|while\|do\|let-mutable\|match\|with\|when\|as\|type\|of\|module\|struct\|sig\|val\|direct\|constraint\|let-inline\|let-block\|let-math\|controls\|command\)\s*$'
      " Seems to be let-in
      return lindent + shiftwidth()
    elseif lline =~ '\%([a-zA-Z][-a-zA-Z0-9]*\|[0-9]\+\.\?\|[])}`]\|\S>\)\s*$'
      " Seems to be the toplevel let
      return 0
    else
      " Seems to be let-in
      return lindent + shiftwidth()
    endif
  elseif line =~ '^\s*|>' && lline =~ '|>'
    " Align |> same
    return match(lline, '|>')
  elseif line =~ '^\s*in\>'
    return s:FindPair('\<\%(let\|let-block\|let-inline\|let-math\|let-mutable\|let-rec\)\>', '', '\<in\>')
  elseif line =~ '^\s*|'
    return lindent
  elseif line =~ '^\s*)'
    return s:FindPair('(', '', ')')
  elseif line =~ '^\s*]'
    return s:FindPair('\[', '', '\]')
  else
    return lindent + shiftwidth()
  endif
  " if line =~ '^\s*|>' && lline =~ ' |> '
  "   return match(lline, ' |> ') + 1
  " elseif line =~ '^\s*| '
  "   return lindent
  " elseif line =~ '^\s*@\%(require\|import\):'
  "   return 0
  " elseif lline =~ '=\s*$'
  "   return lindent + shiftwidth()
  " elseif lline =~ '\<in\s*$'
  "   if line =~ '^\s*\%(let\|let-block\|let-inline\|let-math\|let-mutable\|let-rec\|match\)\>'
  "     return lindent
  "   else
  "     return lindent + shiftwidth()
  "   endif
  " else
  "   return lindent + shiftwidth()
  " endif
  return -1
endfunction
