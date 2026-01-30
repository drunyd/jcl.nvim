" syntax/jcl.vim
" Vim syntax file
" Language:  MVS JCL (jcl)
" Maintainer:  Fiorenzo Zanotti
" Last Change: 2002 Sep 22
" Ported to Neovim plugin form (2026) with minor fixes.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword jclKwd pgm proc class dsn[ame] msgclass space disp contained
syn keyword jclKwd parm member cond msglevel order lrecl recfm unit contained
syn keyword jclKwd sysout outlim blksize region dcb amp contained
syn keyword jclKwd then shr old new mod catlg rlse delete pass keep contained
syn keyword jclKwd cyl trk vol retain ser label recorg sysda contained
syn keyword jclKwd dummy contained

syn keyword jclCKwd pgm proc class dsn[ame] msgclass space disp contained
syn keyword jclCKwd parm member cond msglevel order lrecl recfm unit contained
syn keyword jclCKwd sysout outlim blksize region dcb amp contained
syn keyword jclCKwd then shr old new mod catlg rlse delete pass keep contained
syn keyword jclCKwd cyl trk vol retain ser label recorg sysda contained
syn keyword jclCKwd dummy contained

syn keyword jclPgm idcams iebcopy sort icegener adrdssu ftp rexec contained
syn keyword jclPgm iebgener iefbr14 contained
syn keyword jclCPgm idcams iebcopy sort icegener adrdssu ftp rexec contained
syn keyword jclCPgm iebgener iefbr14 contained

"
" Matches main command and special dd
"
syn match jclMainCommand +^//[^* ]*\s\+EXEC+hs=e-3 contained
syn match jclMainCommand +^//[^* ]*\s\+DD+hs=e-1 contained
syn match jclMainCommand +^//[^* ]*\s\+INCLUDE+hs=e-6 contained
syn match jclMainCommand +^//[^* ]*\s\+JCLLIB+hs=e-5 contained
syn match jclMainCommand +^//[^* ]*\s\+JOB+hs=e-2 contained
syn match jclMainCommand +^//[^* ]*\s\+SET+hs=e-2 contained

syn match jclCMainCommand +^//[^* ]*\s\+EXEC+hs=e-3 contained
syn match jclCMainCommand +^//[^* ]*\s\+DD+hs=e-1 contained
syn match jclCMainCommand +^//[^* ]*\s\+INCLUDE+hs=e-6 contained
syn match jclCMainCommand +^//[^* ]*\s\+JCLLIB+hs=e-5 contained
syn match jclCMainCommand +^//[^* ]*\s\+JOB+hs=e-2 contained
syn match jclCMainCommand +^//[^* ]*\s\+SET+hs=e-2 contained

syn match jclCond +^//[^* ]*\s\+ELSE+ contained
syn match jclOperator "[()]" contained
syn match jclCOperator +[()]+ contained

syn match jclNumber +\<\d\+\>+ contained
syn match jclCNumber +\<\d\+\>+ contained

syn match jclDsn +\(\(\w\{1,8}\.\)\+\w\{1,8}\((\w\{1,8})\)\?\|\(&&\w\{1,8}\)\)+ contained
syn match jclCDsn +\(\(\w\{1,8}\.\)\+\w\{1,8}\((\w\{1,8})\)\?\|\(&&\w\{1,8}\)\)+ contained

syn region jclDblQuote  start=+"+ skip=+[^"]+ end=+"+ contained
syn region jclSnglQuote start=+'+ skip=+[^']+ end=+'+ contained
syn region jclCDblQuote start=+"+ skip=+[^"]+ end=+"+ contained
syn region jclCSnglQuote start=+'+ skip=+[^']+ end=+'+ contained

syn cluster jclConditional contains=jclCMainCommand,jclCIF,jclCData,jclCKwd,jclCond,jclCDblQuote,jclCSnglQuote,jclCComment,jclCOperator,jclCDsn,jclCPgm,jclCNumber

syn region jclIF  matchgroup=jclCond start=+^//\w*\s\+IF+ end=+^//\w*\s\+ENDIF+ contains=@jclConditional contained
syn region jclCIF matchgroup=jclCond start=+^//\w*\s\+IF+ end=+^//\w*\s\+ENDIF+ contains=@jclConditional contained

syn match jclCComment +^//\*.*$+ contained

