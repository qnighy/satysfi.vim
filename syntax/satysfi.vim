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

" Identifier = [a-zA-Z][-a-zA-Z0-9]*
setlocal iskeyword=a-z,A-Z,-,48-57

" Case-sensitive
syn case match



" Common ignores
syn region satysfiComment start="%" end="$" contains=satysfiCommentTodo,@Spell

syn keyword satysfiCommentTodo contained TODO FIXME XXX NB NOTE

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



" Program mode
syn cluster satysfiProg contains=satysfiComment,satysfiLiteral,satysfiProgIdentifier,satysfiProgConstructor,satysfiProgTypevar,satysfiProgError,satysfiProgHeadRequire,satysfiProgHeadImport,satysfiProgNumber,satysfiProgLength,satysfiProgOperator,satysfiProgKeyword,satysfiProgType,satysfiProgArgControl,satysfiProgModule,satysfiProgCommand,satysfiProgEncl,satysfiVertFromProg,satysfiHorzFromProg,satysfiMathFromProg

" '@' must form a valid header
syn match satysfiProgError "@[a-z]*[^a-z]\@="
" '\'' must be followed by '<' or an identifier
syn match satysfiProgError "'[^<a-z]\@="
" '$' must be followed by '{'
syn match satysfiProgError "\$[^{]\@="
" '"' is nowhere used
syn match satysfiProgError "\""

syn match satysfiProgIdentifier "\<[a-z][-a-zA-Z0-9]*\>"
syn match satysfiProgConstructor "\<[A-Z][-a-zA-Z0-9]*\>"
syn match satysfiProgTypevar "'[a-z][-a-zA-Z0-9]*\>"

syn keyword satysfiProgOperator not mod before
syn keyword satysfiProgKeyword if then else let let-rec and in fun
syn keyword satysfiProgKeyword true false while do let-mutable
syn keyword satysfiProgKeyword match with when as type of module struct sig
syn keyword satysfiProgKeyword val end direct constraint
syn keyword satysfiProgKeyword let-inline let-block let-math controls cycle
syn keyword satysfiProgKeyword command
syn keyword satysfiProgType inline-cmd block-cmd math-cmd
" Not really a keyword, but resolved by the compiler
syn keyword satysfiProgType list ref
" Predefined by the compiler (base_type_hash_table)
syn keyword satysfiProgType unit bool int float length string inline-text
syn keyword satysfiProgType block-text inline-boxes block-boxes context
syn keyword satysfiProgType pre-path path graphics image document math
" Predefined by the compiler (add_default_types)
syn keyword satysfiProgType option itemize color script language page
syn keyword satysfiProgType math-class math-char-class cell deco deco-set
syn keyword satysfiProgType inline-graphics
syn region satysfiProgHeadRequire matchgroup=satysfiProgKeyword start="@require:" matchgroup=NONE end="$" contains=satysfiProgKnownPackage
syn region satysfiProgHeadImport matchgroup=satysfiProgKeyword start="@import:" matchgroup=NONE end="$"
syn keyword satysfiProgKnownPackage contained code color deco gr hdecoset itemize list math mitou-report pervasives proof stdja stdjabook tabular vdecoset

syn match satysfiProgNumber "0\|[1-9][0-9]*"
syn match satysfiProgNumber "0[xX][0-9a-fA-F]\+"
syn match satysfiProgNumber "[0-9]\+\.[0-9]*\|\.[0-9]\+"
syn match satysfiProgLength "\%(0\|[1-9][0-9]*\)[a-z][-a-zA-Z0-9]*"
syn match satysfiProgLength "\%([0-9]\+\.[0-9]*\|\.[0-9]\+\)[a-z][-a-zA-Z0-9]*"

syn match satysfiProgOperator  ";"
syn match satysfiProgOperator  "#"

" TODO: a stray . might be an error, depending on the directions of the SATySFi
" grammar.
syn match satysfiProgOperator "\."
syn match satysfiProgOperator "\.\."
syn match satysfiProgOperator "--"
syn match satysfiProgKeyword "->"
syn match satysfiProgOperator "<-"
syn match satysfiProgKeyword "|"
syn match satysfiProgKeyword "_"
syn match satysfiProgOperator "::"
syn match satysfiProgOperator "-"
syn match satysfiProgKeyword "="
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
syn match satysfiProgKeyword "?"
syn match satysfiProgArgControl "?:"
syn match satysfiProgArgControl "?\*"
syn match satysfiProgOperator "!"

