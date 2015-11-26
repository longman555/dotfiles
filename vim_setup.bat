@echo off
rem git submodule update ���o�b�`�t�@�C���ł��܂����s�ł��Ȃ��B
rem ���ʂ̊ԁA�ŏ��Ɏ蓮�� %~dp0%\.vim\bundle\neobundle.vim �ɂ�
rem git submodule update �R�}���h�����s���A���̌ケ�̃o�b�`�t�@�C�������s����B

set THIS_DIR=%~dp0
mklink C:\Users\arkray2\editor\vim74\_vimrc %THIS_DIR%\_vimrc
mklink C:\Users\arkray2\editor\vim74\_gvimrc %THIS_DIR%\_gvimrc
mklink /j C:\Users\arkray2\editor\vim74\bundle %THIS_DIR%\.vim\bundle

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
rem ��x vim ���N�����ăv���O�C�����C���X�g�[�����Ȃ��ƁANeosnippet ��
rem Quickrun �Avimproc �Ɋւ���ȉ��̏��������s����B
rem ����Avimproc �ł̃��C�u�����̐����Ɏ��s���Ă��܂��B���s�����ꍇ�A
rem vimproc.vim ���폜���邩�ۂ��̃v�����v�g���ł邪�ANo��I�Ԃ��ƁB
vim -e -c "NeoBundleInstall" -c "q"

rem vimproc.vim �̎����r���h�����s���Ă��܂����߁A���C�u�������_�E�����[�h����
curl --silent --location https://github.com/Shougo/vimproc.vim/releases/download/ver.9.2/vimproc_win64.dll > %THIS_DIR%\.vim\bundle\vimproc.vim\lib\vimproc_win64.dll

rem Set up for Neosnippet
move %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets_bu
mklink /j %THIS_DIR%\.vim\bundle\neosnippet-snippets\neosnippets %THIS_DIR%\.vim\neosnippets

rem Set up for Quickrun
copy %THIS_DIR%\.vim\vim-quickrun\autoload\quickrun.vim %THIS_DIR%\.vim\bundle\vim-quickrun\autoload\

exit /b 0
