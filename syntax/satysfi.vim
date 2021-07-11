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
syn region satysfiCommentVertActv start="%" end="$" contains=satysfiCommentTodo,@Spell contained nextgroup=@satysfiVertActv skipwhite skipempty
syn region satysfiCommentVertActv2 start="%" end="$" contains=satysfiCommentTodo,@Spell contained nextgroup=@satysfiVertActv2 skipwhite skipempty
syn region satysfiCommentHorzActv start="%" end="$" contains=satysfiCommentTodo,@Spell contained nextgroup=@satysfiHorzActv skipwhite skipempty
syn region satysfiCommentHorzActv2 start="%" end="$" contains=satysfiCommentTodo,@Spell contained nextgroup=@satysfiHorzActv2 skipwhite skipempty

syn keyword satysfiCommentTodo contained TODO FIXME XXX NB NOTE



" Program mode
syn cluster satysfiProg contains=satysfiComment,satysfiStrLiteral,satysfiStrLiteralWithPos,satysfiProgIdentifier,satysfiProgConstructor,satysfiProgTypevar,satysfiProgError,satysfiProgHeadRequire,satysfiProgHeadImport,satysfiProgNumber,satysfiProgLength,satysfiProgOperator,satysfiProgKeyword,satysfiProgType,satysfiProgArgControl,satysfiProgModule,satysfiProgCommand,satysfiProgEncl,satysfiVertFromProg,satysfiHorzFromProg,satysfiMathListFromProg,satysfiMathFromProg

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

" The following keywords and its references are as of 2960f11.
" Predefined keywords in src/frontend/lexer.mll, line 291-
syn keyword satysfiProgOperator not mod before
syn keyword satysfiProgKeyword if then else let let-rec and in fun
syn keyword satysfiProgKeyword true false while do let-mutable
syn keyword satysfiProgKeyword match with when as type of module struct sig
syn keyword satysfiProgKeyword val end direct constraint
syn keyword satysfiProgKeyword let-inline let-block let-math controls cycle
syn keyword satysfiProgKeyword command open
syn keyword satysfiProgType inline-cmd block-cmd math-cmd
" Not really a keyword, but resolved by the compiler, in src/frontend/typeenv.ml, line 527-.
syn keyword satysfiProgType list ref
" Predefined by the compiler (base_type_hash_table), in src/frontend/types.cppo.ml, line 284-.
syn keyword satysfiProgType unit bool int float length string inline-text
syn keyword satysfiProgType block-text inline-boxes block-boxes context
syn keyword satysfiProgType pre-path path graphics image document math
syn keyword satysfiProgType regex text-info input-position
" Predefined by the compiler (add_default_types), in src/frontend/primitives.cppo.ml, line 166-.
syn keyword satysfiProgType option itemize color math-class math-char-class
" Predefined by the compiler (add_default_types), in src/frontend/primitives.cppo.ml, line 199-.
syn keyword satysfiProgType color script language page cell deco deco-set
syn keyword satysfiProgType inline-graphics

syn region satysfiProgHeadRequire matchgroup=satysfiProgKeyword start="@require:" matchgroup=NONE end="$" contains=satysfiProgKnownPackage
syn region satysfiProgHeadImport matchgroup=satysfiProgKeyword start="@import:" matchgroup=NONE end="$"
syn keyword satysfiProgKnownPackage contained code color deco gr hdecoset itemize list math mitou-report pervasives proof stdja stdjabook tabular vdecoset
syn region satysfiProgHeadStage matchgroup=satysfiProgKeyword start="@stage: *" matchgroup=NONE end="$" contains=satysfiProgStage,satysfiProgInvalidStage
syn match satysfiProgInvalidStage contained "."
syn match satysfiProgStage contained "persistent\|0\|1"

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
syn region satysfiMathFromProg matchgroup=satysfiProgKeyword start="\${" matchgroup=satysfiMathKeyword end="}" contains=@satysfiMathWithoutSep
syn region satysfiMathListFromProg matchgroup=satysfiProgKeyword start="\${[ \t\n\r]*|" matchgroup=satysfiMathKeyword end="|[ \t\n\r]*}" contains=@satysfiMathWithSep
syn match satysfiMathListFromProg "\${[ \t\n\r]*|[ \t\n\r]*}"

syn match satysfiProgConstructor  "()"
syn match satysfiProgConstructor  "(|\s*|)"
syn match satysfiProgConstructor  "\[\s*\]"

