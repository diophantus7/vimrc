" File:				myindent.vim
" Purpose:			Vim indent file for LaTeX
" Author:			Stefan Schmid <larry@guffin.de>
" Last Modified:	Dec 22 2008

" Only load this when no other was loaded
if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal indentexpr=GetLaTeXIndent()

