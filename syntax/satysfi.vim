" Vim syntax file
" Language:     SATySFi
" Author:       Masaki Hara <ackie.h.gmai@gmail.com>
" Date:         February 20, 2018
" File Types:   satysfi
" Version:      1
" Notes:
"

" Setup
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

setlocal iskeyword=a-z,A-Z,-,48-57

" Case-sensitive
syn case match

syn cluster satysfiProg contains=satysfiIdentifier,satysfiTypeVariable,satysfiProgKeyword,satysfiHeadRequire,satysfiHeadImport,satysfiNumber,satysfiLength,satysfiProgEncl,satysfiConstructor,satysfiProgOperator,satysfiModulePrefix,satysfiCommandHorz,satysfiCommandVert,satysfiLiteral,satysfiComment,satysfiAngleWithTick,satysfiBraces,satysfiDollarBraces
syn cluster satysfiActv contains=satysfiProgEncl,satysfiArgControl,satysfiComment,satysfiAngle,satysfiBraces

syn match satysfiIdentifier "\<[a-z][-a-zA-Z0-9]*\>"
syn match satysfiTypeVariable "'[a-z][-a-zA-Z0-9]*\>"
syn match satysfiHashVariable "#\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained

syn keyword satysfiProgKeyword not mod if then else let let-rec and in fun
syn keyword satysfiProgKeyword true false before while do let-mutable
syn keyword satysfiProgKeyword match with when as type of module struct sig
syn keyword satysfiProgKeyword val end direct constraint
syn keyword satysfiProgKeyword let-inline let-block let-math controls cycle
syn keyword satysfiProgKeyword inline-cmd block-cmd math-cmd command
syn region satysfiHeadRequire matchgroup=satysfiKeyword start="@require:" matchgroup=NONE end="$" contains=satysfiKnownPackage
syn region satysfiProgHeadImport matchgroup=satysfiKeyword start="@import:" matchgroup=NONE end="$"
syn keyword satysfiKnownPackage contained code color deco gr hdecoset itemize list math mitou-report pervasives stdja stdjabook tabular vdecoset

syn match satysfiNumber "0\|[1-9][0-9]*"
syn match satysfiNumber "0[xX][0-9a-fA-F]\+"
syn match satysfiNumber "[0-9]\+\.[0-9]*\|\.[0-9]\+"
syn match satysfiLength "\%(0\|[1-9][0-9]*\)[a-z][-a-zA-Z0-9]*"
syn match satysfiLength "\%([0-9]\+\.[0-9]*\|\.[0-9]\+\)[a-z][-a-zA-Z0-9]*"


syn region satysfiProgEncl transparent matchgroup=satysfiProgKeyword start="(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg
syn region satysfiProgEncl transparent matchgroup=satysfiProgKeyword start="(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg
syn region satysfiProgEncl transparent matchgroup=satysfiProgKeyword start="\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg
syn region satysfiProgEnclBang contained transparent matchgroup=satysfiProgKeyword start="!(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg
syn region satysfiProgEnclBang contained transparent matchgroup=satysfiProgKeyword start="!(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg
syn region satysfiProgEnclBang contained transparent matchgroup=satysfiProgKeyword start="!\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg
syn match satysfiProgKeyword "<\["
syn match satysfiProgKeyword "\]>"

syn match satysfiConstructor  "()"
syn match satysfiConstructor  "(|\s*|)"
syn match satysfiConstructor  "\[\s*\]"

syn match satysfiProgOperator  ";"
syn match satysfiProgOperator  "#"

syn match satysfiProgOperator "\.\."
syn match satysfiProgOperator "--"
syn match satysfiProgOperator "->"
syn match satysfiProgOperator "<-"
syn match satysfiProgOperator "|"
syn match satysfiProgOperator "_"
syn match satysfiProgOperator "::"
syn match satysfiProgOperator "-"
syn match satysfiProgOperator "="
syn match satysfiProgOperator "*"
syn match satysfiProgOperator "+[-+*/^&|!:=<>~'.?]*"
syn match satysfiProgOperator "-[-+*/^&|!:=<>~'.?]\+"
syn match satysfiProgOperator "*[-+*/^&|!:=<>~'.?]\+"
syn match satysfiProgOperator "/[-+*/^&|!:=<>~'.?]*"
syn match satysfiProgOperator "=[-+*/^&|!:=<>~'.?]\+"
syn match satysfiProgOperator "<[-+*/^&|!:=<>~'.?]*"
syn match satysfiProgOperator ">[-+*/^&|!:=<>~'.?]*"
syn match satysfiProgOperator "&[-+*/^&|!:=<>~'.?]\+"
syn match satysfiProgOperator "|[-+*/^&|!:=<>~'.?]\+"
syn match satysfiProgOperator "\^[-+*/^&|!:=<>~'.?]*"
syn match satysfiProgOperator "?"
syn match satysfiArgControl "?:"
syn match satysfiArgControl "?\*"
syn match satysfiProgOperator "!"

syn match satysfiModulePrefix "[A-Z][-a-zA-Z0-9]*\.\@="

