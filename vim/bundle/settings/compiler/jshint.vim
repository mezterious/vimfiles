" Vim Compiler File - JSHint

if exists("current_compiler")
  finish
endif
let current_compiler = "jshint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:savecpo = &cpo
set cpo&vim

CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
CompilerSet makeprg=jshint\ %

let &cpo = s:savecpo
unlet s:savecpo
