" Vim Compiler File
" Compiler: perlcritic
" Maintainer: Scott Peshak <speshak@gmail.com>
" Last Change: 2006 Dec 19

if exists("current_compiler")
	finish
endif
let current_compiler = "perlcritic"

if exists(":CompilerSet") != 2 
	command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=perlcritic\ -verbose\ 1\ --profile=$SVN_TRUNK/config/perlcriticrc\ --brutal\ %
CompilerSet errorformat="%f: (%l:%c) [%p] %m (Sev %s)"

let &cpo = s:cpo_save
unlet s:cpo_save
