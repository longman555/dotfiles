@echo off
setlocal

rem gconf.bat: git config �̃��b�p�[�R�}���h
rem �ϐ�(����)�E�G�C���A�X���A�O���[�o��(����)�E���[�J���̐ݒ�t�@�C���ցA
rem �Z�b�g(����)�E�A���Z�b�g ���邱�Ƃ��ł���B

rem shift ���g�p���邽�߁A���̃t�@�C������O�̂��ߕۑ����Ă����B
set BATCH_FILE_NAME=%0
shift

rem �w���v���b�Z�[�W���o�͂���
if "%~0"=="/?"        (call :PrintUsage && goto End
) else if "%~0"=="/H" (call :PrintUsage && goto End
) else if "%~0"=="/h" (call :PrintUsage && goto End
)

rem �����̃X�C�b�`���������� 
rem SCOPE: --global or --local 
set SCOPE=--global
rem OP: set a variable or unset one 
set OP=
rem PREFIX: just a helper for creating a alias 
set PREFIX=
:Loop_ArgsCheck
    if "%~0"=="/G"        (set SCOPE=--global
    ) else if "%~0"=="/g" (set SCOPE=--global
    ) else if "%~0"=="/L" (set SCOPE=--local
    ) else if "%~0"=="/l" (set SCOPE=--local
    ) else if "%~0"=="/S" (set OP=
    ) else if "%~0"=="/s" (set OP=
    ) else if "%~0"=="/D" (set OP=--unset
    ) else if "%~0"=="/d" (set OP=--unset
    ) else if "%~0"=="/V" (set PREFIX=
    ) else if "%~0"=="/v" (set PREFIX=
    ) else if "%~0"=="/A" (set PREFIX=alias.
    ) else if "%~0"=="/a" (set PREFIX=alias.
    ) else                (goto End_ArgsCheck
    )
    shift
    goto Loop_ArgsCheck
:End_ArgsCheck

rem �ȈՂȃG���[����
rem TODO �����ƏڍׂȃG���[�������s���悤�ɂ���
if "%~0"==""        ((echo;) && (echo �ϐ���������܂���B) && (goto End)
) else if "%~1"=="" ((echo;) && (echo �ϐ��l������܂���B) && (goto End)
)

rem �ϐ���(�̂͂�)
set name=%~0
shift

rem �ϐ��l
set value=%~0
shift

rem �܂����邩������Ȃ��ϐ��l�����邾���A�����A�ϐ��Ɋi�[����
:Loop_ArgsConcat
    if "%~0"=="" goto End_ArgsConcat
    set value=%value% %~0
    shift
    goto Loop_ArgsConcat
:End_ArgsConcat

rem �{����
rem echo [debug] git config %SCOPE% %OP% %PREFIX%%name% "%value%"
git config %SCOPE% %OP% %PREFIX%%name% "%value%"
rem ���炩�̃v���O�����ŁA���s���� git config �̋L�^�����A�Č��ł���悤�ɂ���

:End
endlocal
exit /b 0

:PrintUsage
echo;
echo �g�p�@: %BATCH_FILE_NAME% [/G^|/L] [/S^|/D] [/V^|/A] �ϐ��� �ϐ��l
echo /G = �O���[�o���ɐݒ�(����), /L = ���[�J���ɐݒ�
echo /S = �ϐ����Z�b�g����(����), /D = �ϐ����A���Z�b�g����
echo /V = �ʏ�̕ϐ����Z�b�g����(����), /A = �G�C���A�X���Z�b�g����(alias.�͏ȗ���)
echo /H = ���̃��b�Z�[�W��\������
echo ���X�C�b�`�͏������� ? �ł̎w�����
exit /b 0
