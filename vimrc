if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak'}}
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'tomasr/molokai'

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 50

let g:vimfiler_edit_action = 'tabopen'

nnoremap [unite] <Nop>
nmap <Leader><Leader> [unite]
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>VimFiler -split -simple -winwidth=50 -toggle -quit<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nmap [unite]h [unite-history]
nnoremap <silent> [unite-history]c :<C-u>Unite history/command<CR>
nnoremap <silent> [unite-history]s :<C-u>Unite history/search<CR>
nmap [unite]r [unite-ref]
nnoremap <silent> [unite-ref]p :<C-u>Unite ref/perldoc<CR>

nnoremap <Leader>t :tabnext<CR>
nnoremap <Leader>T :tabprevious<CR>

filetype plugin indent on
syntax on

NeoBundleCheck

colorscheme molokai

set encoding=utf-8
scriptencoding utf-8

set number
set relativenumber
set ruler

set hlsearch

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set backspace=indent,eol,start


nnoremap ; :
nnoremap : ;

if has('mouse')
  set mouse=a
endif
