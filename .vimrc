" ================================== GENERAL ================================= 

filetype off  " Nessesary for plugins loadins, set on below

set nocompatible  " Don't be compatible with VI

set wildmenu  " Better command-line completion

set relativenumber  " Enable relative line numbers
set number  " Display current line number

set tabstop=4  " One tab equal 4 spaces
set softtabstop=2  " Or 2 if neseesary
set shiftwidth=4  " Number of spaces inserted on TAB press
set expandtab  " Insert spaces instead of tabs

set incsearch  " Show search matches as you type
set hlsearch  " Highlight all search matches
set ignorecase  " Use case insensitive search
set smartcase  " Except when using capital letters

set encoding=utf-8  " Default encoding is UTF-8
scriptencoding utf-8

set colorcolumn=80  " Highlight 80th column

set splitbelow  " Vertical split splits below the current buffer
set splitright  " Horizontalsplit splits at the right of the current buffer

set nowrap  " Disable line wrap
set noswapfile  " Disavle swap file

set confirm  " Always ask for saving changes

set background=dark  " Use dark UI

set diffopt+=vertical  " Use vertical split for diffs

setlocal spell spelllang=en_us  " Set default language for spellchecking

set list  " Show unprintable chars
set listchars=tab:>-,trail:•,extends:#,nbsp:•  " List of chars to show

set history=100  "Remember 100 last commands
set undolevels=100  " Use more levels of undo

set nofoldenable  "Don't fold by default
set foldmethod=indent  " Fold based on indentation
set foldnestmax=5  " Maximum fold level

set scrolloff=4  "Keep 4 lines above and below while scrolling
" =================================== KEYS ===================================

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use H and L to move at the beggining and at the end of the line
nnoremap L $
nnoremap H ^

" Set Space as leader key
let mapleader = ' '

" Open this file on F12
nnoremap <F12> :vsplit ~/.vimrc <CR>

" Insert python breakpoint
map <F9> oimport pdb; pdb.set_trace()  # BREAKPOINT<C-c>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


" ================================== PLUGINS =================================
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

  " Vundle, the plug-in manager
  Plugin 'VundleVim/Vundle.vim'

  " Commnet/uncomment the code
  Plugin 'tpope/vim-commentary'

  " Quoting/parenthesizing made simple
  Plugin 'tpope/vim-surround'

  " Enable repeating supported plugin maps with '.'
  Plugin 'tpope/vim-repeat'

  " Auto-completion for quotes, parens, brackets, etc.
  Plugin 'Raimondi/delimitMate'

  " Camelcase, undersore, acronym words motions
  Plugin 'chaoren/vim-wordmotion'

  " Fuzzy funder
  Plugin 'junegunn/fzf.vim'

  " Asynchronous linting/fixing
  Plugin 'w0rp/ale'

  " Perform all insert mode completions with Tab
  Plugin 'ervandew/supertab'

  " Working with CSV files
  Plugin 'chrisbra/csv.vim'

  " JSON plugin
  Plugin 'elzr/vim-json'

  " === Extra buffers ===

  " A tree file system explorer
  Plugin 'scrooloose/nerdtree'

  " Displays tags in a window, ordered by scope
  Plugin 'majutsushi/tagbar'

  " === Git ===

  " A Git wrapper
  Plugin 'tpope/vim-fugitive'

  " Shows a git diff in the gutter (sign column) and stages/undoes hunks
  Plugin 'airblade/vim-gitgutter'

  " A git commit browser
  Plugin 'junegunn/gv.vim'

  " A plugin of NERDTree showing git status
  Plugin 'Xuyuanp/nerdtree-git-plugin'

  " === Python ===

  " Better Python indentation
  Plugin 'vim-scripts/indentpython.vim'

  " Jedi autocompletion library for Python
  Plugin 'davidhalter/jedi-vim'

  " Python docstring generator
  Plugin 'heavenshell/vim-pydocstring'

  " === UI ===

  " No-BS Python code folding
  Plugin 'tmhedberg/SimpylFold'

  " Retro groove color scheme
  Plugin 'morhetz/gruvbox'

  " Rainbow delimiters
  Plugin 'luochen1990/rainbow'

  " Lean & mean status/tabline
  Plugin 'bling/vim-airline'

  " Display the indention levels with thin vertical lines
  Plugin 'Yggdroot/indentLine'

