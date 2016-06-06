"==============
"appearance
"=============


"---------------------
"appearance-display
"---------------------
set t_Co=256
set background=dark

set scrolloff=5
set ruler
set title
set list
set number
set tabstop=4

set wildmenu
set showcmd
set laststatus=2
set whichwrap=b,s,h,l,<,>,[,]
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set cmdheight=2
highlight LineNr ctermfg=darkyellow
set shiftwidth=4

"-------------------
"apperance-setting
"------------------
set encoding=utf8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp
set noswapfile
set nobackup
set backspace=indent,eol,start
set clipboard=unnamed,autoselect
set smartcase
set hlsearch
set expandtab
set hidden
set showmatch
set smartindent
"set paste
set incsearch
set autoindent
set smarttab
set background=dark
set clipboard=unnamed,autoselect
"filetype plugin indent on 
"----------------------------
"apperance-particularly
"----------------------------

" 最後のカーソル位置を復元する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif


"=========================
"Plugin
"========================



"----------------
"dein
"dein use copy command of rsync.
"----------------
if &compatible
    set nocompatible
endif



" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif


call dein#begin(expand(s:dein_dir))
"you need to make vimproc.
call dein#add('Shougo/vimproc.vim')
"noecomplete is lua/dyn, vim version and machine installed lua
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')


call dein#add('itchyny/lightline.vim')
"neocomplete and lexima are conflict.
"call dein#add('cohama/lexima.vim')
call dein#add('kana/vim-smartinput')
call dein#add('tomasr/molokai')
call dein#add('thinca/vim-quickrun')
call dein#add('tomtom/tcomment_vim')
"Ruby Plugin
"call dein#add('bronson/vim-trailing-whitespace')

call dein#end()
filetype plugin indent on
colorscheme molokai
syntax on


"----------------
"Plugin-setting
"---------------


"NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_enable_camel_case_completion = 0
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

"quick-run
let g:quickrun_config = {
\   "_" : {
\        "hoOK/time/enable" : 1,
\       "outputter/buffer/split" : ":botright",
\       "hook/output_encode/enable" : 1,
\       "hook/output_encode/encoding" : "utf-8",
\   },
\   "g++14" : {
\       "command" : "g++",
\       "exec" : ['%c %o %s -o %s:p:r', '%s:p:r %a'],
\       "cmdopt" : "-std=c++14 -Wall",
\   },
\}

"================
"Key
"================





