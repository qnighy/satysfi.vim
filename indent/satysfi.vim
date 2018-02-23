" Vim indent file
" Language:     SATySFi
" Author:       Masaki Hara <ackie.h.gmai@gmail.com>
" Date:         February 21, 2018
" File Types:   satysfi
" Version:      1
" Notes:

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nocindent
setlocal expandtab
setlocal indentexpr=GetSATySFiIndent()
setlocal indentkeys+=0=and,0=constraint,0=else,0=end,0=if,0=in,0=let,0=let-block,0=let-inline,0=let-math,0=let-mutable,0=let-rec,0=then,0=type,0=val,0=with,0=\|>,0\|,0},0],0=]>,0),0=\|),0<>>,0*,0=**,0=***,0=****,0=*****,0=******,0=*******
setlocal nolisp
setlocal nosmartindent

" Only define the function once.
if exists("*GetSATySFiIndent")
 finish
endif

" Ignoring patterns
let s:ignorepat = 'synIDattr(synID(line("."), col("."), 0), "name") =~ "Comment\\|Literal"'
let s:ignorepat_for_prog = 'synIDattr(synID(line("."), col("."), 0), "name") !~ "^\\%(satysfiProg\\|$\\)"'
let s:ignorepat_op = 'synIDattr(synID(line("."), col("."), 0), "name") =~ "Comment\\|Literal\\|Operator"'

" Expr delimiters to ignore
" [], (), match-with, let*-in, while-do, if-else, fun-->
" s:ignorepat can ignore {}, ${}, and '<>, so omit them here
let s:exprbegin = '\%([([]\|\<\%(match\|let\|let-rec\|let-mutable\|let-inline\|let-block\|let-math\|while\|if\|fun\)\>\)'
let s:exprend = '\%([])]\|->\|\<\%(with\|in\|do\|else\)\>\)'

" Module delimiters to ignore
" sig-end, struct-end
let s:modbegin = '\<\%(sig\|struct\)\>'
let s:modend = '\<end\>'

" Indent pairs
function! s:FindPair(pstart, pmid, pend)
  call search(a:pend, 'cW')
  return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn', s:ignorepat))
endfunction
function! s:FindPairBefore(pstart, pmid, pend)
  return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn', s:ignorepat))
endfunction
function! s:FindPairProg(pstart, pmid, pend)
  call search(a:pend, 'cW')
  return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn', s:ignorepat_for_prog))
endfunction
function! s:FindPairBeforeProg(pstart, pmid, pend)
  return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn', s:ignorepat_for_prog))
endfunction
function! s:FindPairSkipOp(pstart, pmid, pend)
  call search(a:pend, 'cW')
  return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn', s:ignorepat_op))
endfunction

function! s:ProgIndent()
  " Search for the previous non-empty line
  " Lines starting with |> are also ignored
  call cursor(v:lnum, 1)
  let llnum = search('^\s*\%(|>\)\@![^ \t\r\n%]', 'bWn')
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

  " Some canonicalization
  let lindent_orig = lindent
  if lline =~ '^\s*|\s*'
    let lindent = lindent + strlen(matchlist(lline, '^\s*\(|\s*\)')[1])
  endif

  " Find module indentation
  let modindent = 0
  call cursor(v:lnum, 1)
  let modlpos = searchpair(s:modbegin, '\<\%(sig\|struct\)\>', s:modend, 'bWn', s:ignorepat_for_prog)
  if modlpos > 0
    let modindent = indent(modlpos) + shiftwidth()
  endif

  " Current line
  let line = getline(v:lnum)

  " Do indentation by constructions
  call cursor(v:lnum, 1)
  if line =~ '^\s*\%(let\|let-block\|let-inline\|let-math\|let-mutable\|let-rec\)\>'
    " It is either a let-in or a toplevel/module-level let.
    if lline =~ '\<in\s*$'
      " Align let-ins same
      return lindent
    elseif lline =~ '\<\%(not\|mod\|if\|then\|else\|let\|let-rec\|and\|fun\|before\|while\|do\|let-mutable\|match\|with\|when\|as\|type\|of\|module\|struct\|sig\|val\|direct\|constraint\|let-inline\|let-block\|let-math\|controls\|command\)\s*$'
      " Seems to be let-in
      return lindent + shiftwidth()
    elseif lline =~ '\%([a-zA-Z][-a-zA-Z0-9]*\|[0-9]\+\.\?\|[])}`]\)\s*$'
      " Seems to be the toplevel let
      return modindent
    else
      " Seems to be let-in
      return lindent + shiftwidth()
    endif
  elseif line =~ '^\s*type\>'
    " Toplevel or module-level type
    return modindent
  elseif line =~ '^\s*and\>'
    " let-rec/and or type/and
    " TODO: deal with paths
    let let_line = search('\<\%(let\|let-block\|let-inline\|let-math\|let-mutable\|let-rec\)\>', 'bWn')
    let type_line = search('\<type\>', 'bWn')
    if let_line >= type_line
      return s:FindPairBeforeProg('\<\%(let\|let-block\|let-inline\|let-math\|let-mutable\|let-rec\)\>', '', '\<in\>')
    else
      return modindent
    endif
  elseif line =~ '^\s*direct\>'
    " Module-level direct declaration
    return modindent
  elseif line =~ '^\s*module\>'
    " Toplevel or module-level module definition
    return modindent
  elseif line =~ '^\s*do\>'
    " while-do
    return s:FindPairProg('\<while\>', '', '\<do\>')
  elseif line =~ '^\s*then\>'
    " if-then-else
    return s:FindPairBeforeProg('\<if\>', '', '\<else\>')
  elseif line =~ '^\s*else\>'
    " if-then-else
    return s:FindPairProg('\<if\>', '', '\<else\>')
  elseif line =~ '^\s*->'
    " fun ->
    return s:FindPairProg('\<fun\>', '', '->')
  elseif line =~ '^\s*|>' && lline =~ '|>'
    " Align |> same
    return match(lline, '|>')
  elseif line =~ '^\s*in\>'
    return s:FindPairProg('\<\%(let\|let-block\|let-inline\|let-math\|let-mutable\|let-rec\)\>', '', '\<in\>')
  elseif line =~ '^\s*|' && line !~ '^\s*|)'
    " type or match
    let up_lpos = searchpair(s:exprbegin, '^\s*\<type\>\|\<match\>\|^\s*|', s:exprend, 'bWn', s:ignorepat_for_prog)
    let up_line = getline(up_lpos)
    let up_indent = indent(up_lpos)
    if up_line =~ '^\s*\<type\>'
      return up_indent + shiftwidth()
    elseif up_line =~ '\<match\>'
      let matchoff = strlen(matchlist(up_line, '^\s*\(.\{-}\)\<match\>')[1])
      return up_indent + matchoff
    elseif up_line =~ '^\s*|'
      return up_indent
    else
      " unknown
      return -1
    endif
  elseif line =~ '^\s*end'
    return s:FindPair(s:modbegin, '', s:modend)
  elseif line =~ '^\s*)'
    return s:FindPair('(', '', ')')
  elseif line =~ '^\s*|)'
    return s:FindPair('(|', '', '|)')
  elseif line =~ '^\s*]'
    return s:FindPair('\[', '', '\]')
  elseif line =~ '^\s*]>'
    return s:FindPair('<\[', '', '\]>')
  elseif lline =~ '[;,]\s*$'
    " Seems to be in a listy thing. Align same
    return lindent
  else
    return lindent + shiftwidth()
  endif
  return -1
