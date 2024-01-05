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

autocmd bufenter set colorcolumn=0  " Don't show colorcolumn by default
autocmd FileType python set colorcolumn=89  " Highlight 89th column for python files

set cursorline  " Highlight current line
set fillchars=vert:🭰,fold:-,eob:\ ,

set splitbelow  " Vertical split splits below the current buffer
set splitright  " Horizontalsplit splits at the right of the current buffer

set nowrap  " Disable line wrap
set noswapfile  " Disavle swap file

set confirm  " Always ask for saving changes

set background=dark  " Use dark UI

set diffopt+=vertical  " Use vertical split for diffs

set list  " Show unprintable chars
set listchars=tab:>-,trail:•,extends:#,nbsp:•  " List of chars to show

set history=100  " Remember 100 last commands
set undolevels=100  " Use more levels of undo

set nofoldenable  " Don't fold by default
set foldmethod=indent  " Fold based on indentation
set foldnestmax=5  " Maximum fold level

set scrolloff=4  " Keep 4 lines above and below while scrolling

highlight NonText ctermfg=0

" ============================== ABBREVIATIONS ===============================
cnoreabbrev Qa qa
cnoreabbrev QA qa
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa
cnoreabbrev WQa wqa
cnoreabbrev WQA wqa

" =================================== KEYS ===================================

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Change buffer width
nnoremap <Esc>> :vertical res +1<Enter>
nnoremap <Esc>< :vertical res -1<Enter>

" Change buffer height
nnoremap <Esc>+ :res +1<Enter>
nnoremap <Esc>- :res -1<Enter>

" Use H and L to move at the beggining and at the end of the line
nnoremap L $
nnoremap H ^

" Set Space as leader key
let mapleader = ' '

" Open this file on F12
nnoremap <F12> :vsplit ~/.vimrc <CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

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

" This is important for COC and ALE work together
let g:ale_disable_lsp = 1

" ================================== PLUGINS =================================
call plug#begin('~/.vim/plugged')

  " Commnet/uncomment the code
  Plug 'tpope/vim-commentary'

  " Quoting/parenthesizing made simple
  Plug'tpope/vim-surround'

  " Enable repeating supported plugin maps with '.'
  Plug 'tpope/vim-repeat'

  " Camelcase, undersore, acronym words motions
  Plug 'chaoren/vim-wordmotion'

  " Fuzzy funder
  Plug 'junegunn/fzf.vim'

  " Asynchronous linting/fixing
  Plug 'dense-analysis/ale'

  " Working with CSV files
  Plug 'chrisbra/csv.vim'

  " Copy link to line in repo
  Plug 'biggerfisch/vim-gurl'

  " A tree file system explorer
  Plug 'scrooloose/nerdtree'

  " Displays tags in a window, ordered by scope
  Plug 'majutsushi/tagbar'

  " === Git ===

  " A Git wrapper
  Plug 'tpope/vim-fugitive'

  " Shows a git diff in the gutter (sign column) and stages/undoes hunks
  Plug 'airblade/vim-gitgutter'

  " A plugin of NERDTree showing git status
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Autocompletion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " GitHub Copilot
  Plug 'github/copilot.vim'

  " === Python ===

  " Python docstring generator
  Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

  " Enhanced syntax highlightitng
  Plug 'sheerun/vim-polyglot'

  " No-BS Python code folding
  Plug 'tmhedberg/SimpylFold'

  " Syntax highlight for requerements.txt
  Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

  " === UI ===

  " Retro groove color scheme
  Plug 'morhetz/gruvbox'

  " Rainbow delimiters
  Plug 'luochen1990/rainbow'

  " Lean & mean status/tabline
  Plug 'bling/vim-airline'

  " Visually displaying indent levels
  Plug 'Yggdroot/indentLine'

call plug#end()

" =============================== PLUGINS SETUP ==============================


" === Rainbow ===
let g:rainbow_active = 1


" === Tagbar ===
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0


" === Indent lines ===
let g:indentLine_char = '🭰'


" === Theme ===
colorscheme gruvbox
let g:gruvbox_italic = 1
set background=dark


" === Airline ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#virtualenv#enabled = 1

