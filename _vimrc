scriptencoding utf-8

" -*-*-*- [ NeoBundle config begin] -*-*-*- 
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

NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" NERDTree: コメントアウトすべし
"NeoBundle 'scrooloose/nerdtree'

" \c to comment-out
NeoBundle 'tyru/caw.vim'   

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'vim-jp/vimdoc-ja'

" Colorschemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'

"NeoBundle 'chriskempson/colors'
NeoBundle 'chriskempson/base16-vim'
"let base16colorspace=256  " Access colors present in 256 colorspace

" vim-airline: statusline 
"NeoBundle 'bling/vim-airline'

" lightline.vim: statusline 
NeoBundle 'itchyny/lightline.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
" -*-*-*- [ NeoBundle config end] -*-*-*- 

" -*-*-*- [ Quickrun config begin ] -*-*-*- 
let g:quickrun_config = {
            \   "_" : { 
            \       "outputter/buffer/split" : "aboveleft 10sp",
            \       "runner" : "vimproc",
            \       "runner/vimproc/sleep" : 0,
            \       "runner/vimproc/updatetime" : 40,
            \   },
            \}

" Ctrl+C to suspend quickrun currently running
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" -*-*-*- [ Quickrun config end ] -*-*-*- 

" -*-*-*- [ neocompletion config begin ] -*-*-*-
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

" -*-*-*- [ neocompletion config end ] -*-*-*-

" -*-*-*- [ neosnippet config begin ] -*-*-*-
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" -*-*-*- [ neosnippet config end ] -*-*-*-

" -*-*-*- [ Unite.vim config begin ] -*-*-*-
"Unite.vim key-map
noremap <C-U><C-B> :Unite buffer<CR>
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
noremap <C-U><C-R> :Unite file_mru<CR>
"noremap <C-U><C-R> :Unite register source<CR>
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" -*-*-*- [ Unite.vim config end ] -*-*-*-

" -*-*-*- [ caw.vim config begin ] -*-*-*-
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

" -*-*-*- [ caw.vim config end ] -*-*-*-

" -*-*-*- [ key map config ] -*-*-*- "
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

" back-up config
set nobackup
"set backupdir=C:/temp/
"set browsedir=buffer

"indent setting
"set autoindent
set smartindent
set expandtab           "タブ文字ではなく空白文字を使う"
set shiftwidth=4        "自動的にインデントされる空白量
set tabstop=4           "ファイル中のtab文字を空白何文字分で表現するか
set softtabstop=4       "tabキーを押した場合に挿入される空白量
set backspace=2         "indet,eol,start

"syntax on
syntax enable
set history=50

set number
set list
set ruler
set showcmd

set hlsearch

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

" .cファイルの既定値
let g:quickrun_config.c = {
\   "type" : 'c/gcc',
\   "cmdopt" : '-std=c99 -Wall -Wextra -Wpedantic',
\}

" :Quickrun c/clang として実行した場合に適用される
let g:quickrun_config['c/clang'] = {
\   "cmdopt" : '-std=c99 -Weverything -Wextra -Wpedantic',
\}
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

" .cppファイルの既定値
let g:quickrun_config.cpp = {
\   'type' : 'cpp/g++',
\   'cmdopt' : '-std=c++11 -Wall -Wextra -Wpedantic',
\}

" :Quickrun c/clang++ として実行した場合に適用される
let g:quickrun_config['cpp/clang++'] = {
\   'type' : 'cpp/clang++',
\   'cmdopt' : '-std=c++11 -Weverything -Wextra -Wpedantic',
\}
" -*-*-*- [ C++ setting end ] -*-*-*- "

" -*-*-*- [ Java setting begin ] -*-*-*- "
let  java_highlight_all=1
let  java_highlight_functions="style"
let  java_allow_cpp_keywords=1
let  java_highlight_functions=1
"let  java_space_errors=1
" -*-*-*- [ Java setting end ] -*-*-*- "

" -*-*-*- [ Ruby setting begin ] -*-*-*- "
function! s:ruby()
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=0      "tabstopの値に準じる
endfunction

augroup vimrc-ruby
    autocmd!
    autocmd Filetype ruby call s:ruby()
augroup END
" -*-*-*- [ Ruby setting end ] -*-*-*- "

" -*-*-*-  graphical setting -*-*-*- "
set t_Co=64

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


" -*-*-*- font config -*-*-*- 
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
