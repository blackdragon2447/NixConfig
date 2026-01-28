" Vim syntax file
" Language: Aris16 assembly 
" SPDX-License-Identifier: AGPL-3.0

" recognized (and respected) options:
"
" - c_no_comment_fold, aris16_comment_fold, aris16_no_comment_fold
" - c_no_utf, aris16_utf, aris16_no_utf
" - aris16_no_hi_link_through_c
" - aris16_no_mess_with_indent
" - aris16_no_adaptive_groups
"
" all options "inhereted" from c are overrided by aris16 ones
" furthermore no_% takes presidence over %

syn clear

syn match   aris16Terminator        ";"
syn match   aris16Operator          /[+\-#€()]/

syn match   aris16LNameShortError   /[a-zA-Z_?!%@$][a-zA-Z_?!%@$0-9-]\{,2}/

syn match   aris16OpcodeError       /\(\(\s\|\n\|;\)[+\-_=pP{}[\]0)]\{,2}\)\@<=[A-Za-z0-9]\{3}\(\([!-:<-@[-`{-~\]]\{,2}\)\(\s\|\n\|;\|\%$\)\)\@=/
syn match   aris16FlagError         /\(\n\s*\|;\s*\)\@<=[+\-_=pP{}\[\]0)]\{1,2}\(\s*\([A-Za-z0-7]\{3}\([!-:<-@[-`{-~\]]\{,2}\)\(\s\|\n\|;\%$\)\)\)\@=/

