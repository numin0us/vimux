"" MISCELLANEOUS:
set noswapfile
set incsearch
set ignorecase
set tabstop=4
set shiftwidth=4
set autoindent
set backspace=indent,eol,start
set smartindent
set splitbelow
set splitright
set noerrorbells
set showcmd
set showmode
set nowritebackup
set autowrite
set autoread
set laststatus=2
set hidden
set ruler
set mouse=a
au FocusLost * :wa
set fileformats=unix,dos,mac

set noshowmatch
set noshowmode
"set hlsearch
set smartcase
set ttyfast

set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
set re=1

set conceallevel=0

""command! nargs=* -complete=help Help vertical belowright help <args>
""autocmd FileType help wincmd L
"
"nnoremap <esc> :noh<return><esc>
"
"set wrap
"set textwidth=79

set notimeout
set ttimeout
set ttimeoutlen=10

"set complete=.,w,b,u,t
"set completeopt=longest,menuone

if &history < 1000
    set history=50
endif

if &tabpagemax < 50
    set tabpagemax=50
endif

if !empty(&viminfo)
	set viminfo^=!
endif

if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=5
endif
set display+=lastline

"if has('mouse')
"	set mouse=a
"endif



"" SHELL:
set shell=/bin/bash

"" NUMBERING:
set number

"" CLIPBOARD:
set clipboard=unnamedplus

"" KEY BINDINGS:
map <C-n> :NERDTreeToggle<CR>
" Split Window Movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Folding
nnoremap <space> za


"" SYNTAX:
" Sets syntax highlighting on
set t_Co=256
syntax enable


" FOLDING:
set foldmethod=indent
set foldlevel=99

" UTF8 Encoding:
set encoding=utf-8

" Enable backspace end of line
set backspace=indent,eol,start

"" JAVA:
autocmd Filetype java set makeprg=javac\ %
""set errorformat=%A%f:%1:\ %m,%-Z%p^,%-C#,%#
nnoremap <F9> :make<Return>:copen<Return>
map [l :cprevious<Return>
map ]l :cnext<Return>


"" PYTHON:

" Preview docstrings for folded code
let g:SimpylFold_docstring_preview=1

" PEP 8 Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Flag Unnecessary Whitespace
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Virtualenv support #Requires vim with python scripting

python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(_file_=activate_this))
EOF

"" Code aesthetic improvement
let python_highlight_all=1
syntax on


"" NerdTree Logic
let NERDTreeIgnore=['\.pyc$', '\~$']

" YouCompleteMe Keybindings:
"  Sets space + g to go to definition of current code selection
let g:ycm_autoclose_preview_window_after_completion=1
map ,g :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Buffer Switching:
nnoremap <F5> :buffers<CR>:buffer<Space>

" Paste toggling
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"Buffer switch via tabs
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

"" WEB STACK Autoindent
"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2

"execute pathogen#infect()
"filetype plugin indent on

set nocompatible              " be iMproved, required
filetype off                  " required

" Plugin Setup via Vundle:
" set the runtime path to include Vundle and initialize
" "
if !isdirectory(expand("~/.vim/bundle/Vundle.vim/.git"))
    !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"" Plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Raimondi/delimitMate' "Automatic closing of brackets, etc
Plugin 'godlygeek/tabular'  "Alignment improvements
Plugin 'moll/vim-bbye' "Better buffer deletion
Plugin 'ntpeters/vim-better-whitespace' "Whitespace detection, deletion with :StripWhitespace
"Plugin 'ap/vim-buftabline' "Buffers as tabs
"Plugin 'airblade/vimgutter.git' "Shows git diffs in files
Plugin 'Yggdroot/indentLine' "Shows indentation lines



"" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"" To ignore plugin indent changes, instead use:
""filetype plugin on

"" COLORS:
"let g:solarized_termtrans = 1
set background=dark
"let g:gruvbox_transparent_bg=1
colo gruvbox

" Airline Configuration:
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_solarized_bg='dark'
let g:airline_theme='gruvbox'