syn match satysfiProgModule "\%(\<module\s\+\)\@<=[A-Z][-a-zA-Z0-9]*"
syn match satysfiProgModule "[A-Z][-a-zA-Z0-9]*\.\@="

syn match satysfiProgCommand "[\\+][a-zA-Z][-a-zA-Z0-9]*"

syn region satysfiProgEncl transparent matchgroup=satysfiProgKeyword start="(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg
syn region satysfiProgEncl transparent matchgroup=satysfiProgKeyword start="(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg
syn region satysfiProgEncl transparent matchgroup=satysfiProgKeyword start="\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg
syn region satysfiProgEncl transparent matchgroup=satysfiProgKeyword start="<\[" matchgroup=satysfiProgKeyword end="\]>" contains=@satysfiProg
syn region satysfiVertFromProg matchgroup=satysfiProgKeyword start="'<" matchgroup=satysfiVertKeyword end=">" contains=@satysfiVert
syn region satysfiHorzFromProg matchgroup=satysfiProgKeyword start="{" matchgroup=satysfiHorzKeyword end="}" contains=@satysfiHorz
syn region satysfiMathFromProg matchgroup=satysfiProgKeyword start="\${" matchgroup=satysfiMathKeyword end="}" contains=@satysfiMath

syn match satysfiProgConstructor  "()"
syn match satysfiProgConstructor  "(|\s*|)"
syn match satysfiProgConstructor  "\[\s*\]"



" Vertical mode
syn cluster satysfiVert contains=satysfiComment,satysfiVertError,satysfiVertInvoke,satysfiVertEncl,satysfiHorzFromVert
syn cluster satysfiVertActv contains=satysfiComment,satysfiVertActvError,satysfiVertArgControl,satysfiProgFromVert,satysfiVertEncl,satysfiHorzFromVert

" Unexpected symbols
syn match satysfiVertError "[^ \t\r\n%#+<>{]" contained
syn match satysfiVertActvError "[^ \t\r\n%([{<;]" contained
" # and + must be followed by alpha
syn match satysfiVertError "[+#][^a-zA-Z]\@=" contained
" Special error for command names
syn match satysfiVertError "\\\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained
syn match satysfiVertActvError "[+#\\]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained

syn region satysfiVertInvoke contained transparent matchgroup=satysfiVertCommand start="[+#]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" matchgroup=satysfiVertKeyword end=";\|[}>]\@<=" contains=@satysfiVertActv
syn region satysfiVertInvoke contained transparent matchgroup=satysfiVertCommandSection start="\%(+section\|+subsection\)\>" matchgroup=satysfiVertKeyword end=";\|[}>]\@<=" contains=@satysfiVertActv
syn region satysfiVertInvoke contained transparent matchgroup=satysfiVertCommandKnown start="+\%(code\|console\|p\|pn\|listing\|math\)\>" matchgroup=satysfiVertKeyword end=";\|[}>]\@<=" contains=@satysfiVertActv

syn match satysfiVertArgControl "?:" contained
syn match satysfiVertArgControl "?\*" contained

syn region satysfiProgFromVert contained matchgroup=satysfiVertKeyword start="(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg
syn region satysfiProgFromVert contained matchgroup=satysfiVertKeyword start="(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg
syn region satysfiProgFromVert contained matchgroup=satysfiVertKeyword start="\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg
syn region satysfiVertEncl contained matchgroup=satysfiVertKeyword start="<" matchgroup=satysfiVertKeyword end=">" contains=@satysfiVert
syn region satysfiHorzFromVert contained matchgroup=satysfiVertKeyword start="{" matchgroup=satysfiHorzKeyword end="}" contains=@satysfiHorz



" Horizontal mode
syn cluster satysfiHorz contains=satysfiComment,satysfiLiteral,satysfiHorzError,satysfiHorzInvoke,satysfiHorzOperator,satysfiHorzEscape,satysfiVertFromHorz,satysfiHorzEncl,satysfiMathFromHorz,@Spell
syn cluster satysfiHorzActv contains=satysfiComment,satysfiHorzActvError,satysfiHorzArgControl,satysfiProgFromHorz,satysfiVertFromHorz,satysfiHorzEncl

