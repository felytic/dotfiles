" ================================== GENERAL =================================

set wildmenu  " Better command-line completion
set lazyredraw  " Redraw only when we need to

set relativenumber  " Enable relative line numbers
set number  " Display current line number

set tabstop=2  " Number of visual spaces per TAB
set softtabstop=2   " Number of spaces in tab when editing
set shiftwidth=2  " Number of spaces inserted on TAB press
set expandtab  " Insert spaces instead of tabs

set incsearch  " Show search matches as you type
set hlsearch  " Highlight all search matches
set ignorecase  " Use case insensitive search
set smartcase  " Except when using capital letters

set encoding=utf-8  " Default encoding is UTF-8
scriptencoding utf-8

set colorcolumn=80  " Highlight 80th column
set cursorline  " Highlight current line

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
map <F9> obreakpoint()<C-c>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Use kj or jk for exit Insert mode, also move cursor rigth
inoremap jk <Esc>
inoremap kj <Esc>

" Use double space for save
nnoremap <leader><leader> :w <CR>

" ================================== PLUGINS =================================
call plug#begin('~/.vim/plugged')

  " Commnet/uncomment the code
  Plug 'tpope/vim-commentary'

  " Quoting/parenthesizing made simple
  Plug'tpope/vim-surround'

  " Enable repeating supported plugin maps with '.'
  Plug 'tpope/vim-repeat'

  " Auto-completion for quotes, parens, brackets, etc.
  Plug 'jiangmiao/auto-pairs'

  " Camelcase, undersore, acronym words motions
  Plug 'chaoren/vim-wordmotion'

  " Fuzzy funder
  Plug 'junegunn/fzf.vim'

  " Asynchronous linting/fixing
  Plug 'dense-analysis/ale'

  " " Perform all insert mode completions with Tab
  Plug 'ervandew/supertab'

  " Working with CSV files
  Plug 'chrisbra/csv.vim'

  " " JSON plugin
  " Plug 'elzr/vim-json'

  " Copy link to line in repo
  Plug 'vitapluvia/vim-gurl'

  " === Extra buffers ===

  " A tree file system explorer
  Plug 'scrooloose/nerdtree'

  " Displays tags in a window, ordered by scope
  Plug 'majutsushi/tagbar'

  " Nginx syntax
  Plug 'chr4/nginx.vim'

  " === Git ===

  " A Git wrapper
  Plug 'tpope/vim-fugitive'

  " Shows a git diff in the gutter (sign column) and stages/undoes hunks
  Plug 'airblade/vim-gitgutter'

  " A plugin of NERDTree showing git status
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Autocompletion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " " === JavaScript
  Plug 'yuezk/vim-js'

  " === Python ===
  " Autocompletion
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'davidhalter/jedi-vim'

  " Python docstring generator
  Plug 'heavenshell/vim-pydocstring'

  " Python indent
  " Plug 'Vimjas/vim-python-pep8-indent'

  " Enhanced syntax highlightitng
  Plug 'vim-python/python-syntax'

  " Sort imports
  Plug 'tweekmonster/impsort.vim'

  " === YAML ===
  " YAML formatter
  Plug 'tarekbecker/vim-yaml-formatter'

  " YAML folder
  Plug 'pedrohdz/vim-yaml-folds'

  " === UI ===

  " Retro groove color scheme
  Plug 'morhetz/gruvbox'

  " Rainbow delimiters
  Plug 'luochen1990/rainbow'

  " Lean & mean status/tabline
  Plug 'bling/vim-airline'

  " Visually displaying indent levels
  Plug 'nathanaelkane/vim-indent-guides'

  " No-BS Python code folding
  Plug 'tmhedberg/SimpylFold'

  " A plugin to color colornames and codes
  Plug 'chrisbra/Colorizer'

call plug#end()

" =============================== PLUGINS SETUP ==============================


" === Rainbow ===
let g:rainbow_active = 1


" === Tagbar ===
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0


" === Indent lines ===
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235


" === Gruvbox ===
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox


" === Airline ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

function! AirlineInit()
    let g:airline_section_a = airline#section#create_left(['branch'])
    let g:airline_section_b = airline#section#create_left(['file'])
    let g:airline_section_c = airline#section#create_left(['tagbar'])
    let g:airline_section_x = airline#section#create_left(['readonly'])
    let g:airline_section_z = airline#section#create_right(['%l/%L'])
endfunction

autocmd VimEnter * call AirlineInit()


" === Colorizer ===
let g:colorizer_auto_color = 1


" === Ale ===
map <C-f> :ALEFix <CR>
let g:ale_list_window_size = 5
let g:ale_open_list = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_python_vulture_options = "--exclude venv/,tests/,migrations/ --min-confidence 100"
let g:ale_linters = {
\ 'python': ['flake8', 'vulture'],
\ 'javascript': ['eslint'],
\}
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python': ['autopep8', 'yapf', 'remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['eslint']
\}


" === Supertab ===
let g:SuperTabDefaultCompletionType = '<c-n>'


" === Deoplete ===
let g:deoplete#enable_at_startup = 1


" === GitGutter ===
nnoremap <C-p> :GitGutterPrevHunk<CR>
nnoremap <C-n> :GitGutterNextHunk<CR>
nnoremap U :GitGutterUndoHunk <CR>


" === FZF ===
map <F5> :Ag <CR>
map <F6> :GFiles <CR>
nnoremap <F7> :Ag <C-R><C-W><CR>

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
\ 'ctrl-v': 'vsplit'
\}

" let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'


" === NERDTree ===
map <F2> :NERDTreeToggle<CR>

let NERDTreeMapJumpParent='h'
let NERDTreeMapOpenSplit='<S-TAB>'
let NERDTreeMapOpenVSplit='<TAB>'
let NERDTreeShowHidden=1

augroup vimrc
    " Close vim when only NERDTree is open
    autocmd bufenter * if (
        \winnr("$") == 1 &&
        \exists("b:NERDTree") &&
        \b:NERDTree.isTabTree()
        \) | q | endif
augroup END

" Files to hide in NERDTree
let NERDTreeIgnore = ['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$',
                     \'\.o$', '__pycache__', '.git', 'venv', '.cache']

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
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

" === PyDocstring ===
nmap <silent> <C-d> <Plug>(pydocstring)


" === COC ===
let g:coc_global_extensions = ['coc-python', 'coc-json', 'coc-tsserver']
nmap <silent> <leader>g <Plug>(coc-definition)
nmap <silent> <leader>u <Plug>(coc-references)
nmap <leader> <leader>r <Plug>(coc-rename)
