"----------------------------------------
" General settings
"----------------------------------------
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set mouse=a
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set scrolloff=5
set number
set relativenumber
set cursorline
hi clear CursorLine
set virtualedit=onemore
set visualbell
set showmatch
set wildmode=list:longest
syntax on
set listchars=tab:>-,trail:~
set list

" Color scheme 
"colorscheme molokai
"colorscheme srcery

"----------------------------------------
" Key mapping
"----------------------------------------
nnoremap j gj
nnoremap k gk
inoremap jj <Esc>:w<Enter>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>
nnoremap tc :<C-u>tabc<Cr>
nnoremap tl :<C-u>tabn<Cr>
nnoremap th :<C-u>tabN<Cr>
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

