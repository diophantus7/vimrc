" If labels are defined by \label{fig:something}, then
" typing \ref{fig: and pressing <C-n> will result into
" a menu of all figure labels
set iskeyword+=:
set iskeyword+=_

" Set default compilation rules
let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape --interaction=nonstopmode $*'

" Compile to pdf
let g:Tex_DefaultTargetFormat = 'pdf'

" Add PDF-Format to be compiled several times
let g:Tex_MultipleCompileFormats = 'dvi,pdf'

" Expand theorem as follows
let g:Tex_Env_theorem = "\\begin{theorem}\<CR><++>\<CR>\\end{theorem}"

" Disable Latex_Suite's folding functionality
"let g:Tex_Folding = 0

" auto close an environment when inserting a }
" ^V to not auto close the \begin{environment}
let TEX_AUTOCLOSE=expand("~/.vim/ftplugin/tex_autoclose.vim")
if filereadable(TEX_AUTOCLOSE)
	exe "so " . TEX_AUTOCLOSE
else
	echo "file " . TEX_AUTOCLOSE . " not found."
endif

" source vim indent file
let TEXINDENT=expand("~/.vim/indent/tex.vim")
if filereadable(TEXINDENT)
	exe "source " . TEXINDENT
else
	echo "file ~/.vim/indent/tex.vim not found!"
endif

" bind key F8 to compile the document
func! ToDVI()
	exec "w"
	exec "!latex -interaction=nonstopmode % && rm %<.aux %<.log"
endfunc
map <F8> :call ToDVI()<CR>

" bind key F6 to compile the document and present with evince
func! ToPDF()
	exec "w"
	exec "!pdflatex -interaction=nonstopmode % && rm %<.aux %<.log && evince %<.pdf &"
endfunc
map <F6> :call ToPDF()<CR>

" substitutes some umlauts
"func! Substitute()
"	let col = col(".")
"	let lin = line(".")
"	%s/ß/\\ss{}/eIg
"	%s/ä/\\"a/eIg
"	%s/ö/\\"o/eIg
"	%s/ü/\\"u/eIg
"	%s/Ä/\\"A/eIg
"	%s/Ö/\\"O/eIg
"	%s/Ü/\\"U/eIg
"	call cursor(lin, col)
"endfunc
"map <F5> :call Substitute()<CR>

" mappings
" -------------------------
" view file with xdvi
map <F7> :!xdvi %<.dvi &<CR><CR>
" insert some environments
imap <C-b> \begin{itemize}<CR>\item 
imap <C-e> \begin{equation}<CR>
imap <C-a> \begin{align*}<CR>
imap <C-f> \begin{displaymath}<CR>
" substitute umlauts
imap ß \ss{}
imap ä \"a
imap ö \"o
imap ü \"u
imap Ä \"A
imap Ö \"O
imap Ü \"U
" quote in visual mode
vmap %	:s/^/%<CR>
vmap -	:s/^%//<CR>

ab phi varphi
ab ... \ldots
ab LR \Leftrightarrow
ab ra \rightarrow
ab lra \longrightarrow
ab obda o.B.d.A.~
ab wlog w.l.o.g.~
ab dh d.h.~
ab ie i.e.~
ab wrt with respect to