" NOTE: fixed 'jclIf' → 'jclIF' below
syn cluster jclNonConditional contains=jclMainCommand,jclKwd,jclIF,jclOperator,jclDblQuote,jclSnglQuote,jclDsn,jclPgm,jclNumber

" High level matches
syn match jclComment   +^//\*.*$+
" syn match jclData    +^[^/].*$+
syn match jclData      +^\([^/]\|/[^*/]\).*$+
syn match jclStatement +^//[^*].*$+ transparent contains=@jclNonConditional
syn match jclCData     +^\([^/]\|/[^*/]\).*$+ contained

" --- Modern JCL Enhancements ---

" JES message codes
syn match jclMsgCode /\<[A-Z][A-Z0-9]\{3,6}[A-Z]\{0,2}\d\{0,4}\>/
hi def link jclMsgCode Identifier

" DD names
syn match jclDDName /^\/\/\zs[A-Z0-9$#@]\{1,8}\ze\s\+/
hi def link jclDDName Type

" Delimiters
syn match jclComma /,/
syn match jclParen /[()]/
hi def link jclComma Delimiter
hi def link jclParen Delimiter

" Additional parameters
syn keyword jclParam TYPRUN NOTIFY RESTART TIME REGION ACCT MERGE LIKE STORCLAS MGMTCLAS DATACLAS COND PARM
hi def link jclParam Statement

" Dataset attributes
syn keyword jclAttr DSORG RECFM BLKSIZE LRECL KEYLEN BUFNO
hi def link jclAttr Identifier

" Hex literals
syn match jclHex /\<[0-9A-F]\{2,8}\>/
hi def link jclHex Number

" Character literals
syn match jclCharLit /'[^']*'/
hi def link jclCharLit String

" PROC names
syn match jclProcName /^\/\/[A-Z0-9$#@]\{1,8}\s\+PROC/
hi def link jclProcName Function

" Symbolics (&HLQ etc.)
syn match jclSymbolic /&[A-Z0-9._$#@]\+/
hi def link jclSymbolic PreProc

" Return codes (STEP.RC)
syn match jclReturnCode /\<[A-Z0-9$#@]\{1,8}\.RC\>/
syn keyword jclReturnCode LASTCC MAXCC
hi def link jclReturnCode Number

" AMP keyword
syn keyword jclAmp AMP
hi def link jclAmp Keyword

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_jcl_syntax_inits")
  if version < 508
    let did_jcl_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " Example GUI highlights from original (commented out)
  " hi Comment guifg=darkgrey
  " hi jclIF guibg=white
  " hi jclCond guibg=grey guifg=darkblue gui=bold
  " hi jclCComm guibg=white guifg=darkred
  " hi jclCComment guibg=white guifg=darkgrey
  " hi jclKwd guifg=brown
  " hi jclCKwd guibg=white guifg=brown
  " hi jclMainCommand guifg=blue
  " hi jclCMainCommand guifg=blue guibg=grey
  " hi jclData guifg=violet
  " hi jclCData guifg=violet guibg=white
  " hi jclOperator guifg=darkred
  " hi jclCOperator guifg=darkred guibg=white
  " hi jclDsn guifg=darkcyan
  " hi jclCDsn guifg=darkcyan guibg=white

  " Standard color links:
  HiLink jclIF          Normal
  HiLink jclCIF         Normal
  HiLink jclCond        WarningMsg
  HiLink jclCComm       Statement
  HiLink jclCComment    Comment
  HiLink jclKwd         Statement
  HiLink jclCKwd        Statement
  HiLink jclMainCommand Type
  HiLink jclCMainCommand WarningMsg
  HiLink jclOperator    Operator
  HiLink jclCOperator   Operator
  HiLink jclDsn         Normal
  HiLink jclCDsn        Normal
  HiLink jclData        Special
  HiLink jclCData       Special
  HiLink jclPgm         Function
  HiLink jclCPgm        Function
  HiLink jclNumber      Number
  HiLink jclCNumber     Number
  HiLink jclDblQuote    jclSnglQuote
  HiLink jclSnglQuote   String
  HiLink jclCDblQuote   jclCSnglQuote
  HiLink jclCSnglQuote  String
  HiLink jclCIF         jclIF
  HiLink jclComment     Comment
  HiLink jclCComment    Comment
  HiLink jclComm        Statement
  HiLink jclLabel       Label

  syn sync fromstart    " synchronize from start
  delcommand HiLink
endif

let b:current_syntax = "jcl"
