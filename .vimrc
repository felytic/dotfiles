filetype off

set nocompatible

set relativenumber
set nu

set tabstop=4
set softtabstop=2
set shiftwidth=2
set noexpandtab

set enc=utf-8
set colorcolumn=80

set incsearch
set hlsearch

set splitbelow
set splitright

set nowrap
set noswapfile

syntax on

setlocal spell spelllang=en_us

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'luochen1990/rainbow'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'davidhalter/jedi-vim'
Plugin 'majutsushi/tagbar'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-unimpaired'
Plugin 'Yggdroot/indentLine'

call vundle#end()
filetype plugin indent on


set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

let g:rainbow_active = 1

map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0

let g:SimpylFold_docstring_preview=1

let python_highlight_all=1

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:airline_powerline_fonts = 1

let g:syntastic_always_populate_loc_list = 1

"========================== NERD TREE =========================================

map <f2> :NERDTreeToggle<CR>

"close vim when only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" files to hide in NERDTree
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

autocmd vimenter * NERDTree

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "_",
    \ "Renamed"   : "%",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "D",
    \ "Clean"     : "C",
    \ 'Ignored'   : "I",
    \ "Unknown"   : "?"}

" File highlighting
function! NERDTreeHighlightFile(ext, color)
  exec 'autocmd filetype nerdtree highlight ' . a:ext.' ctermfg='. a:color
  exec 'autocmd filetype nerdtree syn match ' . a:ext.' #^\s\+.*'.  a:ext.'$#'
endfunction

call NERDTreeHighlightFile('py', 'green')
call NERDTreeHighlightFile('json', 'blue')
call NERDTreeHighlightFile('js', 'yellow')
call NERDTreeHighlightFile('log', 'gray')
call NERDTreeHighlightFile('md', 'gray')
call NERDTreeHighlightFile('conf', 'red')
call NERDTreeHighlightFile('html', 'magenta')

"==============================================================================