" Unexpected symbols
syn match satysfiHorzError "[@;]" contained
syn match satysfiHorzActvError "[^ \t\r\n%([{<;]" contained
" # and + must be followed by alpha
syn match satysfiHorzError "[\\#][^a-zA-Z]\@=" contained
" $ must be followed by {
syn match satysfiHorzError "\$[^{]\@=" contained
" Special error for command names
syn match satysfiHorzError "+\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained
syn match satysfiHorzActvError "[+#\\]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained

syn region satysfiHorzInvoke contained transparent matchgroup=satysfiHorzCommand start="[\\#]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" matchgroup=satysfiHorzKeyword end=";\|[}>]\@<=" contains=@satysfiHorzActv
syn region satysfiHorzInvoke contained transparent matchgroup=satysfiHorzCommandKnown start="\\\%(LaTeX\|SATySFi\|TeX\|figure\|fil\|fil-both\|math\|ref\|ref-page\|tabular\)\>" matchgroup=satysfiHorzKeyword end=";\|[}>]\@<=" contains=@satysfiHorzActv
syn region satysfiHorzInvoke contained transparent matchgroup=satysfiHorzCommandStyle start="\\\%(emph\)\>" matchgroup=satysfiHorzKeyword end=";\|[}>]\@<=" contains=@satysfiHorzActv
syn match satysfiHorzEscape "\\[ -@[-`{-~]" contained

syn match satysfiHorzOperator "|" contained
syn match satysfiHorzOperator "\*\+" contained

syn match satysfiHorzArgControl "?:" contained
syn match satysfiHorzArgControl "?\*" contained

syn region satysfiProgFromHorz contained matchgroup=satysfiHorzKeyword start="(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg
syn region satysfiProgFromHorz contained matchgroup=satysfiHorzKeyword start="(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg
syn region satysfiProgFromHorz contained matchgroup=satysfiHorzKeyword start="\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg
syn region satysfiVertFromHorz contained matchgroup=satysfiHorzKeyword start="<" matchgroup=satysfiVertKeyword end=">" contains=@satysfiVert
syn region satysfiHorzEncl contained matchgroup=satysfiHorzKeyword start="{" matchgroup=satysfiHorzKeyword end="}" contains=@satysfiHorz
syn region satysfiMathFromHorz contained matchgroup=satysfiHorzKeyword start="\${" matchgroup=satysfiMathKeyword end="}" contains=@satysfiMath



" Math mode
syn cluster satysfiMath contains=satysfiComment,satysfiMathError,satysfiMathOperator,satysfiMathIdentifier,satysfiMathHashVariable,satysfiMathCommand,satysfiMathCommandKnown,satysfiMathEscape,satysfiProgFromMath,satysfiVertFromMath,satysfiHorzFromMath,satysfiMathEncl

" Unexpected symbols
syn match satysfiMathError "[][|()"#$&;@]" contained
" ! must be followed by [{<([]
syn match satysfiMathError "![^{<([]\@=" contained

syn match satysfiMathOperator "\^" contained
syn match satysfiMathOperator "_" contained
syn match satysfiMathOperator "[-+*/:=<>~'.,?`]\+" contained
syn match satysfiMathIdentifier "[a-zA-Z0-9]" contained
syn match satysfiMathHashVariable "#\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained
syn match satysfiMathCommand "\\[a-zA-Z][-a-zA-Z0-9]*" contained
syn match satysfiMathCommandKnown "\\\%(Gamma\|angle\|app\|brace\|derive\|frac\|infty\|int\|lambda\|ldots\|lim\|lower\|math-color\|math-skip\|mathbin\|mathord\|mathrel\|ordd\|paren\|pi\|pm\|sqrt\|sum\|tau\|to\|upper\)\>" contained
syn match satysfiMathCommandStyle "\\\%(bm\|math-style\|mathrm\|text\)\>" contained
syn match satysfiMathEscape "\\[ -@[-`{-~]" contained

