call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0rp/ale'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-endwise'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'

" Load any extra plugins specified in the home directory
if filereadable(expand("~/.vim.plugins.local"))
  source ~/.vim.plugins.local
endif

call plug#end()

" enable extended % matching
packadd! matchit

filetype plugin indent on
syntax on
let mapleader = " "
set mouse=a " Enable mouse

" --- Saving ---
set hidden " Allow multiple unsaved buffers
set backspace=start,indent,eol
set backupdir=/var/tmp,~/.tmp,. " Don't clutter project dirs up with swap files
set directory=/var/tmp,~/.tmp,.
set shortmess+=A
set wildmode=list:longest " More logical path expansion
set backupcopy=yes " Fix hot reloading in Parcel

" --- Indenting ---
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 autoindent smartindent " tab is 2 spaces
set backspace=indent,eol,start " Back backspace work as expected
set nojoinspaces " Use only 1 space after "." when joining lines instead of 2
set list
set listchars=tab:→\ ,nbsp:⎵

" --- History ---
set history=1000 " Default is a miserly 20

" --- Layout ---
set number " Show line numbers
set scrolloff=3
set nowrap
set nofoldenable
set ruler
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-20.(line=%l\ of\ %L,col=%c%V%)\%h%m%r%=%-40(,%n%Y%)\%P%#warningmsg#%{SyntasticStatuslineFlag()}%*

" --- Status bar ---
let g:airline_left_sep = ""
let g:airline_left_alt_sep = ""
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ""
let g:airline_section_z = '%c, %l/%L'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tagbar#enabled = 0

" --- Display settings ---
set background=dark
colorscheme solarized
set cursorline " Highlight the line the cursor is on

let g:indent_guides_enable_on_vim_startup=1 " Turn on indent guide
let g:indent_guides_auto_colors=0
hi IndentGuidesEven ctermbg=0               " Nicer colors
                                            " Example

" wrap on txt files
:autocmd BufNewFile,BufRead *.txt,*.md set wrap

" --- Search ---
set hlsearch        " highlight search matches...
set incsearch       " ...as you type
set ignorecase      " Generally ignore case
set smartcase       " Care about case when capital letters show up

"  <Leader>f to fuzzy search files
map <silent> <leader>f :CtrlP<cr>

"  <Leader>F to fuzzy search files in the same directory as the current file
map <silent> <leader>F :CtrlPCurFile<cr>

"  <Leader>} to Search for a tag in the current project
map <silent> <leader>} :CtrlPTag<cr>

let g:ctrlp_show_hidden = 1

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif
"
" --- Spell check ---
set complete+=kspell
set spell
set spelllang=en_gb

" --- Lint  settings ---
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

" --- git gutter ---
" Set the git gutter colors to be the same as the number column
hi clear SignColumn

" Set the Gutter to show all the time, avoiding the column 'pop' when saving
set signcolumn=yes
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '~'
let g:gitgutter_max_signs = 1000

" --- Keyboard mappings ---

" Turn off arrow keys to discourage bad habits
noremap <Left> :echoe "Use h"<CR>
noremap <Right> :echoe "Use k"<CR>
noremap <Up> :echoe "Use k"<CR>
noremap <Down> :echoe "Use j"<CR>

" Easier NERDTree access
let NERDTreeQuitOnOpen = 1
map <silent> <C-n> :NERDTreeFocus<CR>

" Easier Window movement
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Disable Ex Mode to remove confusion
nnoremap Q <Nop>

" make W and Q act like w and q
command! W :w
command! Q :q
command! Qa :qa

" make Y consistent with C and D
nnoremap Y y$

" <leader>. to view all document buffers
nmap <silent> <unique> <Leader>b :BufExplorer<CR>

" Double leader to switch to the previous buffer
map <silent> <unique> <Leader>< :b#<CR>

" Replace the default U (undo last line) to Redo for speedyness
nmap U <c-r>

" Any local config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