endfunction

function! s:VertIndent()
  " Search for the previous non-empty line
  call cursor(v:lnum, 1)
  let llnum = search('^\s*[^ \t\r\n%]', 'bWn')
  call cursor(v:lnum, 1)
  if llnum == 0
    " 0 indent at the top
    return 0
  endif

  " Previous line and its indentation
  let lline = substitute(getline(llnum), '%.*', '', '')
  let lindent = indent(llnum)

  " Current line
  let line = getline(v:lnum)

  if line =~ '^\s*>'
    return s:FindPairSkipOp('<', '', '>')
  elseif lline =~ '<\s*$'
    return lindent + shiftwidth()
  else
    return lindent
  endif
  return -1
endfunction

function! s:HorzIndent()
  " Search for the previous non-empty line
  call cursor(v:lnum, 1)
  let llnum = search('^\s*[^ \t\r\n%]', 'bWn')
  call cursor(v:lnum, 1)
  if llnum == 0
    " 0 indent at the top
    return 0
  endif

  " Previous line and its indentation
  let lline = substitute(getline(llnum), '%.*', '', '')
  let lindent = indent(llnum)

  " Previous bullet
  let lbulletindent = lindent
  if lline =~ '^\s*\*'
    let lbulletindent = lindent + strlen(matchlist(lline, '^\s*\(\*\+\s*\)')[1])
  endif

  " Current line
  let line = getline(v:lnum)

  if line =~ '^\s*}'
    return s:FindPair('{', '', '}')
  elseif lline =~ '{\s*$'
    return lindent + shiftwidth()
  elseif line =~ '^\s*\*'
    let numbullet = strlen(matchlist(line, '^\s*\(\*\+\)')[1])
    let lblnum = search('^\s*\%(\*\{' . (numbullet + 1) . '}\)\@!\*', 'bWn')
    let lbindent = indent(lblnum)
    let lbline = getline(lblnum)
    if lbline !~ '^\s*\*'
      return -1
    endif
    let lbnumbullet = strlen(matchlist(lbline, '^\s*\(\*\+\)')[1])
    return lbindent + (numbullet - lbnumbullet) * shiftwidth()
  else
    return lbulletindent
  endif
  return -1
endfunction

function! s:MathIndent()
  return -1
endfunction

function! GetSATySFiIndent()
  call cursor(v:lnum, 1)
  let synname = synIDattr(synID(line("."), col("."), 0), "name")
  if synname =~ '^satysfiProg' || synname == ''
    return s:ProgIndent()
  elseif synname =~ '^satysfiVert'
    return s:VertIndent()
  elseif synname =~ '^satysfiHorz'
    return s:HorzIndent()
  elseif synname =~ '^satysfiMath'
    return s:MathIndent()
  endif
  return -1
endfunction
