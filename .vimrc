set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
"set cursorline
"set cursorcolumn
set shiftwidth=4
set tabstop=4
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set foldmethod=indent
set runtimepath^=~/.vim/bundle/bbye
"C++ OCF Class generator
function! Class(...)
	if (a:0 % 2 == 0)
		return
	endif
	let arg = (a:0 - 1) / 2
	let header = "incl/".a:1.".hpp"
	:execute "vsp ".header
	call append(0, "#pragma once")
	call append(1, "")
	call append(2, "class ".a:1." {")
	for i in range(1, arg, 1)
		call append(2+i, "	".a:{2*i}."		".a:{2*i+1}.";")
	endfor
	call append(3+arg, "")
	call append(4+arg, "public:")
	call append(5+arg, "	".a:1."();")
	call append(6+arg, "	".a:1."(const ".a:1." &);")
	call append(7+arg, "	~".a:1."();")
	call append(8+arg, "	".a:1."&	operator=(const ".a:1." &);")
	call append(9+arg, "};")
	:execute 'write' header
"----------------------------------------------------------------------
	let source = "src/".a:1.".cpp"
	:execute "vsp ".source
	:execute "normal! a#include \"".a:1.".hpp\"\<cr>\<cr>"
	:execute "normal! a".a:1."::".a:1."()"
	if (arg > 0)
		:execute "normal! a:"
	endif
	for i in range(1, arg, 1)
		:execute "normal! a".a:{2*i+1}."()"
		if (i < arg)
			:execute "normal! a,"
		endif
	endfor
	:execute "normal! a {;}\<cr>"
	:execute "normal! a".a:1."::".a:1."(const ".a:1." &src)"
	if (arg > 0)
		:execute "normal! a:"
	endif
	for i in range(1, arg, 1)
		:execute "normal! a".a:{2*i+1}."(src.".a:{2*i+1}.")"
		if (i < arg)
			:execute "normal! a,"
		endif
	endfor
	:execute "normal! a {;}\<cr>"
	:execute "normal! a".a:1."::~".a:1."() {;}\<cr>\<cr>"
	:execute "normal! a".a:1."&\<tab>".a:1."::operator=(const ".a:1." &src) {\<cr>"
	for i in range(1, arg, 1)
		:execute "normal! a\<tab>this->".a:{2*i+1}." = src.".a:{2*i+1}.";\<cr>"
	endfor
	:execute "normal! a\<tab>return (*this);\<cr>"
	:execute "normal! a}"
	:execute 'write' source
endfunction
command! -nargs=+ Class call Class(<f-args>)
