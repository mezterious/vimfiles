" vimrc
"------------------------------------------------------------------------------
" GENERAL
"------------------------------------------------------------------------------

" Vim compatible instead of vi. 
" Must be the first thing becuase other options are changed as a side effect
set nocompatible

" Manage vim plugins
" https://github.com/tpope/vim-pathogen

" pathogen needs to run before plugin indent on
filetype off

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" Auto read when a file is changed from the outside
set autoread

" Speficiy map leader for extrq key combinations
let mapleader=","
let g:mapleader=","

" Fast saving
nmap <leader>w :w!<cr>

" How many lines VIM should remember
set history=100
set undolevels=100

" Don't check lines for set commands
set nomodeline

" Start off where we left off when opening a file
set viminfo+=<1000

" Toggle paste so that lines aren't automatically indented when inserting
set pastetoggle=<F3>


"------------------------------------------------------------------------------
" USER INTERFACE
"------------------------------------------------------------------------------

" Attempt to determine the type of a file based on its name and contents.
" Use this to allow intelligent auto-indenting for each file type
filetype plugin indent on

" Show file name in window title bar
set title

" Minimal number of screen lines to keep above and below the cursor when
" scrolling
set scrolloff=7

" Show line numbers
set number

" Display incomplete commands
set showcmd

" Highlight the current line
set cursorline

" Enable wild menu for better command line completion
set wildmenu

" Show current cursor position
set ruler

" Show matching brackets
set showmatch

" Tenths of a second to show the matching brackets
set matchtime=5

" Height of the command bar
set cmdheight=2

" When splitting, put new window on the right (default is on the left)
set splitright

" Show the status line
set laststatus=2

" Change the buffer without saving
set hidden

" Confirm unsaved changes
set confirm

" Don't redraw while executing macros, registers and other commands that have
" not been typed
set lazyredraw

" The minimal height of a window, when it's not the current window.
set winminheight=0

"------------------------------------------------------------------------------
" COLOURS & FONTS
"------------------------------------------------------------------------------

" Enable syntax highlighting
syntax enable

" Set background and colour scheme
set background=dark
colorscheme solarized

" Ignore whitespace differences in vimdiff
set diffopt+=iwhite

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Use UTF8 as standard encoding
set encoding=utf8

" Use Unix as file type
set fileformats=unix,mac,dos

"------------------------------------------------------------------------------
" SEARCHING
"------------------------------------------------------------------------------

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

" Turn off search highlight
nnoremap <leader>/ :nohlsearch<CR>

"------------------------------------------------------------------------------
" SPACES & TABS
"------------------------------------------------------------------------------

" Number of spaces to use for each step of (auto)indent. 
set shiftwidth=4

" 1 tab equals 4 spaces
set tabstop=4

" 1 tab equals 4 spaces when inserting/editing
set softtabstop=4

" Use spaces instead of tabs
set expandtab

" Insert blanks at the start of the line according to shiftwidth
set smarttab

" Copy indent from current line when starting a new line
set autoindent

" Do smart autoindenting when starting a new line. 
set smartindent

" Configure backspace to behave normally
set backspace=eol,start,indent

" Wrap at word boundaries rather than breaking words
set linebreak

" Let the left and right arrow keys, h and l keys, to wrap when used at the
" beginning or end of lines. ( < > are the cursor keys used in normal and
" visual mode and [ ] are the cursor keys in insert mode).
set whichwrap+=<,>,h,l,[,]

"------------------------------------------------------------------------------
" SAVING & BACKUPS
"------------------------------------------------------------------------------

" Disable file backup
set nobackup
set nowritebackup
set noswapfile

"------------------------------------------------------------------------------
" FOLDING
"------------------------------------------------------------------------------



"------------------------------------------------------------------------------
" AUTO COMMANDS
"------------------------------------------------------------------------------

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Use Autocommand Groups to avoid duplicate autocommands
    augroup config_vimrc
        " Clear the group first
        autocmd!

        " When vimrc is edited, reload it
        autocmd! BufWritePost vimrc source ~/.vimrc
    augroup END

    augroup config_filetype
        " Clear the group first
        autocmd!

        " Make ruby use 2 spaces instead of the default
        autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

        " Strip whitespace on save
        autocmd FileType perl,xml,sql,javascript,css,sh autocmd BufWritePre <buffer> :call s:StripTrailingWhitespace()

    augroup END

    augroup config_read

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    augroup END


endif " has("autocmd")

"------------------------------------------------------------------------------
" MOVEMENT
"------------------------------------------------------------------------------

" Highlight last inserted text
nnoremap gV `[v`]

" Quickly edit/reload vimrc
nmap <silent> <leader>ev :e ~/.vimrc<cr>
nmap <silent> <leader>sv :so ~/.vimrc<cr>

" Configure cope
map <leader>cc :botright cope<cr>
map <leader>c] :cn<cr>
map <leader>c[ :cp<cr>

" Move between buffers
map <leader>b] :bn<cr>
map <leader>b[ :bp<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move between windows and maximize
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" Switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Enable visual selection and indenting
vmap <tab> >gv
vmap <s-tab> <gv
nmap <tab> I<tab><esc>

" Strip whitespace
nmap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<cr>


"------------------------------------------------------------------------------
" FUNCTIONS
"------------------------------------------------------------------------------

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


