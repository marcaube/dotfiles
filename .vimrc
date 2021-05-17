set nocompatible              " required
filetype off                  " required

" Plugins
" =============================================================================

" set the runtime path to include Vundle and initialize TODO: use Plug instead?
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter'                             " Git status in the gutter TODO: use Signify instead?
Plugin 'editorconfig/editorconfig-vim'                      " Add support for .editorconfig files in projects
Plugin 'jiangmiao/auto-pairs'                               " Insert or delete brackets, parens, quotes in pair. TODO: Use autoclose instead?
Plugin 'junegunn/fzf'                                       " Fuzzy finder
Plugin 'junegunn/fzf.vim'
Plugin 'kristijanhusak/vim-hybrid-material'                 " Better color scheme
Plugin 'nvie/vim-flake8'
Plugin 'preservim/nerdcommenter'                            " Toggle code comment TODO: use Tim Pope's plugin instead?
Plugin 'preservim/nerdtree'                                 " Better file browser
Plugin 'valloric/youcompleteme'                             " Autocomplete
Plugin 'vim-airline/vim-airline'                            " Add a nice statusbar at the bottom of the window
Plugin 'vim-scripts/indentpython.vim'                       " Better code indentation for Python
Plugin 'vim-syntastic/syntastic'                            " Syntax highlighting
Plugin 'vim-test/vim-test'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Editor Preferences
" =============================================================================

set backspace=indent,eol,start  " Let backspace work in insert mode
set cursorline                  " Highlight the cursor row
set encoding=utf-8              " Default to UTF-8
set foldlevel=99
set foldmethod=indent           " Line wrap
set hlsearch                    " Highlight search results
set incsearch                   " Incremental search
set nojoinspaces                " Don't insert two spaces when joining lines
set noswapfile                  " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set rnu                         " Show line numbers
set numberwidth=5               " Allow line numbers > 999
set splitbelow                  " Open horizontal splits on the bottom
set splitright                  " Open vertical splits on the right

" Change the leader key
let mapleader = " "

" Enable syntax highlighting
let python_highlight_all=1
syntax on

" Set my color scheme
let g:hybrid_transparent_background = 1
set background=dark
colorscheme hybrid_material

" Show trailing whitespace characters
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Highlight whitespace at the end of a line
autocmd Filetype python match Error /\s\+$/

" Highlight long lines
let &colorcolumn="120"

" Open file at the same line number as last close
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Adjust colors for GitGutter
highlight clear SignColumn

let NERDTreeShowHidden=1 " Show hidden files...
let NERDTreeIgnore=['\.pyc$', '\.idea', '\.git$', 'node_modules', '\~$', '.DS_Store', '\.swp', '__pycache__', '.mypy_cache', '.venv'] " ... but not all of them


" Use clipboard as default register
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed " OSX
else
  set clipboard=unnamedplus " Linux
endif


" Keyboard Shortcuts and key mappings
" =============================================================================

" Split navigations, moving between window panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Nerdtree hotkeys
nnoremap <C-n> :NERDTreeFind<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" Search
" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Ag<CR>

" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree

" Enable folding with the spacebar
" nnoremap <space> za

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Clear search highlights
nnoremap <esc><esc> :silent! nohls<cr>

" vim-test mappings
nnoremap <silent> <Leader>f :TestFile<CR>
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
" nnoremap <silent> <leader>gt :TestVisit<CR>

" YCM
nmap <leader>d <plug>(YCMHover)

" Easier commands
nnoremap ; :
nnoremap : ;
xnoremap : ;
xnoremap ; :
