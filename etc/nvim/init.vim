if &compatible
	set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')
	call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
"	call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif
if dein#check_install()
	call dein#install()
endif
filetype plugin indent on
syntax enable

colorscheme molokai
"colorscheme srcery

" NERDTree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let g:nerdtree_tabs_open_on_console_startup=1

" Coc.nvim
let g:coc_global_extensions = [
    \ 'coc-css',
	\ 'coc-git',
    \ 'coc-go',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-rust-analyzer',
    \ 'coc-texlab',
    \ 'coc-tsserver'
    \ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" lightline
set laststatus=2
let g:lightline = {
    \ 'active': {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['gitbranch', 'filename', 'modified']
    \   ],
    \   'right': [
    \       ['filetype', 'fileencoding', 'lineinfo', 'percent']
    \   ],
    \   'component_function': {
    \       'cocstatus': 'coc#status',
    \       'gitbranch': 'FugitiveHead'
    \   },
    \ }
\ }
set noshowmode

" Rainbow parentheses
let g:rainbow_active=1

" termianlモードで行番号を表示しない
autocmd TermOpen * setlocal nonumber

" yankでclipboardにコピー
if system('uname -a | grep Microsoft') != ''
	augroup myyank
		autocmd!
		autocmd TextYankPost * :call system('clip.exe', @")
	augroup END
endif

" 文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" スクロールの余裕を確保する
set scrolloff=5
" 行番号を表示
set number
set relativenumber
" 現在の行を強調表示
set cursorline
hi clear CursorLine
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" コマンドラインの補完
set wildmode=list:longest
"構文に色付け
syntax on
set listchars=tab:>-,trail:~
set list
" Status message of coc.nvim
"set statusline^=%{coc#status()}
autocmd Filetype yaml setlocal shiftwidth=2 expandtab
autocmd Filetype go setlocal tabstop=4 expandtab!

"----------------------------------------
"キーマッピング
"----------------------------------------
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" インサートモードでjjと入力した場合はファイルの変更を保存する
inoremap jj <Esc>:w<CR>
" インサートモードでも移動
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-^> <HOME>
inoremap <C-4> <End>
"上下に空行を挿入
imap <S-CR> <END><CR>
inoremap <C-S-CR> <Up><End><CR>
nnoremap <S-CR> mzo<ESC>`z
nnoremap <C-S-CR> mzo<ESC>`z
" タブ関連
nnoremap tn :<C-u>tabnew<CR>
nnoremap tc :<C-u>tabc<Cr>
nnoremap th :<C-u>tabN<Cr>
nnoremap tl :<C-u>tabn<Cr>
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

noremap sh <C-w>h

" terminal mode
tnoremap jj <C-\><C-n>

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
nmap <Esc><Esc> :nohlsearch<CR><Esc>