syn region satysfiProgFromMath contained transparent matchgroup=satysfiMathKeyword start="!(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg
syn region satysfiProgFromMath contained transparent matchgroup=satysfiMathKeyword start="!(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg
syn region satysfiProgFromMath contained transparent matchgroup=satysfiMathKeyword start="!\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg
syn region satysfiVertFromMath contained matchgroup=satysfiMathKeyword start="!<" matchgroup=satysfiVertKeyword end=">" contains=@satysfiVert
syn region satysfiHorzFromMath contained matchgroup=satysfiMathKeyword start="!{" matchgroup=satysfiHorzKeyword end="}" contains=@satysfiHorz
syn region satysfiMathEncl contained matchgroup=satysfiMathKeyword start="{" matchgroup=satysfiMathKeyword end="}" contains=@satysfiMath



" Sync heuristics
" TODO: conditionally disable it once bracket errors are implemented
" TODO: highlight stray close-brackets
" let seems to be a prog start
syn sync match satysfiSync grouphere NONE "^\%(let\)\@="
" `] seems to be the end of a literal
syn sync match satysfiSync grouphere NONE "`[]}>)]"
" +command{ seems to be a vert start
syn region satysfiVertSync contained matchgroup=NONE start="" matchgroup=satysfiProgKeyword end=">" contains=@satysfiVert
syn sync match satysfiSync grouphere satysfiVertSync "^\s*\%(+[a-zA-Z][-a-zA-Z0-9.]*\s*[[({<?]\)\@="

syn sync minlines=100



" Bind mode-specific names to mode-agnostic names
hi def link satysfiProgError satysfiError
hi def link satysfiProgNumber satysfiNumber
hi def link satysfiProgLength satysfiLength
hi def link satysfiProgConstructor satysfiConstructor
hi def link satysfiProgKeyword satysfiKeyword
hi def link satysfiProgOperator satysfiOperator
hi def link satysfiProgType satysfiType
hi def link satysfiProgArgControl satysfiArgControl
hi def link satysfiProgModule satysfiModule
hi def link satysfiProgCommand satysfiCommand
hi def link satysfiProgKnownPackage satysfiKnownPackage

hi def link satysfiVertError satysfiError
hi def link satysfiVertActvError satysfiError
hi def link satysfiVertKeyword satysfiKeyword
hi def link satysfiVertCommand satysfiCommand
hi def link satysfiVertCommandKnown satysfiCommandKnown
hi def link satysfiVertCommandSection satysfiCommandSection

hi def link satysfiHorzError satysfiError
hi def link satysfiHorzActvError satysfiError
hi def link satysfiHorzKeyword satysfiKeyword
hi def link satysfiHorzOperator satysfiOperator
hi def link satysfiHorzCommand satysfiCommand
hi def link satysfiHorzCommandKnown satysfiCommandKnown
hi def link satysfiHorzCommandStyle satysfiCommandStyle
hi def link satysfiHorzEscape satysfiEscape

hi def link satysfiMathError satysfiError
hi def link satysfiMathKeyword satysfiKeyword
hi def link satysfiMathOperator satysfiOperator
hi def link satysfiMathHashVariable satysfiHashVariable
hi def link satysfiMathCommand satysfiCommand
hi def link satysfiMathCommandKnown satysfiCommandKnown
hi def link satysfiMathCommandStyle satysfiCommandStyle
hi def link satysfiMathEscape satysfiEscape

" Now we can link them with predefined groups.
hi def link satysfiError Error
hi def link satysfiKeyword Keyword
hi def link satysfiNumber Number
hi def link satysfiLength Number
hi def link satysfiConstructor Constant
hi def link satysfiFunDef Keyword
hi def link satysfiOperator Keyword
hi def link satysfiType Type
hi def link satysfiArgControl Keyword
hi def link satysfiModule Include
hi def link satysfiLiteral String
hi def link satysfiHashVariable Identifier
hi def link satysfiCommand Identifier
hi def link satysfiCommandSection PreCondit
hi def link satysfiCommandKnown Statement
hi def link satysfiCommandStyle Type
hi def link satysfiEscape Special
hi def link satysfiComment Comment
hi def link satysfiCommentTodo Todo
hi def link satysfiKnownPackage Special

" Mark the buffer as highlighted.
let b:current_syntax = "satysfi"
