if &compatible
    set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
    call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
    call dein#install()
endif
filetype plugin indent on
syntax enable

" Color scheme
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
colorscheme tokyonight

" NERDTree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeWinSize=25
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
    \ },
    \ 'component_function': {
    \       'cocstatus': 'coc#status',
    \       'gitbranch': 'FugitiveHead'
    \ },
    \ }
set noshowmode
set statusline^=%{coc#status()}
autocmd Filetype yaml setlocal shiftwidth=2 expandtab
autocmd Filetype go setlocal tabstop=4 expandtab!

" Rainbow parentheses
let g:rainbow_active=1

" Don't show line number in termianl mode
autocmd TermOpen * setlocal nonumber

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

"----------------------------------------
" Key mapping
"----------------------------------------
nnoremap j gj
nnoremap k gk
inoremap jj <Esc>:w<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" Move in insert mode
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-^> <HOME>
inoremap <C-4> <End>
" Tab
nnoremap tn :<C-u>tabnew<CR>
nnoremap tc :<C-u>tabc<Cr>
nnoremap th :<C-u>tabN<Cr>
nnoremap tl :<C-u>tabn<Cr>
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
noremap sh <C-w>h
" Key mapping w/ space
nnoremap <Space>s :%s/
nnoremap <Space>/ <S-i>// <ESC>
" Terminal mode
tnoremap jj <C-\><C-n>
" Vim Test
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
" Coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <Space>r <Plug>(coc-rename)
xmap <Space>f  <Plug>(coc-format)
nmap <Space>f  <Plug>(coc-format)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
	call CocActionAsync('doHover')
  else
	execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