function! AirlineInit()
    let g:airline_section_a = airline#section#create_left(['branch'])
    let g:airline_section_b = airline#section#create_left(['file'])
    let g:airline_section_c = airline#section#create_left(['tagbar'])
    let g:airline_section_x = airline#section#create_left(['readonly'])
    let g:airline_section_z = airline#section#create_right(['%l:%c/%L'])
endfunction

autocmd VimEnter * call AirlineInit()


" === Colorizer ===
let g:colorizer_auto_color = 1


" === Ale ===
map <C-f> :ALEFix <CR>
let g:ale_list_window_size = 5
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
\ 'python': ['ruff', 'black', 'mypy'],
\ 'md': ['mdl'],
\ 'yaml': ['yamllint'],
\ 'yml': ['yamllint'],
\}
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python': ['black', 'isort', 'ruff'],
\ 'yaml': ['yamlfix'],
\ 'yml': ['yamlfix'],
\ 'json': ['jq']
\}

nnoremap <C-]> :ALENext<CR>
nnoremap <C-[> :ALEPrevious<CR>


" === GitGutter ===
nnoremap <C-p> :GitGutterPrevHunk<CR>
nnoremap <C-n> :GitGutterNextHunk<CR>
nnoremap U :GitGutterUndoHunk <CR>
highlight SignColumn ctermbg=bg
highlight GitGutterAdd    ctermfg=2 ctermbg=bg
highlight GitGutterChange ctermfg=3 ctermbg=bg
highlight GitGutterDelete ctermfg=1 ctermbg=bg
highlight GitGutterChangeDelete ctermfg=166 ctermbg=bg
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_sign_modified_removed = '~͟'
let g:gitgutter_sign_removed_above_and_below = '_͞'


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
\ 'ctrl-v': 'vsplit',
\ 'ctrl-a': 'select-all'
\}

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, ' --ignore-dir={node_modules,fme,venv,jest_cache,logs} --ignore=package-lock.json', fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" === NERDTree ===
map <F2> :NERDTreeToggle<CR>
nmap F :NERDTreeFind<CR>

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
                     \'\.o$', '__pycache__', '.git', 'venv']

let NERDTreeHighlightCursorline = 0
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" Higlight NERDTree's filetypes with given color
function! NERDTreeHighlightFile(ext, color)
  exec 'autocmd filetype nerdtree highlight ' . a:ext.' ctermfg='. a:color
  exec 'autocmd filetype nerdtree syn match ' . a:ext.' #^\s\+.*'.  a:ext.'$#'
endfunction

" Apply above function to all file types
call NERDTreeHighlightFile('css', 5)
call NERDTreeHighlightFile('csv', 8)
call NERDTreeHighlightFile('geojson', 10)
call NERDTreeHighlightFile('html', 166)
call NERDTreeHighlightFile('ipynb', 12)
call NERDTreeHighlightFile('js', 3)
call NERDTreeHighlightFile('json', 2)
call NERDTreeHighlightFile('less', 13)
call NERDTreeHighlightFile('log', 7)
call NERDTreeHighlightFile('md', 6)
call NERDTreeHighlightFile('MD', 6)
call NERDTreeHighlightFile('rst', 14)
call NERDTreeHighlightFile('mjml', 208)
call NERDTreeHighlightFile('mjs', 11)
call NERDTreeHighlightFile('py', 4)
call NERDTreeHighlightFile('scss', 13)
call NERDTreeHighlightFile('sh', 1)
call NERDTreeHighlightFile('sql', 9)
call NERDTreeHighlightFile('ts', 11)
call NERDTreeHighlightFile('spec.ts', 8)
call NERDTreeHighlightFile('xml', 15)
call NERDTreeHighlightFile('yaml', 'magenta')
call NERDTreeHighlightFile('yml', 'magenta')

let g:NERDTreeMinimalMenu=1

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


" === COC  ===
let g:coc_global_extensions = ['coc-tsserver', 'coc-jedi']

" Remap keys for applying codeAction to the current line.
nmap <leader>a  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>f  <Plug>(coc-fix-current)

" Completion
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Prettify selected code.
xmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

let g:python_highlight_all = 1

" Use (Shift-)TAB to iterate through autocomplete list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" ======== Vim Gurl ======================
let g:vimgurl_yank_register = '+'  " copy to system buffer

" ======== GitHub Copilot ======================
nmap <silent> gp :Copilot panel<CR>
imap <silent><script><expr> <C-Space> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
