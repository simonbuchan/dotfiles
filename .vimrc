set list                        " show weird characters
set listchars=tab:>\ ,trail:.   " reasonable tabs and visible trailing whitespace
set shiftwidth=4 tabstop=4 expandtab " sensible tabs, please
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set visualbell                  " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set number                      " line numbers
set nohidden                    " throw away closed buffers
set scrolloff=10                " keep cursor away from top and bottom
set relativenumber              " line numbers relative to current line
"set cursorline                  " highlight current line
"highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE " without breaking styling

" Put backups in a common place
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" Force ~/.vim for runtime path even on Windows/MinGW
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

set autoread                    " reload changed files
set autoindent smartindent smarttab " smart indenting
set hlsearch                    " highlight incremental search matches
set ignorecase                  " incremental search ignores case
set autochdir                   " change directory to opened file
set clipboard=unnamed           " copy and paste from windows clipboard

" enable Pathogen plugin manager (can't put comment after execute)
execute pathogen#infect()

filetype plugin indent on       " enable filetype detection
syntax on                       " enable syntax highlighting

au BufRead,BufNewFile *.as set filetype=actionscript " AS3 syntax
au BufNewFile,BufReadPost *.html,*.js,*.coffee,*.rb setl tabstop=2 shiftwidth=2 expandtab " default tabs for CoffeeScript

" Minntty cursor changes
"let &t_ti.="\e[1 q"
"let &t_SI.="\e[5 q"
"let &t_EI.="\e[1 q"
"let &t_te.="\e[0 q"

" Mintty escape timeout
"let &t_ti.="\e[?7727h"
"let &t_te.="\e[?7727l"
"noremap <Esc>O[ <Esc>
"noremap! <Esc>O[ <C-c>

let g:netrw_banner = 0
let g:netrw_preview   = 1
let g:netrw_winsize   = 30

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
