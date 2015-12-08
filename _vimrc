scriptencoding utf-8

" -*-*-*- [ NeoBundle Config Begin ] -*-*-*- 
if has("vim_starting")
    if has("win32") || has("win64")

        set nocompatible               " Be iMproved
        " Required:
        " パスの指定はUnix式・Windows式のいずれでも動作するみたい
"       set runtimepath+=~/editor/vim74/bundle/neobundle.vim/
        set runtimepath+=%USERPROFILE%\editor\vim74\bundle\neobundle.vim

    elseif has("unix")

        set nocompatible               " Be iMproved
        " Required:
        set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/

    elseif has("macunix")

        set nocompatible               " Be iMproved
        " Required:
        set runtimepath+=~/.vim/bundle/neobundle.vim/

    endif
endif

if has("win32") || has("win64")
    " Required:
    " Windows式でも expand の引数にできるが、環境変数を使う場合で、
    " % が文字列の先頭に来る場合、空白を直前に入れておかないと、
    " expand関数内部で変換子として解釈されてしまう。
"   call neobundle#begin(expand('~/editor/vim74/bundle/'))
    call neobundle#begin(expand(' %USERPROFILE%\editor\vim74\bundle\'))
elseif has("unix")
    " Required:
    call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))
elseif has("macunix")
    " Required:
    call neobundle#begin(expand('~/.vim/bundle/'))
endif

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin'  : 'make -f make_cygwin.mak',
            \     'mac'     : 'make -f make_mac.mak',
            \     'unix'    : 'make -f make_unix.mak',
            \    },
            \ }
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
" TODO Try this later...
"NeoBundle 'Shougo/unite-build'

NeoBundle 'scrooloose/nerdtree'

" Word Completion:
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" Toggle comment-out with <Leader>c 
NeoBundle 'tyru/caw.vim'

" Colorschemes: 
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
"NeoBundle 'chriskempson/colors'
NeoBundle 'chriskempson/base16-vim'

" Preview each colorscheme: ':Unite colorscheme -auto-preview -winheight=10'
NeoBundle 'ujihisa/unite-colorscheme'

" Statusline: 
"NeoBundle 'bling/vim-airline'
NeoBundle 'itchyny/lightline.vim'

" Documents: 
NeoBundle 'vim-jp/vimdoc-ja'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
" -*-*-*- [ NeoBundle Config End ] -*-*-*- 

" -*-*-*- [ Quickrun Config Begin ] -*-*-*- 
let g:quickrun_config = {
            \   "_" : { 
            \       "outputter/buffer/split" : "aboveleft 10sp",
            \       "runner" : "vimproc",
            \       "runner/vimproc/sleep" : 0,
            \       "runner/vimproc/updatetime" : 40,
            \   },
            \}

" Ctrl+c to suspend quickrun running currently 
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() :
\                                                     "\<C-c>"
" .cファイルの既定値
let g:quickrun_config.c = {
\   "type" : 'c/gcc',
\   "cmdopt" : '-std=c99 -Wall -Wextra -Wpedantic',
\}

" :Quickrun c/clang として実行した場合に適用される
let g:quickrun_config['c/clang'] = {
\   "cmdopt" : '-std=c99 -Weverything -Wextra -Wpedantic',
\}

" .cppファイルの既定値
let g:quickrun_config.cpp = {
\   'type'   : 'cpp/g++',
\   'cmdopt' : '-std=c++11 -Wall -Wextra -Wpedantic',
\}

" :Quickrun c/clang++ として実行した場合に適用される
let g:quickrun_config['cpp/clang++'] = {
\   'type'   : 'cpp/clang++',
\   'cmdopt' : '-std=c++11 -Weverything -Wextra -Wpedantic',
\}
" -*-*-*- [ Quickrun Config End ] -*-*-*- 

" -*-*-*- [ Unite.vim Config Begin ] -*-*-*-
"let g:unite_enable_start_insert=1
let g:unite_source_file_mru_limit=200
"nnoremap <C-U><C-B> :Unite -buffer-name=buffer&file@Unite buffer file<CR>
nnoremap <silent> ,ub :<C-u>Unite -buffer-name=buffer&file@Unite buffer file<CR>

"nnoremap <C-U><C-F> :Unite -buffer-name=file@Unite file<CR>
"nnoremap <C-U><C-F> :UniteWithCurrentDir -buffer-name=file@Unite file<CR>
"nnoremap <C-U><C-F> :UniteWithBufferDir -buffer-name=file@Unite file<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=file@Unite file<CR>

