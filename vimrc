"File:				vimrc
"Purpose:			vim config file
"Author:				Stefan Schmid <bademeister7@web.de>
"Last Modified:	12/31/2008

"set hlsearch		" highlight found patterns


" syntax highlight
syntax on


" dont be compatible with vi
set nocompatible

" number of the lines at the left side
set number

" don't interpret modelines on the beginning/end of file
set modelines=0

" sets the current colorscheme
" for info about the currently active colorscheme:
" 				:echo colors_name
colorscheme mucol

"function InsertTabWrapper()
"	let col = col('.') - 1
"		if !col || getline('.')[col - 1] !~ '\k'
"			return "\<tab>"
"		else
"			return "\<c-p>"
"		endif
"endfunction

"noremap <tab> <c-r>=InsertTabWrapper()<cr>


" toggle tab completion
function! TabCompletion()
	if mapcheck("\<tab>", "i") != ""
		:iunmap <tab>
		:iunmap <s-tab>
		:iunmap <c-tab>
		echo "tab completion off"
	else
		:imap <tab> <c-n>
		:imap <s-tab> <c-p>
		:imap <c-tab> <c-x><c-l>
		echo "tab completion on"
	endif
endfunction

map <Leader>tc :call TabCompletion()<cr>

filetype plugin indent on

set grepprg=grep\ -nH\ $*

set foldlevel=10


" moving around, searchin and patterns
set ic							" ignore case on a search pattern
set smartcase					" don't ignore case when regexp contains a cap
set incsearch					" While typing a pattern, show immediately where the so far typed pattern matches

" displaying text
set so=3							" show at least 3 lines before/after current line
set foldmethod=indent		" fold lines with respect to indent

" messages and info
set noerrorbells				" errorbells
set visualbell					" flash window instead of a acoustic signal
set ruler						" show row and column on the bottom
set showcmd						" show vim cmd in the last line
set showmode					" show modi in status line

" editing text
set bs=2							" allow backspacing over eol
set nojoinspaces				" don't add 2 spaces when joining to lines and a dot is at the end

" tabs and indenting
set autoindent					" copy indent from current line to the new line
"set cindent					" nice for C-like programs
set shiftwidth=3				" shiftwidth: Number of spaces to use for each insertion of (auto)indent.
set smartindent				" smart auto indent (also nice for C-like progs)
set tabstop=3					" number of spaces that a <Tab>  counts for

" reading and writing files
set modelines=0
set nobackup					" don't backup files (~)

" command line editing
set history=40					" save up to 40 ex cmds in history
set wildmenu					" show menu on completion

"set clipboard=unnamedplus	" alias unnamedregister to the + register to copy to 
									" X clipboard with e.g. gg"+yG


" mappings

" toggle spell checking
map <F5> :setlocal spell! spelllang=en_us<CR>



" Prevents Vim 7.0 from setting filetype to 'plaintex'
" let g:tex_flavor='latex'
"

" abbriviations
ab mfg Mit freundlichen Grüßen

" autocommands
autocmd BufNewFile *.c 0r ~/.vim/template.c | exe "normal G" | exe "normal dd" | 3

autocmd BufNewFile *.tex 0r ~/.vim/template.tex | 6

"autocmd BufRead /tmp/mutt-* exe "normal 3O"| exe "normal gg"| startinsert
"autocmd BufReadPre /tmp/mutt-* exe "normal gg" | exe "normal 3O"| exe "normal gg"| startinsert

autocmd BufWritePre,FileWritePre *.html   ks|call LastMod()|'s
fun LastMod()
	if line("$") > 20
		let l = 20
	else
		let l = line("$")
	endif
	let d = strftime("%b %d, %Y)
	echo d
	exe "1," . l . "g/Last modified:/s/Last modified: .*/Last modified: " .
  \ strftime("%Y %b %d")
endfun

" Python settings
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
   \ set shiftwidth=4 |
   \ set textwidth=79 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix


" Functions

" on z. the cursor is on the beginning of the line
" this function sets the cursor to the old position
function! Center()
	let s:posi = getpos(".")
	normal z.
	call setpos('.', s:posi)
endf
map <F2> :call Zentral()<CR>

" toggle list-option (^I instead of <Tab>, $ on lf)
function! ToggleList()
	let &list = ! &list
endfunction
map <F1> :call ToggleList()<CR>

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

set printexpr=PrintFile(v:fname_in)
function! PrintFile(fname)
	call system("ghostscript " . a:fname)
	call delete(a:fname)
	return v:shell_error
endfunc

" default vimrc
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	if $USER != ''
	    let login = $USER
	elseif $LOGNAME != ''
	    let login = $LOGNAME
	else
	    let login = 'unknown'
	endif
	let newline = stridx(login, "\n")
	if newline != -1
	    let login = strpart(login, 0, newline)
	endif
	if $HOSTNAME != ''
	    let hostname = $HOSTNAME
	else
	    let hostname = system('hostname -f')
	    if v:shell_error
		let hostname = 'localhost'
	    endif
	endif
	let newline = stridx(hostname, "\n")
	if newline != -1
	    let hostname = strpart(hostname, 0, newline)
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
	setf spec
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()
" filetypes
filetype plugin on
filetype indent on
" ~/.vimrc ends here


