@echo off
rem git submodule update をバッチファイルでうまく実行できない。
rem 当面の間、最初に手動で %~dp0%\.vim\bundle\neobundle.vim にて
rem git submodule update コマンドを実行し、その後このバッチファイルを実行する。

set THIS_DIR=%~dp0

mklink %USERPROFILE%\editor\vim74\_vimrc %THIS_DIR%\_vimrc
mklink %USERPROFILE%\editor\vim74\_gvimrc %THIS_DIR%\_gvimrc
mklink /j %USERPROFILE%\editor\vim74\bundle %THIS_DIR%\.vim\bundle
mklink /j %USERPROFILE%\dotfiles\.vim\bundle %THIS_DIR%\.vim\bundle

rem Set up for NeoBundle
rem 自動で git submodule init/update を行いたいが、上手くいかない。
rem git submodule update で処理が実行されず、終了してしまう。
set NB_DIR=%THIS_DIR%\.vim\bundle\neobundle.vim
for %%f in (%NB_DIR%\*) do goto FinishNeoBundleInit
    rem %NB_DIR%が空の場合(neobundle.vimが未初期化の場合)
REM    set CURRENT_DIR=%cd%
REM    cd %NB_DIR%
REM    git submodule init
REM    cmd /c git submodule update
REM    cd %CURRENT_DIR%
REM    vim -e -c "NeoBundleInstall" -c "q"
:FinishNeoBundleInit

rem 手動で git submodule update を実行しなければならないための措置。
rem 一度 vim を起動してプラグインをインストールしないと、ここ以下の処理が失敗する。
vim -e -c "NeoBundleInstall" -c "q"

rem Set up for Neosnippet
rem move %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets_bu
rem mklink /j %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets %THIS_DIR%\.vim\neosnippets
mklink /j %USERPROFILE%\dotfiles\.vim\neosnippets %THIS_DIR%\.vim\neosnippets

exit /b 0