call vundle#end()

" This two functions must be located after plugins loading
filetype plugin indent on " Determine the file type by its name and contents.
syntax on  " Enable syntax highlighting

" =============================== PLUGINS SETUP ==============================

" === Rainbow ===
let g:rainbow_active = 1


" === Tagbar ===
map <F4> :TagbarToggle<CR>

let g:tagbar_autofocus = 0


" === Gruvbox ===
let g:gruvbox_contrast_dark='hard'

colorscheme gruvbox


" === Airline ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1


" === Ale ===
map <C-f> :ALEFix <CR>

let g:ale_list_window_size = 5
let g:ale_set_loclist = 0
let g:ale_open_list = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {'python': ['flake8', 'pyflakes']}
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'python': ['autopep8', 'yapf']
  \}


" === Supertab ===
let g:SuperTabDefaultCompletionType = '<c-n>'


" === IndentLine ===
let g:indentLine_char = '│'


" === GitGutter ===
nnoremap <C-p> :GitGutterPrevHunk<CR>
nnoremap <C-n> :GitGutterNextHunk<CR>
nnoremap U :GitGutterUndoHunk <CR>


" === FZF ===
map <F5> :Ag <CR>

" Save search results to quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'


" === NERDTree ===
map <F2> :NERDTreeToggle<CR>

let NERDTreeMapJumpParent='h'
let NERDTreeMapOpenSplit='<S-TAB>'
let NERDTreeMapOpenVSplit='<TAB>'

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'


augroup vimrc
    " Close vim when only NERDTree is open
    autocmd bufenter * if (
        \winnr("$") == 1 &&
        \exists("b:NERDTree") &&
        \b:NERDTree.isTabTree()
        \) | q | endif

    " Open NERDTree at startup
    autocmd vimenter * NERDTree
augroup END

" Files to hide in NERDTree
let NERDTreeIgnore = ['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$',
                     \'\.o$', '__pycache__']


" Higlight NERDTree's filetypes with given color
function! NERDTreeHighlightFile(ext, color)
  exec 'autocmd filetype nerdtree highlight ' . a:ext.' ctermfg='. a:color
  exec 'autocmd filetype nerdtree syn match ' . a:ext.' #^\s\+.*'.  a:ext.'$#'
endfunction

" Apply above function to all file types
call NERDTreeHighlightFile('py', 'green')
call NERDTreeHighlightFile('json', 'blue')
call NERDTreeHighlightFile('js', 'yellow')
call NERDTreeHighlightFile('log', 'gray')
call NERDTreeHighlightFile('md', 'gray')
call NERDTreeHighlightFile('conf', 'red')
call NERDTreeHighlightFile('html', 'magenta')


" === NERDTree Git Plugin ===

" Prefixes for files with different git status
let g:NERDTreeIndicatorMapCustom = {
    \ 'Modified'  : '*',
    \ 'Staged'    : '+',
    \ 'Untracked' : '_',
    \ 'Renamed'   : '%',
    \ 'Unmerged'  : '═',
    \ 'Deleted'   : 'x',
    \ 'Dirty'     : '@',
    \ 'Clean'     : 'C',
    \ 'Ignored'   : '•',
    \ 'Unknown'   : '?'}

" === CSV.vim ===
augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat,*.CSV	setfiletype csv
augroup END

let g:vim_json_syntax_conceal = 0

let g:SimpylFold_docstring_preview = 1

" === PyDocstring ===
nmap <silent> <C-d> <Plug>(pydocstring)