"nnoremap <C-U><C-R> :Unite -buffer-name=MRU@Unite file_mru<CR>
nnoremap <silent> ,um :<C-u>Unite -buffer-name=MRU@Unite file_mru<CR>

"nnoremap <C-U><C-Y> :Unite -buffer-name=register@Unite register<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register@Unite register<CR>
" -*-*-*- [ Unite.vim Config End ] -*-*-*-

" -*-*-*- [ NERDTree Config Begin ] -*-*-*-
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" -*-*-*- [ NERDTree Config End ] -*-*-*-

" -*-*-*- [ neocompletion Config Begin ] -*-*-*-
" validate completion
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1

" Do NOT skip even when completion takes long time
let g:neocomplete#skip_auto_completion_time = ""

" ADDED @ 2015 02 01 NEW FEATURES"
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Plugin key-mappings.
inoremap <expr><C-g>    neocomplete#undo_completion()
inoremap <expr><C-l>    neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
" -*-*-*- [ neocompletion Config End ] -*-*-*-

" -*-*-*- [ neosnippet Config Begin ] -*-*-*-
" スニペットファイルのディレクトリを指定する 
if has("win32") || has("win64")
    let g:neosnippet#snippets_directory='%USERPROFILE%\editor\vim74\bundle\.vim\neosnippets'
elseif has("unix")
    " パスを引用符で囲まなければエラーが出た。
    let g:neosnippet#snippets_directory='~/dotfiles/.vim/neosnippets'
    " エラーが出る
"    let g:neosnippet#snippets_directory='./.vim/neosnippets'
endif

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Plugin key-mappings.(Ctrl-k でスニペットを展開する)
imap <C-k>      <Plug>(neosnippet_expand_or_jump)
smap <C-k>      <Plug>(neosnippet_expand_or_jump)
xmap <C-k>      <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\   "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Open the snippet file
nnoremap <silent> ,nse :NeoSnippetEdit -split -horizontal -direction=botright<CR>
" -*-*-*- [ neosnippet Config End ] -*-*-*-

" -*-*-*- [ Caw.vim Config Begin ] -*-*-*-
" Mapping to switch comment-out
" \c to comment-out
" \c again to cancel comment-out
" \c to comment-out multiple lines after selecting them works too.
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)

" \c to cancel comment-out
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)

" to NOT append extra spaces
let g:caw_i_sp=""
let g:caw_I_sp=""
" -*-*-*- [ Caw.vim Config End ] -*-*-*-

" -*-*-*- [ General Config Begin] -*-*-*- 
syntax enable           " or 'syntax on'
set nobackup            " ファイル上書き時のバックアップを取らない
set smartindent         " 高度な自動インデント
set backspace=2         " set backspace=indet,eol,start
set shiftwidth=4        " 自動インデント時の空白の数 
set tabstop=4           " tab文字を空白何文字分で表現するか
set softtabstop=4       " tabキー押下時に挿入される空白量
set expandtab           " タブ文字ではなく空白文字を使う"
set history=1000        " コマンドと検索の履歴保存数 
set number              " 行番号を表示 
set list                " 改行やタブ文字を可視化する 
set ruler               " 現在のカーソルの位置を表示する 
set hlsearch            " 検索パターンに適合した文字列を強調表示 
set showcmd             " コマンドを画面の最下行に表示する 
set laststatus=2        " いつステータス行を表示するか(lightline.vim で必要)
" -*-*-*- [ General Config End] -*-*-*- 

" -*-*-*- [ General Key Mapping Config Begin ] -*-*-*- "
imap <F1> " -*-*-*-   -*-*-*- <ESC>9hi
imap <F2> /*----------TEST-----------*/<ESC>11hi
nmap <F3> :s///g<Left><Left><Left><Left><Left>
nmap <F4> :%s///g<Left><Left><Left>
imap <F5> %3d
map <F7> i{<Esc>ea}<Esc>
" set the directory currently opening file as current directory.
cmap <F9> :cd %:h<CR> 

" C-space to ESC
"imap <C-Space> <ESC>

" SPACE to scroll the screen
"nnoremap <Space> <PageDown>
" SHIFT+SPACE to scroll the screen backward
"nnoremap <S-Space> <PageUP>

" CTRL-hjkl to move the active window
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

