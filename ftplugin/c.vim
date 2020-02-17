set ai cindent

set makeprg=gcc\ -Wall\ -o\ %<\ %

"let C_AUTOCLOSE=expand("~/.vim/ftplugin/c_autoclose.vim")
"if filereadable(C_AUTOCLOSE)
"	exe "so " . C_AUTOCLOSE
"else
"	echo "file " . C_AUTOCLOSE . " not found."
"endif

func! CompileRunGcc()
	exec "w"
	" FIXME: does not work under linux:
	exec "!gcc % -o %<  && IF EXIST %<.exe (cr 5 && banner -c #
	" Success) ELSE banner -c # Compile Unsuccessful "
	 exec "!gcc\ -Wall\ -o\ %<\ % && ./%<"
	exec "i"
endfunc
map <F8> : call CompileRunGcc()<CR>

vmap /	:s/^/\/\/<CR>
vmap -	:s/^\/\///<CR>

" for extra syntax highlight (~/.vim/after/syntax/c.vim)
highlight KDE              ctermfg=magenta
highlight mySpecialSymbols ctermfg=yellow
