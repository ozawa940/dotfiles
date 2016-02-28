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
"NeoBundle
"----------------

if has('vim_starting')
        set nocompatible
        " neobundle をインストールしていない場合は自動インストール
        if !isdirectory(expand("~/.vims/bundle/neobundle.vim/"))
        echo "install neobundle..."
        " vim からコマンド呼び出しているだけ neobundle.vim のクローン
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vims/bundle/neobundle.vim")
        endif
        " runtimepath の追加は必須
        set runtimepath+=~/.vims/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vims/bundle'))
let g:neobundle_default_git_protocol='https'


NeoBundle "Shougo/neocomplete.vim"
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'lexima.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'thinca/vim-quickrun'


"Ruby Plugin
NeoBundle 'bronson/vim-trailing-whitespace'

NeoBundleCheck

call neobundle#end()



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

"================
"Key
"================