" The string literal patterns must be defined after satysfiProgOperator in
" order to prevent '#' right before string literal from greedily detected as
" an operator.
syn region satysfiStrLiteral start="\#\?`" end="`\#\?"
syn region satysfiStrLiteral start="\#\?``" end="``\#\?"
syn region satysfiStrLiteral start="\#\?```" end="```\#\?"
syn region satysfiStrLiteral start="\#\?````" end="````\#\?"
syn region satysfiStrLiteral start="\#\?`````" end="`````\#\?"
syn region satysfiStrLiteral start="\#\?``````" end="``````\#\?"
syn region satysfiStrLiteral start="\#\?```````" end="```````\#\?"
syn region satysfiStrLiteral start="\#\?````````" end="````````\#\?"
syn region satysfiStrLiteral start="\#\?`````````" end="`````````\#\?"
syn region satysfiStrLiteral start="\#\?``````````" end="``````````\#\?"
syn region satysfiStrLiteral start="\#\?```````````" end="```````````\#\?"
syn region satysfiStrLiteralWithPos start="@\?`" end="`\#\?"
syn region satysfiStrLiteralWithPos start="@\?``" end="``\#\?"
syn region satysfiStrLiteralWithPos start="@\?```" end="```\#\?"
syn region satysfiStrLiteralWithPos start="@\?````" end="````\#\?"
syn region satysfiStrLiteralWithPos start="@\?`````" end="`````\#\?"
syn region satysfiStrLiteralWithPos start="@\?``````" end="``````\#\?"
syn region satysfiStrLiteralWithPos start="@\?```````" end="```````\#\?"
syn region satysfiStrLiteralWithPos start="@\?````````" end="````````\#\?"
syn region satysfiStrLiteralWithPos start="@\?`````````" end="`````````\#\?"
syn region satysfiStrLiteralWithPos start="@\?``````````" end="``````````\#\?"
syn region satysfiStrLiteralWithPos start="@\?```````````" end="```````````\#\?"


" Vertical mode
syn cluster satysfiVert contains=satysfiComment,satysfiVertError,satysfiVertCommand,satysfiVertCommandSection,satysfiVertCommandKnown
syn cluster satysfiVertActv contains=satysfiCommentVertActv,satysfiVertActvError,satysfiVertArgControl,satysfiProgFromVert,satysfiVertEncl,satysfiHorzFromVert,satysfiVertSemicolon
syn cluster satysfiVertActv2 contains=satysfiCommentVertActv2,satysfiVertActv2Error,satysfiVertEncl,satysfiHorzFromVert

" Unexpected symbols
syn match satysfiVertError "[^ \t\r\n%#+>]" contained
syn match satysfiVertActvError "[^ \t\r\n?%([{<;]" contained nextgroup=@satysfiVertActv skipwhite skipempty
syn match satysfiVertActv2Error "[([]" contained nextgroup=@satysfiVertActv2 skipwhite skipempty
" # and + must be followed by alpha
syn match satysfiVertError "[+#][^a-zA-Z]\@=" contained
" Special error for command names
syn match satysfiVertError "\\\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained
syn match satysfiVertActvError "[+#\\]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained nextgroup=@satysfiVertActv skipwhite skipempty

syn match satysfiVertCommand "[+#]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained nextgroup=@satysfiVertActv skipwhite skipempty
syn match satysfiVertCommandSection "\%(+section\|+subsection\)\>" contained nextgroup=@satysfiVertActv skipwhite skipempty
syn match satysfiVertCommandKnown "+\%(code\|console\|p\|pn\|listing\|math\)\>" contained nextgroup=@satysfiVertActv skipwhite skipempty

syn match satysfiVertArgControl "?:" contained nextgroup=@satysfiVertActv skipwhite skipempty
syn match satysfiVertArgControl "?\*" contained nextgroup=@satysfiVertActv skipwhite skipempty

syn region satysfiProgFromVert contained matchgroup=satysfiVertKeyword start="(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg nextgroup=@satysfiVertActv skipwhite skipempty
syn region satysfiProgFromVert contained matchgroup=satysfiVertKeyword start="(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg nextgroup=@satysfiVertActv skipwhite skipempty
syn region satysfiProgFromVert contained matchgroup=satysfiVertKeyword start="\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg nextgroup=@satysfiVertActv skipwhite skipempty
syn region satysfiVertEncl contained matchgroup=satysfiVertKeyword start="<" matchgroup=satysfiVertKeyword end=">" contains=@satysfiVert nextgroup=@satysfiVertActv2 skipwhite skipempty fold
syn region satysfiHorzFromVert contained matchgroup=satysfiVertKeyword start="{" matchgroup=satysfiHorzKeyword end="}" contains=@satysfiHorz nextgroup=@satysfiVertActv2 skipwhite skipempty
syn match satysfiVertSemicolon ";" contained



