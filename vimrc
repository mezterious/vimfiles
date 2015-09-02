" vimrc

" vi compatibillity. Must be the first thing becuase other options are
" change as a side effect
set nocompatible

" Manage vim plugins
" https://github.com/tpope/vim-pathogen

" pathogen needs to run before plugin indent on
filetype off

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" Attempt to determine the type of a file based on its name and contents.
" Use this to allow intelligent auto-indenting for each file type
filetype plugin indent on

" Show file name in window title bar
set title

" How many lines VIM should remember
set history=500
set undolevels=500

" Auto read when a file is changed from the outside
set autoread

" Set lines to the cursors when moving vertically
set scrolloff=7

" Enable wild menu for better command line completion
set wildmenu

" Highlight the current line
set cursorline

" Show current cursor position
set ruler

" Height of the command bar
set cmdheight=2

" Change the buffer without saving
set hidden

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" Override ignorecase if search string contains capitals
set smartcase

" Highlight search results
set hlsearch

" Show search pattern as it is typed
set incsearch

" For regular expressions
set magic

" Show matching brackets
set showmatch
set matchtime=5

" Display incomplete commands
set showcmd

" When splitting, put new window on the right (default is on the left)
set splitright

" Use UTF8 as standard encoding
set encoding=utf8

" Use Unix as file type
set ffs=unix,mac,dos

" Enable syntax highlighting
syntax enable

" Set background and colour scheme
set background=dark
colorscheme solarized

" Disable file backup
set nobackup
set nowritebackup
set noswapfile

" Confirm unsaved changes
set confirm

" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab equals 4 spaces
set shiftwidth=4
set tabstop=4

" Wrap at word boundaries rather than breaking words
set linebreak

" Auto indent
set autoindent
set smartindent

" Toggle between 'paste' and 'nopaste'
set pastetoggle=<F3>

" Ignore whitespace differences in vimdiff
set diffopt+=iwhite

set viminfo+=<1000

" Show the status line
set laststatus=2
set nomodeline

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " When vimrc is edited, reload it
    autocmd! bufwritepost vimrc source ~/.vimrc

    " Use smart indenting for particular languages
    autocmd FileType perl setlocal smartindent
    autocmd FileType javascript setlocal smartindent
    autocmd Filetype ruby setlocal smartindent tabstop=2 shiftwidth=2

    " Strip whitespace on save
    autocmd FileType perl,xml,sql,javascript,css,sh autocmd BufWritePre <buffer> :call s:StripTrailingWhitespace()

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
else

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Mappings

" Quickly edit/reload vimrc
nmap <silent> <leader>ev :e ~/.vimrc<cr>
nmap <silent> <leader>sv :so ~/.vimrc<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Configure cope
map <leader>cc :botright cope<cr>
map <leader>} :cn<cr>
map <leader>{ :cp<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move between buffers
map <leader>] :bn<cr>
map <leader>[ :bp<cr>

" Switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Enable visual selection and indenting
vmap <tab> >gv
vmap <s-tab> <gv
nmap <tab> I<tab><esc>

" Strip whitespace
nmap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<cr>


" Functions

" Clean trailing whitespaces
function! <SID>StripTrailingWhitespace()
    " Preparation: save last search and cursor pos
    let _s=@/
    let l=line(".")
    let c=col(".")

    " Do the business
    %s/\s\+$//e

    " Clean up: restore previous search history and cursor pos
    let @/=_s
    call cursor(l,c)
endfunction

" Configurations

" Speficiy map leader
let mapleader=","
let g:mapleader=","


"
" Plugin Customisations
"
" vim-airline
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

