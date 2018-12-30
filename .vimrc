" Configuration file for gvim
" Written for Debian GNU/Linux by W.Akkerman <wakkerma@debian.org>
" Some modifications by J.H.M. Dassen <jdassen@wi.LeidenUniv.nl>

" Slightly modified by Eduard Bloch <eduard@bloch.com>

" Finally messed up by Andreas Ferber <af@devcon.net>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" this are the Vim defaults, but we set it here for reference
set cpoptions=aABceFsn

" Font to use in gvim
set guifont=LucidaTypewriter\ 8

" do not use mouse
"set mouse=

" limit memory usage
set maxmem=8192     " 8MB max per buffer
set maxmemtot=32768 " 32MB total max

" Now we set some defaults for the editor
set expandtab           " expand tabs to spaces (be careful with Makefiles!)
set tabstop=3
set shiftwidth=3
"set backspace=3        " allow backspacing over everything in insert mode
set noautoindent        " always set autoindenting off
set wrap
set textwidth=80        " wrap lines after 80/72 characters
set formatoptions=trcq
set nocindent
set comments&
set nobackup            " don't keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more than
                        " 50 lines of registers
set history=50          " command line history
set syntax=idl

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Make vim consult the external termcap entries first, so we get all of
" Debian's termcap settings correct. This will be fixed upstream in 5.4
" set nottybuiltin term=$TERM
" Das o.g. bei VIM-Versionen < 5.5 entkommentieren

" The following are commented out as they cause vim to behave a lot
" different from regular vi. They are highly recommended though.
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ruler           " Show the line and column numbers of the cursor
set ignorecase      " Do case insensitive matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Use hidden buffers
set nohlsearch      " don't highlight last search matches
set cmdheight=2     " 2 lines for messages (fewer "Press Return" messages)
set showbreak=      " prefix wrapped lines with a + sign
set wildmenu        " use a menu for wildcard completion

"Fixing backspace and delete keys
set t_kb=
set t_kD=[3~

if has("statusline")
  " configure statusline
  set laststatus=2    " always show statusline

  if has("eval")
    " Vim can read compressed files, so we use this function to display the
    " compression mode in the statusline
    function! CompressFlag()
      let l:name = bufname("")
      if l:name =~'.gz$'
        return '[GZ]'
      elseif l:name =~ '.bz2$'
        return '[BZ2]'
      elseif l:name =~ '.Z$'
        return '[Z]'
      else
        return ''
      endif
    endfunction

    " the statusline (see doku for flag meanings)
    set statusline=%1*(%n)%*\ %<%f\ %1*%y%2*%m%1*%r%{CompressFlag()}%=%l,%-8(%c%V%)\ \ %P
  else
    set statusline=%1*(%n)%*\ %<%f\ %1*%y%2*%m%1*%r%=%l,%-8(%c%V%)\ \ %P
  endif

  " color definitions for statusline
  hi User1    ctermbg=Grey cterm=reverse,bold  term=reverse,bold
  hi User1    guifg=#0000ff       guibg=LightGray     gui=bold
  hi User2    ctermbg=LightRed    cterm=reverse,bold  term=reverse,bold
  hi User2    guifg=#ff0000       guibg=LightGray     gui=bold
endif " has("statusline")

if has("eval")
  function! TogglePaste()
    if &paste == 0
      set paste
      echo "paste enabled"
    else
      set nopaste
      echo "paste disabled"
    endif
  endfunction
  map <F10> :call TogglePaste()<CR>
  imap <F10> <C-O>:call TogglePaste()<CR>
  set pastetoggle=<F10>

  " spellcheck buffer with ispell, using a temp file
  function! IspellCheck()
    let l:tmpfile = tempname()

    execute "normal:w!" . l:tmpfile . "\<CR>"
    if has("gui_running")
      execute "normal:! xterm -e ispell -Tlatin1 " . l:tmpfile . "\<CR>"
    else
      execute "normal:! ispell -Tlatin1 " . l:tmpfile . "\<CR>"
    endif
    execute "normal:%d\<CR>"
    execute "normal:r " . l:tmpfile . "\<CR>"
    execute "normal:1d\<CR>"
  endfunction

  " spellcheck with ispell, use a temp file
  noremap <F7> <Esc>:call IspellCheck()<CR><Esc>
endif " has("eval") && has("keymap")

" some abbreviations
iab ##. ###########################################################################
iab **. ***************************************************************************
iab --. ---------------------------------------------------------------------------
iab #. #######################################################
iab *. *******************************************************
iab -. -------------------------------------------------------
iab =. =======================================================
cab dos2unix set fileformat=unix
cab ic g/^/s//#/g
cab dc g/^#/s///g

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" color settings (must be done before "syntax on" to get right defaults)
"set bg=dark
"hi normal   ctermfg=lightgray   ctermbg=black
"hi Normal   guibg=Black         guifg=Lightgray

" settings for color terminals
"if &t_Co > 2 || has("gui_running")
"  " turn on syntax highlighting
"  if has("syntax")
"    syntax on
"
"    " some settings for specific syntax files
"    let c_gnu = 1
"    let c_syntax_for_h = 1
"
"    let perl_include_pod = 1
"    let perl_want_scope_in_variables = 1
"    let perl_extended_vars = 1
"    let perl_fold = 1
"  endif
"endif

"colorscheme torte

if has("eval")

  " define CompatSetLocal, using setlocal if available (Vim >=6.0), set otherwise
  command! -nargs=+ CompatSetLocal setlocal <args>

endif " has("eval")

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  augroup LastPos
    au!
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  augroup END

  " set options based on filetype
  " if has("eval")
  "   augroup SetEditOpts
  "      au!
  "      autocmd FileType c :call MyCSettings()
  "      autocmd FileType perl :call MyPerlSettings()
  "      autocmd FileType make :call MyMakefileSettings()
  "      autocmd FileType html :call MyHTMLSettings()
  "   augroup END
  " endif

  augroup misc
    au!
    autocmd BufNewFile,BufReadPost ChangeLog,Changelog
      \ nmap  0i<CR><ESC>k:.!LANG=C date<CR>$a  Curt Wortman <cwortman@xilinx.com><CR>

    autocmd BufNewFile,BufRead SLRN* set syntax=mail
    autocmd BufNewFile,BufRead .followup,.letter,mutt*,nn.*,snd.*,SLRN* :normal ,kqs
  augroup END

endif " has ("autocmd")

if has("eval")
  " load extensions
  runtime! extensions/*.vim
endif

let tlist_verilog_systemverilog_settings='verilog;m:modules;P:paramters;p:ports;r:reg;w:wires;v:variables'

hi comment ctermfg=darkmagenta ctermbg=black

" vi:ts=4 sw=4 expandtab