" Horizontal mode
syn cluster satysfiHorz contains=satysfiComment,satysfiStrLiteral,satysfiHorzError,satysfiHorzCommand,satysfiHorzCommandSection,satysfiHorzCommandKnown,satysfiHorzOperator,satysfiHorzEscape,satysfiMathListFromHorz,satysfiMathFromHorz,@Spell
syn cluster satysfiHorzActv contains=satysfiCommentHorzActv,satysfiHorzActvError,satysfiHorzArgControl,satysfiProgFromHorz,satysfiVertFromHorz,satysfiHorzEncl,satysfiHorzSemicolon
syn cluster satysfiHorzActv2 contains=satysfiCommentHorzActv2,satysfiHorzActv2Error,satysfiVertFromHorz,satysfiHorzEncl

" Unexpected symbols
syn match satysfiHorzError "[@;{<]" contained
syn match satysfiHorzActv2Error "[@;]" contained nextgroup=@satysfiHorzActv2 skipwhite skipempty
" # and + must be followed by alpha
syn match satysfiHorzError "[\\#][^a-zA-Z]\@=" contained
" $ must be followed by {
syn match satysfiHorzError "\$[^{]\@=" contained
" Special error for command names
syn match satysfiHorzError "+\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained

syn match satysfiHorzCommand "[\\#]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained nextgroup=@satysfiHorzActv skipwhite skipempty
syn match satysfiHorzCommandKnown "\\\%(LaTeX\|SATySFi\|TeX\|figure\|fil\|fil-both\|math\|ref\|ref-page\|tabular\)\>" contained nextgroup=@satysfiHorzActv skipwhite skipempty
syn match satysfiHorzCommandStyle "\\\%(emph\)\>" contained nextgroup=@satysfiHorzActv skipwhite skipempty
syn match satysfiHorzEscape "\\[ -@[-`{-~]" contained
" Typical error
syn match satysfiHorzError "[\\#]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*\s*}" contained

syn match satysfiHorzOperator "|" contained
syn match satysfiHorzOperator "\*\+" contained

syn match satysfiHorzArgControl "?:" contained nextgroup=@satysfiHorzActv skipwhite skipempty
syn match satysfiHorzArgControl "?\*" contained nextgroup=@satysfiHorzActv skipwhite skipempty

syn region satysfiProgFromHorz contained matchgroup=satysfiHorzKeyword start="(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg nextgroup=@satysfiHorzActv skipwhite skipempty
syn region satysfiProgFromHorz contained matchgroup=satysfiHorzKeyword start="(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg nextgroup=@satysfiHorzActv skipwhite skipempty
syn region satysfiProgFromHorz contained matchgroup=satysfiHorzKeyword start="\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg nextgroup=@satysfiHorzActv skipwhite skipempty
syn region satysfiVertFromHorz contained matchgroup=satysfiHorzKeyword start="<" matchgroup=satysfiVertKeyword end=">" contains=@satysfiVert nextgroup=@satysfiHorzActv2 skipwhite skipempty
syn region satysfiHorzEncl contained matchgroup=satysfiHorzKeyword start="{" matchgroup=satysfiHorzKeyword end="}" contains=@satysfiHorz nextgroup=@satysfiHorzActv2 skipwhite skipempty
syn region satysfiMathFromHorz contained matchgroup=satysfiHorzKeyword start="\${" matchgroup=satysfiMathKeyword end="}" contains=@satysfiMathWithoutSep
syn region satysfiMathListFromHorz contained matchgroup=satysfiHorzKeyword start="\${|[ \t\n\r]*" matchgroup=satysfiMathKeyword end="|[ \t\n\r]*}" contains=@satysfiMathWithSep
syn match satysfiMathListFromHorz "\${[ \t\n\r]*|[ \t\n\r]*}" contained
syn match satysfiHorzSemicolon ";" contained

" Errors in HorzActv have to have higher precedence.
syn match satysfiHorzActvError "[^ \t\r\n?%([{<;]" contained
syn match satysfiHorzActvError "?[^:*]\@=" contained
syn match satysfiHorzActvError "[+#\\]\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained nextgroup=@satysfiHorzActv skipwhite skipempty



