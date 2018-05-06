"==============
"appearance
"=============


"---------------------
"appearance-display
"---------------------
set t_Co=256
"set termguicolors
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
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set cmdheight=2
highlight LineNr ctermfg=darkyellow
set shiftwidth=4

"-------------------
"apperance-setting
"------------------
"set encoding=utf8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp
set noswapfile
set nobackup
set backspace=indent,eol,start
set clipboard+=unnamedplus
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
set modifiable
set write
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
augroup MyAutoCmd
    autocmd!
augroup END

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ":p")
endif

if dein#load_state(s:dein_dir)
    let s:toml = '~/dotfiles/.dein.toml'
    let s:lazy_toml = '~/dotfiles/.dein_lazy.toml'
    call dein#begin(expand(s:dein_dir))
    "call dein#begin(expand(s:dein_dir))
    "toml loading
    call dein#load_toml(s:toml, {'lazy' : 0})
    call dein#load_toml(s:lazy_toml, {'lazy' : 1})
    call dein#end()
    call dein#save_state()
endif


if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax on


"================
"Key
"================

"Yを行末までのヤンクにする
nnoremap Y y$
"ESCキー連打でハイライトを消す
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

"置換の際のgオプションをデフォルトで有効化する
set gdefault
"保存時に行末の空白を削除する
autocmd BufWritePre * :%s/\s\+$//ge
"変換候補で一度に表示される数を設定する
set pumheight=10
"iTerm2やtmux上でもインサートモード時のカーソルの形状を変化させる
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"CUIでVimを使用した際に生じるEscキーのディレイを解消
if !has('gui_running')
    set timeout timeoutlen=1000 ttimeoutlen=50
endif
