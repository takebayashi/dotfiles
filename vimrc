if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make -f make_mac.mak', 'linux': 'make', 'unix': 'make -f make_unix.mak'}}
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-build'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/a.vim'
call neobundle#end()

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
nnoremap <silent> [unite]b :<C-u>Unite buffer -no-split<CR>
nnoremap <silent> [unite]m :<C-u>Unite build -no-split<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -no-split -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]G :<C-u>Unite grep:. -no-split -buffer-name=search-buffer<CR><C-R><C-W><CR>

nmap [unite]h [unite-history]
nnoremap <silent> [unite-history]c :<C-u>Unite history/command<CR>
nnoremap <silent> [unite-history]s :<C-u>Unite history/search<CR>

nmap [unite]r [unite-ref]
nnoremap <silent> [unite-ref]pl :<C-u>Unite ref/perldoc<CR>

nmap [unite]R [unite-resume]
nnoremap <silent> [unite-resume]g :<C-u>UniteResume search-buffer<CR>

nnoremap <Leader>t :tabnext<CR>
nnoremap <Leader>T :tabprevious<CR>

filetype plugin indent on
syntax on

NeoBundleCheck

set background=dark
colorscheme solarized

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

set nobackup
set noundofile

nnoremap ; :
nnoremap : ;

if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

if has('mouse')
  set mouse=a
endif
