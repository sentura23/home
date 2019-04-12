"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""$source: $         
""$Revision: 1.5 $
""$Date: 2007/08/24 17:34:45 $
""$Author: chrisar $
""
""Purpose: This is the GVim configuration file
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"source $GUUP_ROOT/setup/misc/gvim_templates/comment.vim
"let mysyntaxfile = "$GUUP_ROOT/setup/misc/mysyntax.vim"

" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2000 Mar 29
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"             for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"           for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

"Add for case insensitive search
set ignorecase smartcase

"Show cursor position all the time
set ruler

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
set guifont=9x15

" Make command line two lines high
set ch=2

" When <TAB> is hit, put 2 spaces in
"set expandtab
set tabstop=2
set shiftwidth=2
set backspace=indent,start
fixdel

" Match up braces, parenthesis etc - hit <SHIFT> %
set showmatch

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting.
  syntax on

  " Switch on search pattern highlighting.
  highlight Search  ctermbg=Yellow ctermfg=DarkGray
  "highlight Search   ctermbg=yellow ctermfg=DarkGray cterm=None
  "highlight IncSearch   ctermbg=yellow ctermfg=DarkGray cterm=None
  set hlsearch

  " Hide the mouse pointer while typing
  set mousehide

  "winsize 88 40

  " Set colors
  " basic colorscheme for 16-color terminals
  highlight Statement ctermfg=DarkMagenta
  highlight Identifier ctermfg=LightBlue
  highlight Type ctermfg=DarkCyan
  highlight Comment ctermfg=Grey
  highlight PreProc ctermfg=Blue
  highlight LineNr ctermfg=DarkGray
  highlight Special ctermfg=Brown
  highlight Constant ctermfg=DarkGray
  
  highlight Search ctermfg=Black ctermbg=Grey
  highlight IncSearch ctermfg=DarkGray ctermbg=White
  highlight Visual ctermfg=White ctermbg=Blue
  highlight Folded cterm=bold,reverse ctermfg=DarkGray ctermbg=Brown
  
  highlight Pmenu cterm=reverse ctermfg=DarkGray ctermbg=White
  highlight PmenuSel ctermfg=Black ctermbg=White
  highlight PmenuSbar ctermbg=Black
  highlight PmenuThumb ctermfg=White
  
  " use only bold for the cursorline to avoid covering the background
  highlight clear CursorLine
  highlight clear CursorColumn
  highlight CursorLine cterm=bold gui=bold 
  highlight CursorColumn cterm=bold gui=bold

endif