syn match   aris16Variant           /\(\(\(\s\|\n\|;\)[+\-_=pP{}[\]0)]\{,2}\)[A-Za-z0-9]\{3}\)\@<=[!-:<-@[-`{-~\]]\{1,2}/

syn match   aris16ShortLName         /[_?%@$]/
syn match   aris16LName             /\<[a-zA-Z_?!%@$][a-zA-Z_?!%@$0-9-]\{3,}[\n\t +(:-]\@=\|\([\n\s+-]\@<=\|^\)[_?!%@$][a-zA-Z_?!%@$0-9-]\+[\n\t +(:-]\@=/
syn match   aris16MacroName         /[\n\t\s+-]\@<=\%([A-Z_?!%@$][A-Z_?!%@$0-9-]\{3,}\&[_?!%@$0-9-]*[A-Z][A-Z_?!%@$0-9-]*\)[\n\t\s+(-]\@=/

syn match   aris16Opcode            /\c\(\s\|\n\|[+\-_=pP{}[\]0)]\)\@<=\(MOV\|ADD\|MUL\|AND\|SHF\|FOP\|FEX\|U07\|SWP\|BRC\|FLG\|CLL\|MBL\|SMV\|U16\|HLT\)\(\([!-:<-@[-`{-~\]]\{,2}\)\(\s\|\n\|;\|\%$\)\)\@=/
syn match   aris16UASOpcode         /\c\(\s\|\n\|[+\-_=pP{}[\]0)]\)\@<=U[0-7]\{2}\(\([!-:<-@[-`{-~\]]\{,2}\)\(\s\|\n\|;\|\%\$\)\)\@=/

syn match   aris16Flag              /\(\n\|;\|\s\)\@<=[+-]\{1,2}\(\s*\([A-Za-z0-7]\{3}\)\@=\)/


syn keyword aris16RegName           NIL A1 A2 A3 A4 A5 A6 A7
syn keyword aris16RegName           nil a1 a2 a3 a4 a5 a6 a7 niL nIl Nil nIL NiL NIl

syn match   aris16RegNameError      /\<[aA][089]\>/

" note: neither + nor - count as word boundries (\<)
syn match   aris16Hex               /[+-]\?\<0\?[xX][0-9A-Fa-f]\+\>/
syn match   aris16Oct               /[+-]\?\<0\?[oO][0-7]\+\>/
syn match   aris16Bin               /[+-]\?\<0\?[bB][01]\+\>/
syn match   aris16Dec               /[+-]\?\<[0-9]\+\>/
syn match   aris16Char              /'\(\([^\\]\|\\[abtnvfr'\\]\|\\[0-7]\{1,3}\|\\x[0-9a-fA-F]\{2}\)\{1,2}\|\\u[0-9A-Fa-f]\{4}\)'/ contains=aris16Special

" stolen from c.vim :3
syn region  aris16CommentL start="//" skip="\\$" end="$" keepend contains=@Spell
if (exists("c_no_comment_fold") && !exists("aris16_comment_fold")) || exists("aris16_no_comment_fold")
	syn region  aris16Comment matchgroup=aris16CommentStart start="/\*" end="\*/" contains=aris16CommentStartError,@Spell extend
else
	syn region  aris16Comment matchgroup=aris16CommentStart start="/\*" end="\*/" contains=aris16CommentStartError,@Spell fold extend
endif

syn match   aris16Special         display contained "\\\%(x\x\{2}\|\o\{1,3}\|.\|$\)"
if (!exists("c_no_utf") || exists("aris16_utf")) && !exists("aris16_no_utf")
	syn match   aris16Special display contained "\\\%(u\x\{4}\)"
endif

" keep a // comment separately, it terminates a preproc. conditional
syn match   aris16CommentError      display "\*/"
syn match   aris16CommentStartError display "/\*"me=e-1 contained
syn region  aris16Included          display contained start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
syn match   aris16Included          display contained "<[^>\n]*>"
syn match   aris16Include           display "^\s*\zs\%(%:\|#\)\s*include\>\s*["<]" contains=aris16Included
" to override LName
syn match   aris16PreProcName       contained /\(^\s*\zs\%(%:\|#\)\s*\)\@<=[a-zA-Z]\+\>/
syn region  aris16Define            start="^\s*\zs\%(%:\|#\)\s*\%(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@Spell
syn region  aris16PreProc           start="^\s*\zs\%(%:\|#\)\s*\%(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend contains=ALLBUT,@Spell

" these have been modified to accept a +/-, not accept a length indicator and
" work anywere cause I cant be bothered to actually write structure
" — lily
"floating point number, with dot, optional exponent
syn match   aris16Float             display "[+-]\?\d\+\.\d*\%(e[-+]\=\d\+\)\="
"floating point number, starting with a dot, optional exponent
syn match   aris16Float             display "[+-]\?\.\d\+\%(e[-+]\=\d\+\)\=\>"
"floating point number, without dot, with exponent
syn match   aris16Float             display "[+-]\?\d\+e[-+]\=\d\+\>"
" end stolen from c.vim :3

hi def link aris16Terminator        Operator
hi def link aris16Operator          Operator
hi def link aris16Variant           Special

hi def link aris16Opcode            Statement
hi def link aris16UASOpcode         aris16Opcode
hi def link aris16OpcodeError       Error
hi def link aris16Flag              Conditional
hi def link aris16FlagError         Error

hi def link aris16RegName           Constant
hi def link aris16RegNameError      Error

hi def link aris16LName             Function
if !exists("aris16_no_adaptive_groups")
	" based on my (lily) prior work on valgrind.vim
	let lnamesyn = hlID("aris16LName")->synIDtrans()  " woaw
	let lname_cterm = []
	let traits = ["bold","italic","reverse","inverse","standout","underline","undercurl","underdouble","underdotted","underdashed","strikethrough","altfont","nocombine"]
	for i in traits
		if lnamesyn->synIDattr(i,"cterm") || i == "bold" || i == "italic"
			let lname_cterm += [i]
		endif
	endfor

	let lname_gui = []
	for i in traits
		if lnamesyn->synIDattr(i,"gui") || i == "bold" || i == "italic"
			let lname_gui += [i]
		endif
	endfor
	execute printf("hi def aris16ShortLName %s %s %s %s %s",
		\ !empty(lname_cterm) ? "cterm="..lname_cterm->join(",") : "",
		\ !empty(lname_gui) ? "gui="..lname_gui->join(",") : "",
		\ !empty(lnamesyn->synIDattr("fg","cterm")) ? "ctermfg="..lnamesyn->synIDattr("fg","cterm") : "",
		\ !empty(lnamesyn->synIDattr("fg","gui")) ? "guifg="..lnamesyn->synIDattr("fg","gui") : "",
		\ !empty(lnamesyn->synIDattr("fg","gui")) ? "guisp="..lnamesyn->synIDattr("fg","gui") : ""
		\ )
	let macrosyn = hlID("Macro")->synIDtrans()  " woaw
	let macro_cterm = []
	for i in traits
		if macrosyn->synIDattr(i,"cterm") || i == "italic" || i == "bold"
			let macro_cterm += [i]
		endif
	endfor

	let macro_gui = []
	for i in traits
		if macrosyn->synIDattr(i,"gui") || i == "italic" || i == "bold"
			let macro_gui += [i]
		endif
	endfor
	execute printf("hi def aris16MacroName %s %s %s %s %s",
		\ !empty(macro_cterm) ? "cterm="..macro_cterm->join(",") : "",
		\ !empty(macro_gui) ? "gui="..macro_gui->join(",") : "",
		\ !empty(macrosyn->synIDattr("fg","cterm")) ? "ctermfg="..macrosyn->synIDattr("fg","cterm") : "",
		\ !empty(macrosyn->synIDattr("fg","gui")) ? "guifg="..macrosyn->synIDattr("fg","gui") : "",
		\ !empty(macrosyn->synIDattr("fg","gui")) ? "guisp="..macrosyn->synIDattr("fg","gui") : ""
		\ )
else
	hi def link aris16ShortLName aris16LName
	hi def link aris16MacroName Macro
endif
hi def link aris16LNameShortError   Error

hi def link aris16Hex               Number
hi def link aris16Oct               Number
hi def link aris16Bin               Number
hi def link aris16Dec               Number
hi def link aris16Char              Character

if !exists("aris16_no_hi_link_through_c")
	" link these through c variants in case the user defines their own c highlighting
	
	" in case the user defines aris16Comment, default to that for other
	" comment groups rather than c groups
	if hlexists("aris16Comment")
		hi def link aris16CommentL          aris16Comment
		hi def link aris16CommentStart      aris16Comment
		hi def link aris16CommentError      aris16Comment
		hi def link aris16CommentStartError aris16Comment
	else
		hi def link aris16CommentL          cCommentL
		hi def link aris16CommentStart      cCommentStart
		hi def link aris16CommentError      cCommentError
		hi def link aris16CommentStartError cCommentStartError
	endif

	hi def link aris16Comment           cComment
	hi def link aris16Included          cIncluded
	hi def link aris16Include           cInclude
	hi def link aris16PreProcName       cPreProc
	hi def link aris16Define            cDefine
	hi def link aris16PreProc           cPreProc
	hi def link aris16Float             cFloat
	hi def link aris16Special           cSpecial

	hi def link cCommentL               cComment
	hi def link cComment                Comment
	hi def link cCommentError           cError
	hi def link cCommentStartError      cError
	hi def link cError                  Error
	hi def link cIncluded               cString
	hi def link cString                 String
	hi def link cInclude                Include
	hi def link cDefine                 Define
	hi def link cPreProc                PreProc
	hi def link cFloat                  Float
	hi def link cSpecial                Special
else
	hi def link aris16CommentL          aris16Comment
	hi def link aris16CommentStart      aris16Comment
	hi def link aris16CommentError      aris16Comment
	hi def link aris16CommentStartError aris16Comment

	hi def link aris16Comment           Comment
	hi def link aris16Included          String
	hi def link aris16Include           Include
	hi def link aris16PreProcName       PreProc
	hi def link aris16Define            Define
	hi def link aris16PreProc           PreProc
	hi def link aris16Float             Float
	hi def link aris16Special           Special

endif

if !exists("aris16_no_mess_with_indent")
	set vts=2,6,8 lcs+=lead\:+,leadmultispace\:+-\ \ \ 
endif
