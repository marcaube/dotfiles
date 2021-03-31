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


" Keyboard Shortcuts and key mappings
" =============================================================================

" Split navigations, moving between window panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Nerdtree hotkeys
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Search
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Ag<CR>

" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree

" Enable code-folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

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

" Highlight long line
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

" Open file at the same line number as last close
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Let backspace work in insert mode
set backspace=indent,eol,start

" Adjust colors for GitGutter
highlight clear SignColumn

let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
