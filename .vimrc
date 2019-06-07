" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup          " keep a backup file (restore to previous version)
set undofile        " keep an undo file (undo changes after closing)

set history=500     " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

set expandtab       " use spaces for indentation
set shiftwidth=4    " spaces to be removed or inserted
set tabstop=4       " width of tab character
set textwidth=0     " no line chars limit

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <c-u> <c-g>u<c-u>
" Same for CTRL-W removing word.
inoremap <c-w> <c-g>u<c-w>

if has('mouse')
    set mouse=""
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    " filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " Set 'textwidth'
    autocmd FileType text setlocal expandtab shiftwidth=4 tabstop=4 textwidth=0
    autocmd FileType php  setlocal expandtab shiftwidth=4 tabstop=4 textwidth=119
    autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 textwidth=80

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \ endif

    augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

set nobackup
set noundofile

colorscheme evening

