#!/bin/sh

# As of now, $THIS_DIR (the path to the directory in which this file exists)
# *MUST* be ~/dotfiles. So, $THIS_DIR does not make much sense here. 
#THIS_DIR=`dirname $0`
THIS_DIR=~/dotfiles
ln -sf ${THIS_DIR}/.bashrc ~/.bashrc
ln -sf ${THIS_DIR}/_vimrc ~/.vimrc
ln -sf ${THIS_DIR}/_gvimrc ~/.gvimrc
ln -sfT ${THIS_DIR}/.vim ~/.vim

# Set up for NeoBundle
NB_DIR=${THIS_DIR}/.vim/bundle/neobundle.vim
if [ -z "`ls -A ${NB_DIR}`" ]; then
    # NB_DIR is empty, that is, the submodule has not been initialized yet. 
    CURRENT_DIR=`pwd`
    cd ${NB_DIR}
    git submodule init
    git submodule update
    cd ${CURRENT_DIR}

    # vim を起動し、NeoBundle にプラギンをインストールさせて、終了する
    vim -e -c "NeoBundleInstall" -c "q"
    # FIXME どうやったら以下の $? が 0 を返すようになる？
    echo 'the result of "vim -e -c " ' $?
fi

################################################################################
# これ以下の処理は、一度vimを起動しプラギンをインストールしていないと失敗する  #
################################################################################

# Set up for Neosnippet 
mv ${THIS_DIR}/.vim/bundle/neosnippet-snippets/neosnippets ${THIS_DIR}/.vim/bundle/neosnippet-snippets/neosnippets_bu
ln -sfT ${THIS_DIR}/.vim/neosnippets ${THIS_DIR}/.vim/bundle/neosnippet-snippets/neosnippets

# Set up for Quickrun
cp -f ${THIS_DIR}/.vim/vim-quickrun/autoload/quickrun.vim ${THIS_DIR}/.vim/bundle/vim-quickrun/autoload/quickrun.vim
