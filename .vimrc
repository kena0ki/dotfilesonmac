" 一旦ファイルタイプ関連を無効化する
filetype off

" --------------------
" Plugin
" --------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

call map(dein#check_clean(), "delete(v:val, 'rf')")

" apply mxw/vim-jsx to js
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" Enable <ALT> key https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
""""""""""""""""""""""""""""""
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set timeout ttimeoutlen=50
""""""""""""""""""""""""""""""

" --------------------
" Configuration
" --------------------
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
"set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
"set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" 矩形選択モードで行末の先までカーソルを移動できるように
set virtualedit+=block
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
"set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
"シンタックスハイライトON
syntax on
"ステータスライン設定
set statusline=%F       "fullpath of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file


" Tab系
" 不可視文字を可視化
"   tab：タブ文字
"   trail：行末のスペース
"   nbsp：ノーブレークスペース
"   eol：改行
set list listchars=tab:»-,trail:-,nbsp:% ",eol:↲
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
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
"nmap <Esc><Esc> :nohlsearch<CR><Esc>
" ビジュアルモード選択した部分を*で検索 http://webtech-walker.com/archive/2009/01/18022957.html
vnoremap * "zy:let @/ = @z<CR>n

" コピペ系
" ヤンク＆ペーストにクリップボードを使う
"set clipboard=unnamedplus
"" 範囲選択でコピー
"set clipboard+=autoselectplus

" 制御系
" バックスペースを自然な動きに
set backspace=2
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
"左右のカーソル移動で行間移動可能にする。
set whichwrap=b,s,<,>,[,]
"find時にタブでファイル選択
set wildmenu
""setting working directory to the current file
"set autochdir
" netrwのカレントディレクトリとブラウジングディレクトリを統一
let g:netrw_keepdir=0
" 内部の文字コード
set encoding=utf-8
" ファイルの文字コード
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
" 改行コード
set fileformats=unix,dos,mac

"move line up and down
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" completion
set omnifunc=syntaxcomplete#Complete

"-- FOLDING --
set foldmethod=syntax "syntax highlighting items specify folds
set foldcolumn=1 "defines 1 col at window left, to indicate folding
let javaScript_fold=1 "activate folding by JS syntax
set foldlevelstart=99 "start file with all folds opened

" filetype for react. https://github.com.cnpmjs.org/vim/vim/issues/4830
au BufNewFile,BufRead *.jsx  setf javascript
au BufNewFile,BufRead *.tsx  setf typescript

" for tools watching files. http://tokkaka.hatenablog.com/entry/2016/03/15/235655
set backupcopy=yes

" disable auto insert (i_Ctrl_@)
inoremap <C-@> `

" add closing brace
inoremap {<C-m> {<C-m><C-m>}<C-o>k<C-h><C-m>

" https://stackoverflow.com/a/47361068/12895553
" Disable parentheses matching depends on system. This way we should address all cases (?)
set noshowmatch
" NoMatchParen " This doesnt work as it belongs to a plugin, which is only loaded _after_ all files are.
" Trying disable MatchParen after loading all plugins
function! g:FckThatMatchParen ()
    if exists(":NoMatchParen")
        :NoMatchParen
    endif
endfunction
augroup plugin_initialize
    autocmd!
    autocmd VimEnter * call FckThatMatchParen()
augroup END




" filetypeの自動検出(最後の方に書いた方がいいらしい)
filetype plugin on