" Math mode
syn cluster satysfiMathBase contains=satysfiComment,satysfiMathSubscript,satysfiMathSupscript,satysfiMathOperator,satysfiMathIdentifier,satysfiMathHashVariable,satysfiMathCommand,satysfiMathCommandKnown,satysfiMathEscape,@satysfiStrayMathArg
syn cluster satysfiMathWithoutSep contains=@satysfiMathBase,satysfiMathError
syn cluster satysfiMathWithSep    contains=@satysfiMathBase,satysfiMathErrorExceptVBar,satysfiMathListSep

syn match satysfiMathListSep "|" contained

" Unexpected symbols
syn match satysfiMathError "[][|()"#$&;@]" contained
syn match satysfiMathErrorExceptVBar "[][()"#$&;@]" contained
" ! must be followed by [{<([]
syn match satysfiMathError "![^{<([]\@=" contained
syn match satysfiMathErrorExceptVBar "![^{<([]\@=" contained

syn match satysfiMathSupscript "\^" contained nextgroup=satysfiMathEncl skipwhite skipempty
syn match satysfiMathSubscript "_" contained nextgroup=satysfiMathEncl skipwhite skipempty
syn match satysfiMathOperator "[-+*/:=<>~'.,?`]\+" contained
syn match satysfiMathIdentifier "[a-zA-Z0-9]" contained
syn match satysfiMathHashVariable "#\%([A-Z][-a-zA-Z0-9]*\.\)*[a-zA-Z][-a-zA-Z0-9]*" contained
syn match satysfiMathEscape "\\[ -@[-`{-~]" contained

syn match satysfiMathCommand "\\[a-zA-Z][-a-zA-Z0-9]*" contained nextgroup=@satysfiMathArg skipwhite skipempty
syn match satysfiMathCommandKnown "\\\%(Gamma\|angle\|app\|brace\|derive\|frac\|infty\|int\|lambda\|ldots\|lim\|lower\|math-color\|math-skip\|mathbin\|mathord\|mathrel\|ordd\|paren\|pi\|pm\|sqrt\|sum\|tau\|to\|upper\)\>" contained nextgroup=@satysfiMathArg skipwhite skipempty
syn match satysfiMathCommandStyle "\\\%(bm\|math-style\|mathrm\|text\)\>" contained nextgroup=@satysfiMathArg skipwhite skipempty

" Braces and other argument patterns in math region
" 0. Argument controls
syn match satysfiMathOptArg   "?:"  contained nextgroup=@satysfiMathArg,satysfiMathAnythingElse skipwhite skipempty
syn match satysfiMathNoOptArg "?\*" contained nextgroup=@satysfiMathArg skipwhite skipempty
syn match satysfiMathAnythingElse "[^ \t\n\r]" contained
" 1. Proper arguments
syn cluster satysfiMathArg contains=satysfiProgFromMath,satysfiVertFromMath,satysfiHorzFromMath,satysfiMathEncl,satysfiMathListEncl,satysfiMathOptArg,satysfiMathNoOptArg
syn region  satysfiProgFromMath contained transparent matchgroup=satysfiMathKeyword start="!(" matchgroup=satysfiProgKeyword end=")" contains=@satysfiProg nextgroup=@satysfiMathArg skipwhite skipempty
syn region  satysfiProgFromMath contained transparent matchgroup=satysfiMathKeyword start="!(|" matchgroup=satysfiProgKeyword end="|)"  contains=@satysfiProg nextgroup=@satysfiMathArg skipwhite skipempty
syn region  satysfiProgFromMath contained transparent matchgroup=satysfiMathKeyword start="!\[" matchgroup=satysfiProgKeyword end="\]" contains=@satysfiProg nextgroup=@satysfiMathArg skipwhite skipempty
syn region  satysfiVertFromMath contained matchgroup=satysfiMathKeyword start="!<" matchgroup=satysfiVertKeyword end=">" contains=@satysfiVert nextgroup=@satysfiMathArg skipwhite skipempty
syn region  satysfiHorzFromMath contained matchgroup=satysfiMathKeyword start="!{" matchgroup=satysfiHorzKeyword end="}" contains=@satysfiHorz nextgroup=@satysfiMathArg skipwhite skipempty
syn region  satysfiMathEncl contained matchgroup=satysfiMathKeyword start="{" matchgroup=satysfiMathKeyword end="}" contains=@satysfiMathWithoutSep nextgroup=@satysfiMathArg skipwhite skipempty
syn region  satysfiMathListEncl contained matchgroup=satysfiMathKeyword start="{[ \t\n\r]*|" matchgroup=satysfiMathKeyword end="|[ \t\n\r]*}" contains=@satysfiMathWithSep nextgroup=@satysfiMathArg skipwhite skipempty
syn match   satysfiMathListEncl contained "{[ \t\n\r]*|[ \t\n\r]*}" nextgroup=@satysfiMathArg skipwhite skipempty
" 2. Inproper (stray) arguments (the patterns are identical to 1.)
syn cluster satysfiStrayMathArg contains=satysfiStrayProgFromMath,satysfiStrayVertFromMath,satysfiStrayHorzFromMath,satysfiStrayMathEncl,satysfiStrayMathListEncl
syn region  satysfiStrayProgFromMath contained transparent matchgroup=satysfiMathError start="!(" matchgroup=satysfiMathError end=")" contains=@satysfiProg
syn region  satysfiStrayProgFromMath contained transparent matchgroup=satysfiMathError start="!(|" matchgroup=satysfiMathError end="|)"  contains=@satysfiProg
syn region  satysfiStrayProgFromMath contained transparent matchgroup=satysfiMathError start="!\[" matchgroup=satysfiMathError end="\]" contains=@satysfiProg
syn region  satysfiStrayVertFromMath contained matchgroup=satysfiMathError start="!<" matchgroup=satysfiMathError end=">" contains=@satysfiVert
syn region  satysfiStrayHorzFromMath contained matchgroup=satysfiMathError start="!{" matchgroup=satysfiMathError end="}" contains=@satysfiHorz
syn region  satysfiStrayMathEncl contained matchgroup=satysfiMathError start="{" matchgroup=satysfiMathError end="}" contains=@satysfiMathWithoutSep
syn region  satysfiStrayMathListEncl contained matchgroup=satysfiMathError start="{[ \t\n\r]*|" matchgroup=satysfiMathError end="|[ \t\n\r]*}" contains=@satysfiMathWithSep
syn match   satysfiStrayMathListEncl contained "{[ \t\n\r]*|[ \t\n\r]*}"


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

