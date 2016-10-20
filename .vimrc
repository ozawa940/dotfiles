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
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
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
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
"noecomplete is lua/dyn, vim version and machine installed lua
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimshell.vim')

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

if dein#check_install()
    call dein#install()
endif

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
\       "hoOK/time/enable" : 1,
\       "outputter/buffer/split" : ":botright",
\       "hook/output_encode/enable" : 1,
\       "hook/output_encode/encoding" : "utf-8",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 10,
\       "outputter/buffer/clone_on_empty" : 1,
\   },
\   "g++14" : {
\       "command" : "g++",
\       "exec" : ['%c %o %s -o %s:p:r', '%s:p:r %a'],
\       "cmdopt" : "-std=c++14 -Wall",
\   },
\}


"Unite.vim
let g:unite_enable_start_insert = 1
"grep検索
nnoremap <silent> ,g  : <C-u>Unite grep: -buffer-name=search-buffer<CR>
"カーソル位置の単語をgrep検索
nnoremap <silent> ,cg : <C-u>Unite grep: -buffer-name=search-buffer<CR><C-R><C-W>
"grep検索結果の再呼び出し
nnoremap <silent> ,r  : <C-u>UniteResume search-buffer<CR>
"大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case  = 1
"unite grepにag(The Silver Searcher)を使う
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif
"バッファー一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=file file<CR>
nnoremap <silent> ,ud :<C-u>Unite file<CR>
"レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
"常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')







"================
"Key
"================

"挿入モード時のキー異同
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>




