set nocompatible              " required
filetype off                  " required

" Plugins
" =============================================================================

" set the runtime path to include Vundle and initialize TODO: use Plug instead?
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'kristijanhusak/vim-hybrid-material'                 " Better color scheme
Plugin 'preservim/nerdtree'                                 " Better file browser
Plugin 'preservim/nerdcommenter'                            " Toggle code comment TODO: use Tim Pope's plugin instead?
Plugin 'vim-scripts/indentpython.vim'                       " Better code indentation for Python
Plugin 'vim-syntastic/syntastic'                            " Syntax highlighting
Plugin 'nvie/vim-flake8'
Plugin 'junegunn/fzf'                                       " Fuzzy finder
Plugin 'junegunn/fzf.vim'
Plugin 'valloric/youcompleteme'                             " Autocomplete
Plugin 'jiangmiao/auto-pairs'                               " Insert or delete brackets, parens, quotes in pair. TODO: Use autoclose instead?
Plugin 'airblade/vim-gitgutter'                             " Git status in the gutter TODO: use Signify instead?

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Editor Preferences
" =============================================================================

" Open split windows like iTerm does
set splitbelow
set splitright

" Highlight the cursor row
set cursorline

" Enable code-folding
set foldmethod=indent
set foldlevel=99

" Enable syntax highlighting
let python_highlight_all=1
syntax on

" Set my color scheme
let g:hybrid_transparent_background = 1
set background=dark
colorscheme hybrid_material

" Show line numbers
set nu

" Show trailing whitespace characters
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Default to UTF-8
set encoding=utf-8

" Highlight whitespace at the end of a line
autocmd Filetype python match Error /\s\+$/

" Highlight long lines
let &colorcolumn="120"

" Open file at the same line number as last close
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Let backspace work in insert mode
set backspace=indent,eol,start

" Adjust colors for GitGutter
highlight clear SignColumn

let NERDTreeShowHidden=1 " Show hidden files...
let NERDTreeIgnore=['\.pyc$', '\.idea', '\.git', 'node_modules', '\~$', '.DS_Store', '\.swp' ] " ... but not all of them

" Highlight search results
set hlsearch
set is hls " incremental search


" Keyboard Shortcuts and key mappings
" =============================================================================

" Split navigations, moving between window panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Nerdtree hotkeys
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" Search
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Ag<CR>

" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree

" Enable folding with the spacebar
nnoremap <space> za

" Clear search highlights
nnoremap <esc><esc> :silent! nohls<cr>

" Move a block of code up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
