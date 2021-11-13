set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
    call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
    if has("mac")
        call dein#load_toml('~/.config/nvim/dein_macos.toml', {'lazy': 0})
    endif
    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
    call dein#install()
endif
filetype plugin indent on
syntax enable

colorscheme onedark
let g:onedark_terminal_italics = 1

"----------------------------------------
" Plugin settings
"----------------------------------------
" Coc.nvim
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-elixir',
    \ 'coc-git',
    \ 'coc-go',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-rust-analyzer',
    \ 'coc-tsserver',
    \ 'coc-yaml',
    \ 'coc-yank'
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
    \ 'colorscheme': 'onedark',
    \ }
set noshowmode
set statusline^=%{coc#status()}

" Rainbow parentheses
let g:rainbow_active=1

" fzf.vim
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --hidden --follow --ignore-case --no-heading --color always --glob "!.git/*" '.shellescape(<q-args>),
    \   1, fzf#vim#with_preview(), <bang>0
    \ )

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
autocmd TermOpen * setlocal nonumber
autocmd Filetype yaml setlocal shiftwidth=2 expandtab
autocmd Filetype go setlocal tabstop=4 expandtab!

"----------------------------------------
" Key mapping
"----------------------------------------
let mapleader = "\<Space>"
inoremap jj <Esc>:w<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Move in insert mode
" inoremap <C-j> <down>
" inoremap <C-k> <up>
" inoremap <C-h> <left>
" inoremap <C-l> <right>

" Buffers Tab and pane
nnoremap tn :tabnew<CR>
nnoremap tc :tabc<CR>
nnoremap th :tabN<CR>
nnoremap tl :tabn<CR>
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
noremap sh <C-w>h

" Key mapping w/ space
nnoremap <leader>s :%s/
nnoremap <leader>/ :s/^/\/\/ /<CR>:nohlsearch<CR>j
nnoremap <leader># :s/^/# /<CR>:nohlsearch<CR>j

" Terminal mode
tnoremap jj <C-\><C-n>

" Key mapping about plugins
" Vim Test
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
" Coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
command! -nargs=0 Fmt :call CocActionAsync('format')
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" fzf.vim
noremap <leader>g :Rg<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>h :History<CR>
noremap <leader>ff :Files<CR>
noremap <leader>ft :tabnew<CR>:Files<CR>
noremap <leader>fh <C-w>s<CR>:Files<CR>
noremap <leader>fv <C-w>v<CR>:Files<CR>

