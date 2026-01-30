" syntax/jcl.vim
" Modernized Neovim syntax for IBM JCL
" Original: Fiorenzo Zanotti (2002)
" Rewritten & modernized: 2026

" Prevent double-loading
if exists("b:current_syntax")
  finish
endif

" -----------------------------------------------------------
" Core setup
" -----------------------------------------------------------
syn case ignore

" ===========================================================
" BASE KEYWORDS
" ===========================================================
syn keyword jclKwd pgm proc class dsn dsnname msgclass space disp parm member
syn keyword jclKwd cond msglevel order lrecl recfm unit sysout outlim blksize
syn keyword jclKwd region dcb then shr old new mod catlg rlse delete pass keep 
syn keyword jclKwd cyl trk vol retain ser label recorg sysda dummy amp

" Uppercase copy (conditional)
syn keyword jclCKwd pgm proc class dsn dsnname msgclass space disp parm member
syn keyword jclCKwd cond msglevel order lrecl recfm unit sysout outlim blksize
syn keyword jclCKwd region dcb then shr old new mod catlg rlse delete pass keep 
syn keyword jclCKwd cyl trk vol retain ser label recorg sysda dummy amp

" Program names
syn keyword jclPgm idcams iebcopy sort icegener adrdssu ftp rexec iebgener iefbr14
syn keyword jclCPgm idcams iebcopy sort icegener adrdssu ftp rexec iebgener iefbr14

" ===========================================================
" MAIN COMMANDS
" ===========================================================
syn match jclMainCommand /^\/\/[^* ]*\s\+EXEC/    contained
syn match jclMainCommand /^\/\/[^* ]*\s\+DD/      contained
syn match jclMainCommand /^\/\/[^* ]*\s\+INCLUDE/ contained
syn match jclMainCommand /^\/\/[^* ]*\s\+JCLLIB/  contained
syn match jclMainCommand /^\/\/[^* ]*\s\+JOB/     contained
syn match jclMainCommand /^\/\/[^* ]*\s\+SET/     contained

syn match jclCMainCommand /^\/\/[^* ]*\s\+EXEC/    contained
syn match jclCMainCommand /^\/\/[^* ]*\s\+DD/      contained
syn match jclCMainCommand /^\/\/[^* ]*\s\+INCLUDE/ contained
syn match jclCMainCommand /^\/\/[^* ]*\s\+JCLLIB/  contained
syn match jclCMainCommand /^\/\/[^* ]*\s\+JOB/     contained
syn match jclCMainCommand /^\/\/[^* ]*\s\+SET/     contained

" ===========================================================
" BASIC MATCHES
" ===========================================================
syn match jclCond      /^\/\/[^* ]*\s\+ELSE/    contained
syn match jclOperator  /[()]/                   contained
syn match jclCOperator /[()]/                   contained

syn match jclNumber /\<\d\+\>/      contained
syn match jclCNumber /\<\d\+\>/     contained

" Dataset naming (HLQ.HLQ.NAME, &VAR, &&TEMP)
syn match jclDsn   /\(\(\w\{1,8}\.\)\+\w\{1,8}\(\(\w\{1,8}\)\)\?\|\(&&\w\{1,8}\)\)/ contained
syn match jclCDsn  /\(\(\w\{1,8}\.\)\+\w\{1,8}\(\(\w\{1,8}\)\)\?\|\(&&\w\{1,8}\)\)/ contained

" Quoted strings
syn region jclDblQuote  start=+"+ skip=+[^"]+ end=+"+ contained
syn region jclSnglQuote start=+'+ skip=+[^']+ end=+'+ contained
syn region jclCDblQuote start=+"+ skip=+[^"]+ end=+"+ contained
syn region jclCSnglQuote start=+'+ skip=+[^']+ end=+'+ contained

" ===========================================================
" IF / ENDIF REGIONS
" ===========================================================
syn cluster jclConditional contains=jclCMainCommand,jclCIF,jclCData,jclCKwd,jclCond,jclCDblQuote,jclCSnglQuote,jclCComment,jclCOperator,jclCDsn,jclCPgm,jclCNumber