syn match satysfiEscape "\\[ -@[-`{-~]" contained
syn match satysfiCommandHorz "\\[a-zA-Z][-a-zA-Z0-9]*"
syn match satysfiCommandVert "+[a-zA-Z][-a-zA-Z0-9]*"

syn region satysfiLiteral start="`" end="`"
syn region satysfiLiteral start="``" end="``"
syn region satysfiLiteral start="```" end="```"
syn region satysfiLiteral start="````" end="````"
syn region satysfiLiteral start="`````" end="`````"
syn region satysfiLiteral start="``````" end="``````"
syn region satysfiLiteral start="```````" end="```````"
syn region satysfiLiteral start="````````" end="````````"
syn region satysfiLiteral start="`````````" end="`````````"
syn region satysfiLiteral start="``````````" end="``````````"
syn region satysfiLiteral start="```````````" end="```````````"

syn region satysfiComment start="%" end="$" contains=@Spell

syn region satysfiAngleWithTick matchgroup=satysfiKeyword start="'<" matchgroup=satysfiKeyword end=">" contains=@satysfiVert
syn region satysfiAngle contained matchgroup=satysfiKeyword start="<" matchgroup=satysfiKeyword end=">" contains=@satysfiVert
syn region satysfiAngleBang contained matchgroup=satysfiKeyword start="!<" matchgroup=satysfiKeyword end=">" contains=@satysfiVert
syn region satysfiBraces matchgroup=satysfiKeyword start="{" matchgroup=satysfiKeyword end="}" contains=@satysfiHorz
syn region satysfiMathBraces contained matchgroup=satysfiKeyword start="{" matchgroup=satysfiKeyword end="}" contains=@satysfiMath
syn region satysfiDollarBraces matchgroup=satysfiKeyword start="\${" matchgroup=satysfiKeyword end="}" contains=@satysfiMath
syn region satysfiBracesBang contained matchgroup=satysfiKeyword start="!{" matchgroup=satysfiKeyword end="}" contains=@satysfiHorz


" Vertical mode
syn cluster satysfiVert contains=satysfiComment,satysfiVertInvoke,satysfiAngle,satysfiBraces
syn region satysfiVertInvoke contained transparent matchgroup=satysfiCommandVert start="[+#]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" matchgroup=satysfiKeyword end=";\|[}>]\@<=" contains=@satysfiActv


" Horizontal mode
syn cluster satysfiHorz contains=satysfiComment,satysfiHorzInvoke,satysfiAngle,satysfiBraces,satysfiDollarBraces,satysfiHorzOperator,satysfiEscape,satysfiLiteral

syn region satysfiHorzInvoke contained transparent matchgroup=satysfiCommandHorz start="[\\#]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" matchgroup=satysfiKeyword end=";\|[}>]\@<=" contains=@satysfiActv

syn match satysfiHorzOperator "|" contained
syn match satysfiHorzOperator "\*\+" contained


" Math mode
syn cluster satysfiMath contains=satysfiComment,satysfiHashVariable,satysfiEscape,satysfiCommandHorz,satysfiAngleBang,satysfiBracesBang,satysfiMathBraces,satysfiProgEnclBang,satysfiMathOperator,satysfiMathIdentifier

syn match satysfiMathOperator "\^" contained
syn match satysfiMathOperator "_" contained
syn match satysfiMathOperator "[-+*/:=<>~'.,?`]\+" contained
syn match satysfiMathIdentifier "[a-zA-Z0-9]" contained


" Sync heuristics
" TODO: conditionally disable it once bracket errors are implemented
" TODO: highlight stray close-brackets
" let seems to be a prog start
syn sync match satysfiSync grouphere NONE "^\%(let\)\@="
" `] seems to be the end of a literal
syn sync match satysfiSync grouphere NONE "`[]}>)]"
" +command{ seems to be a vert start
syn region satysfiSyncVert contained start="" end=">" contains=@satysfiVert
syn sync match satysfiSync grouphere satysfiSyncVert "^\s*\%(+[a-zA-Z][-a-zA-Z0-9.]*\s*[[({<?]\)\@="

syn sync minlines=100


" Bind mode-specific names to mode-agnostic names
hi def link satysfiProgKeyword satysfiKeyword
hi def link satysfiProgOperator satysfiOperator
hi def link satysfiHorzOperator satysfiOperator
hi def link satysfiMathOperator satysfiOperator

" Now we can link them with predefined groups.
hi def link satysfiKeyword Keyword
hi def link satysfiNumber Number
hi def link satysfiLength Number
hi def link satysfiConstructor Constant
hi def link satysfiFunDef Keyword
hi def link satysfiOperator Keyword
hi def link satysfiArgControl Keyword
hi def link satysfiModulePrefix Include
hi def link satysfiLiteral String
hi def link satysfiHashVariable Special
hi def link satysfiCommandVert Special
hi def link satysfiCommandHorz Special
hi def link satysfiComment Comment
hi def link satysfiKnownPackage Special

" Mark the buffer as highlighted.
let b:current_syntax = "satysfi"