imap {}  {}<Left><CR><Up><ESC>$a<CR>
imap {  {}<Left>
imap [  []<Left>
imap (  ()<Left>
imap <> <><Left>
"imap ''  ''<Left>
imap '   '<ESC>vypi
"imap ""  ""<Left>
imap "  "<ESC>vypi
"imap ``  ``<Left>
imap `  `<ESC>vypi

" move the bracket corespond to the current bracket 
nnoremap [ %
nnoremap ] %
" -*-*-*- [ General Key Mapping Config End ] -*-*-*- "
"
" -*-*-*- [ Font Config Begin ] -*-*-*- "
if has("gui_running")
    if has("gui_gtk2")
        "set guifont=Luxi\ Mono\ 12
        "set guifont=Inconsolata\ 11
        set guifont=Ricty\ Discord\ 11
    elseif has("x11")
        " Also for GTK 1
        set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_win32")
        "set guifont=Luxi_Mono:h12:cANSI
        set guifont=MeiryoKe_Console:h12:cSHIFTJIS
    endif
endif
" -*-*-*- [ Font Config End ] -*-*-*- "

" -*-*-*- [ Colorscheme Config Begin ] -*-*-*- "
set t_Co=64
"set t_Co=256       " cmd(Windows)では表示がおかしくなる 

function! s:has_colorscheme(name)
    let pat = 'colors/' . a:name . '.vim'
    return !empty(globpath(&rtp, pat))
endfunction

if s:has_colorscheme('solarized') && !(has('win32') || has('win64'))
    let g:solarized_termcolors=256
    set background=dark
    colorscheme solarized
    " Setting for lightline.vim 
    let g:lightline = {
\       'colorscheme' : 'solarized',
\   }
else
    colorscheme industry
"    let g:lightline = {
"\       'colorscheme' : 'industry',
"\   }
endif
" -*-*-*- [ Colorscheme Config End ] -*-*-*- "

" -*-*-*- [ Shell Script Config Begin ] -*-*-*- "
" タブ幅やインデント時の空白を2個にする
function! s:sh()
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2
endfunction

augroup vimrc-sh
    autocmd!
    autocmd Filetype sh call s:sh()
augroup END
" -*-*-*- [ Shell Script Config End ] -*-*-*- "

" -*-*-*- [ C setting begin ] -*-*-*- "
function! s:c()
    if has("win32") || has("win64")
        setlocal path+=G:/arkray2/Dropbox/src/include
    elseif has("unix")
        setlocal path+=~/Dropbox/src/include
    endif
endfunction
augroup vimrc-set_filetype_c
    autocmd!
    autocmd FileType c call s:c()
augroup END

" この形式だと、明示的に :Quickrun c/gcc と実行した時だけ適用される。
" 単純に.cファイルを開いて、<Leader>r と実行しただけでは適用されない。
"let g:quickrun_config['c/gcc'] = {
"    \ 'type' : 'c/gcc',
"    \ 'cmdopt' : '-Wall -Wextra -Wpedantic abababa',
"    \}

" -*-*-*- [ C setting end ] -*-*-*- "

" -*-*-*- [ C++ setting begin ] -*-*-*- "
" 拡張子の付いていないC++のヘッダファイルを開いた時にハイライトする
function! s:cpp()
    if has("win32") || has("win64")
        setlocal path+=G:/arkray2/boost/boost_1_57_0,C:\MinGW\lib\gcc\mingw32\4.8.1\include\c++
        setlocal path+=G:/arkray2/boost/boost_1_57_0,C:\MinGW64\MinGW64\x86_64-w64-mingw32\include\c++
    elseif has("unix")
        setlocal path+=~/Dropbox/src/include
    endif
endfunction

let $CPP_STDLIB = "C:/MinGW64/MinGW64/x86_64-w64-mingw32/include/c++"
augroup vimrc-set_filetype_cpp
    autocmd!
    autocmd BufReadPost $CPP_STDLIB/* if empty(&filetype) | set filetype=cpp | endif
    autocmd FileType cpp call s:cpp()
augroup END

" -*-*-*- [ C++ setting end ] -*-*-*- "

" -*-*-*- [ Java setting begin ] -*-*-*- "
let  java_highlight_all=1
let  java_highlight_functions="style"
let  java_allow_cpp_keywords=1
let  java_highlight_functions=1
"let  java_space_errors=1
" -*-*-*- [ Java setting end ] -*-*-*- "

" -*-*-*- [ Ruby Config Begin ] -*-*-*- "
" タブ幅やインデント時の空白を2個にする
function! s:ruby()
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2      " tabstopの値に準じる?
endfunction

augroup vimrc-ruby
    autocmd!
    autocmd Filetype ruby call s:ruby()
augroup END
" -*-*-*- [ Ruby Config End ] -*-*-*- "