syn region jclIF  matchgroup=jclCond start=+^//\w*\s\+IF+ end=+^//\w*\s\+ENDIF+ contains=@jclConditional contained
syn region jclCIF matchgroup=jclCond start=+^//\w*\s\+IF+ end=+^//\w*\s\+ENDIF+ contains=@jclConditional contained

syn match jclCComment /^\/\/\*.*$/ contained

" ===========================================================
" NON-CONDITIONAL CLUSTER
" ===========================================================
syn cluster jclNonConditional contains=jclMainCommand,jclKwd,jclIF,jclOperator,jclDblQuote,jclSnglQuote,jclDsn,jclPgm,jclNumber

" ===========================================================
" TOP LEVEL MATCHES
" ===========================================================
syn match jclComment   /^\/\/\*.*/
syn match jclData      /^\([^/]\|\/[^*/]\).*/
syn match jclStatement /^\/\/[^*].*/ transparent contains=@jclNonConditional
syn match jclCData     /^\([^/]\|\/[^*/]\).*/ contained

" ===========================================================
" MODERN ENHANCEMENTS
" ===========================================================

" JES / system message codes
syn match jclMsgCode /\<[A-Z][A-Z0-9]\{3,6}[A-Z]\{0,2}\d\{0,4}\>/

" DD names
syn match jclDDName /^\/\/\zs[A-Z0-9$#@]\{1,8}\ze\s\+/

" Delimiters
syn match jclComma /,/
syn match jclParen /[()]/

" Parameters
syn keyword jclParam TYPRUN NOTIFY RESTART TIME REGION ACCT MERGE LIKE STORCLAS MGMTCLAS DATACLAS COND PARM

" Dataset attributes
syn keyword jclAttr DSORG RECFM BLKSIZE LRECL KEYLEN BUFNO

" Hex literals
syn match jclHex /\<[0-9A-F]\{2,8}\>/

" Character literals
syn match jclCharLit /'[^']*'/

" PROC names
syn match jclProcName /^\/\/[A-Z0-9$#@]\{1,8}\s\+PROC/

" Symbolic variables
syn match jclSymbolic /&[A-Z0-9._$#@]\+/

" Return codes
syn match jclReturnCode /\<[A-Z0-9$#@]\{1,8}\.RC\>/
syn keyword jclReturnCode LASTCC MAXCC

" AMP keyword
syn keyword jclAmp AMP

" ===========================================================
" ADD MODERN GROUPS INTO CLUSTERS
" ===========================================================
syn cluster jclNonConditional add=jclMsgCode,jclDDName,jclComma,jclParen,jclParam,jclAttr,jclHex,jclCharLit,jclProcName,jclSymbolic,jclReturnCode,jclAmp
syn cluster jclConditional    add=jclMsgCode,jclDDName,jclComma,jclParen,jclParam,jclAttr,jclHex,jclCharLit,jclProcName,jclSymbolic,jclReturnCode,jclAmp

" ===========================================================
" DEFAULT HIGHLIGHT LINKS
" ===========================================================
hi def link jclIF          Normal
hi def link jclCIF         Normal
hi def link jclCond        WarningMsg
hi def link jclCComment    Comment
hi def link jclKwd         Statement
hi def link jclCKwd        Statement
hi def link jclMainCommand Type
hi def link jclCMainCommand WarningMsg
hi def link jclOperator    Operator
hi def link jclCOperator   Operator
hi def link jclDsn         Identifier
hi def link jclCDsn        Identifier
hi def link jclData        Special
hi def link jclCData       Special
hi def link jclPgm         Function
hi def link jclCPgm        Function
hi def link jclNumber      Number
hi def link jclCNumber     Number
hi def link jclSnglQuote   String
hi def link jclDblQuote    jclSnglQuote
hi def link jclCSnglQuote  String
hi def link jclCDblQuote   jclCSnglQuote
hi def link jclComment     Comment
hi def link jclMsgCode     Identifier
hi def link jclDDName      Type
hi def link jclComma       Delimiter
hi def link jclParen       Delimiter
hi def link jclParam       Statement
hi def link jclAttr        Identifier
hi def link jclHex         Number
hi def link jclCharLit     String
hi def link jclProcName    Function
hi def link jclSymbolic    PreProc
hi def link jclReturnCode  Number
hi def link jclAmp         Keyword

let b:current_syntax = "jcl"
