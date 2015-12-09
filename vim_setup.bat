@echo off
rem git submodule update ���o�b�`�t�@�C���ł��܂����s�ł��Ȃ��B
rem ���ʂ̊ԁA�ŏ��Ɏ蓮�� %~dp0%\.vim\bundle\neobundle.vim �ɂ�
rem git submodule update �R�}���h�����s���A���̌ケ�̃o�b�`�t�@�C�������s����B

set THIS_DIR=%~dp0

mklink %USERPROFILE%\editor\vim74\_vimrc %THIS_DIR%\_vimrc
mklink %USERPROFILE%\editor\vim74\_gvimrc %THIS_DIR%\_gvimrc
mklink /j %USERPROFILE%\editor\vim74\bundle %THIS_DIR%\.vim\bundle
mklink /j %USERPROFILE%\dotfiles\.vim\bundle %THIS_DIR%\.vim\bundle

rem Set up for NeoBundle
rem ������ git submodule init/update ���s���������A��肭�����Ȃ��B
rem git submodule update �ŏ��������s���ꂸ�A�I�����Ă��܂��B
set NB_DIR=%THIS_DIR%\.vim\bundle\neobundle.vim
for %%f in (%NB_DIR%\*) do goto FinishNeoBundleInit
    rem %NB_DIR%����̏ꍇ(neobundle.vim�����������̏ꍇ)
REM    set CURRENT_DIR=%cd%
REM    cd %NB_DIR%
REM    git submodule init
REM    cmd /c git submodule update
REM    cd %CURRENT_DIR%
REM    vim -e -c "NeoBundleInstall" -c "q"
:FinishNeoBundleInit

rem �蓮�� git submodule update �����s���Ȃ���΂Ȃ�Ȃ����߂̑[�u�B
rem ��x vim ���N�����ăv���O�C�����C���X�g�[�����Ȃ��ƁA�����ȉ��̏��������s����B
vim -e -c "NeoBundleInstall" -c "q"

rem Set up for Neosnippet
rem move %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets_bu
rem mklink /j %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets %THIS_DIR%\.vim\neosnippets
mklink /j %USERPROFILE%\dotfiles\.vim\neosnippets %THIS_DIR%\.vim\neosnippets

exit /b 0
