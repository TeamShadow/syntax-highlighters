" Vim syntax file
" Language:	Shadow
" Maintainer:	Barry Wittman
" URL:		http://www.shadow-language.org
" Last Change:	2017 July 31

" Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  " we define it here so that included files can test for it
  let main_syntax='shadow'
  syn region shadowFold start="{" end="}" transparent fold
endif

let s:cpo_save = &cpo
set cpo&vim

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ ShadowHiLink hi link <args>
else
  command! -nargs=+ ShadowHiLink hi def link <args>
endif

" some characters that cannot be in a Shadow program (outside a string)
syn match shadowError "[\\`]"
syn match shadowError "\.\.\|||=\|&&=\|\*\/"

" keyword definitions
syn keyword shadowExternal	import
syn keyword shadowKeyword	abstract and assert break case cast catch check class constant continue copy create default destroy do else enum exception extern finally for foreach freeze get if immutable import in interface is locked native nullable or private protected public readonly recover return send set singleton skip spawn super switch this throw try weak while xor
syn keyword shadowBoolean	false true
syn keyword shadowConstant	null
syn keyword shadowType		boolean byte code double float int long short ubyte uint ulong ushort var

" The following cluster contains all shadow groups except the contained ones
syn cluster shadowTop add=shadowExternal,shadowError,shadowKeyword,shadowBoolean,shadowConstant,shadowType


" Comments
syn region  shadowComment	 start="/\*"  end="\*/"
syn match   shadowCommentStar	 contained "^\s*\*[^/]"me=e-1
syn match   shadowCommentStar	 contained "^\s*\*$"
syn match   shadowLineComment	 "//.*"

syn cluster shadowTop add=shadowComment,shadowLineComment

" match the special comment /**/
syn match   shadowComment 	"/\*\*/"

" Strings and constants
syn match   shadowSpecialError	 contained "\\."
syn match   shadowSpecialCharError contained "[^']"
syn match   shadowSpecialChar	 contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn region  shadowString	 start=+"+ end=+"+ end=+$+ contains=shadowSpecialChar,shadowSpecialError
syn match   shadowCharacter	 "'[^']*'" contains=shadowSpecialChar,shadowSpecialCharError
syn match   shadowCharacter	 "'\\''" contains=shadowSpecialChar
syn match   shadowCharacter	 "'[^\\]'"
syn match   shadowNumber	 "\<\(0[bB][0-1]\+\|0[cC][0-7]\+\|0[xX]\x\+\|\d\+\)[uU][yYsSiIlL]\=\>"
syn match   shadowNumber	 "\(\<\d\(\d\|_\d\)*\.\(\d\(\d\|_\d\)*\)\=\|\.\d\(\d\|_\d\)*\)\([eE][-+]\=\d\(\d\|_\d\)*\)\=[fFdD]\="
syn match   shadowNumber	 "\<\d\(\d\|_\d\)*[eE][-+]\=\d\(\d\|_\d\)*[fFdD]\=\>"
syn match   shadowNumber	 "\<\d\(\d\|_\d\)*\([eE][-+]\=\d\(\d\|_\d\)*\)\=[fFdD]\>"

" unicode characters
syn match   shadowSpecial "\\u\d\{4\}"

syn cluster shadowTop add=shadowString,shadowCharacter,shadowNumber,shadowSpecial

" The default highlighting.
if version >= 508 || !exists("did_shadow_syn_inits")
  if version < 508
    let did_shadow_syn_inits = 1
  endif

  ShadowHiLink shadowKeyword		Statement
  ShadowHiLink shadowBoolean		Boolean
  ShadowHiLink shadowConstant		Constant
  ShadowHiLink shadowSpecial		Special
  ShadowHiLink shadowSpecialError	Error
  ShadowHiLink shadowSpecialCharError	Error
  ShadowHiLink shadowString		String
  ShadowHiLink shadowCharacter		Character
  ShadowHiLink shadowSpecialChar	SpecialChar
  ShadowHiLink shadowNumber		Number
  ShadowHiLink shadowError		Error
  ShadowHiLink shadowComment		Comment
  ShadowHiLink shadowLineComment	Comment
  
  ShadowHiLink shadowCommentStar	shadowComment

  ShadowHiLink shadowType		Type
  ShadowHiLink shadowExternal		Include
endif

delcommand ShadowHiLink

let b:current_syntax = "shadow"

if main_syntax == 'shadow'
  unlet main_syntax
endif

let b:spell_options="contained"
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