hi def link satysfiMathListSep satysfiMathKeyword

hi def link satysfiCommentVertActv satysfiComment
hi def link satysfiCommentVertActv2 satysfiComment
hi def link satysfiCommentHorzActv satysfiComment
hi def link satysfiCommentHorzActv2 satysfiComment

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
hi def link satysfiProgStage satysfiStage
hi def link satysfiProgInvalidStage satysfiProgError
hi def link satysfiMathListFromProg satysfiProgKeyword
hi def link satysfiStrLiteral satysfiLiteral
hi def link satysfiStrLiteralWithPos satysfiLiteral

hi def link satysfiVertError satysfiError
hi def link satysfiVertActvError satysfiError
hi def link satysfiVertActv2Error satysfiError
hi def link satysfiVertArgControl satysfiArgControl
hi def link satysfiVertKeyword satysfiKeyword
hi def link satysfiVertCommand satysfiCommand
hi def link satysfiVertCommandKnown satysfiCommandKnown
hi def link satysfiVertCommandSection satysfiCommandSection
hi def link satysfiVertSemicolon satysfiKeyword

hi def link satysfiHorzError satysfiError
hi def link satysfiHorzActvError satysfiError
hi def link satysfiHorzArgControl satysfiArgControl
hi def link satysfiHorzKeyword satysfiKeyword
hi def link satysfiHorzOperator satysfiOperator
hi def link satysfiHorzCommand satysfiCommand
hi def link satysfiHorzCommandKnown satysfiCommandKnown
hi def link satysfiHorzCommandStyle satysfiCommandStyle
hi def link satysfiHorzSemicolon satysfiKeyword
hi def link satysfiHorzEscape satysfiEscape

hi def link satysfiMathError satysfiError
hi def link satysfiMathErrorExceptVBar satysfiError
hi def link satysfiMathKeyword satysfiKeyword
hi def link satysfiMathSupscript satysfiKeyword
hi def link satysfiMathSubscript satysfiKeyword
hi def link satysfiMathOperator satysfiOperator
hi def link satysfiMathHashVariable satysfiHashVariable
hi def link satysfiMathCommand satysfiCommand
hi def link satysfiMathCommandKnown satysfiCommandKnown
hi def link satysfiMathCommandStyle satysfiCommandStyle
hi def link satysfiMathEscape satysfiEscape
hi def link satysfiMathListEncl satysfiMathKeyword
hi def link satysfiStrayMathListEncl satysfiMathError
hi def link satysfiMathOptArg satysfiArgControl
hi def link satysfiMathNoOptArg satysfiArgControl
hi def link satysfiMathAnythingElse satysfiMathError

" Now we can link them with predefined groups.
hi def link satysfiError Error
hi def link satysfiStage Special
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
