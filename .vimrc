" setting
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
" カラースキーム
"colorscheme molokai
colorscheme srcery

" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
hi clear CursorLine
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
"構文に色付け
syntax on

"----------------------------------------
"キーマッピング
"----------------------------------------
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" インサートモードでjjと入力した場合はファイルの変更を保存する
inoremap jj <Esc>:<C-u>w<CR>
" インサートモードでも移動
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>
" 括弧等の補完
inoremap {<ENTER> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap < <><Left>
inoremap [ []<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap <C-b> <End>;
" タブ関連
nnoremap tc :<C-u>tabc<Cr>
nnoremap tl :<C-u>tabn<Cr>
nnoremap th :<C-u>tabN<Cr>

" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" 改行時に前の行のインデントを継続する
set autoindent
" インデントはスマートインデント
set smartindent
" マウス操作を有効にする
set mouse=a

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

set nocompatible
filetype plugin indent off

" rainbow parenthesesの設定
let g:rainbow_active = 1
filetype plugin indent on
