@echo off
setlocal

if "%~1"=="/h" goto Error

set newcom=%~1
rem ������ "branch -a" �Ɠ�d���p���ň͂܂�ė^������΃G���[�ɂȂ�
if "%~1"=="" goto Error else (
    if "%~2"=="" goto Error else (
        if "%~3"=="" (
            set oldcom=%~2
            goto MAIN
        ) else (
            if "%~4"=="" (
                set oldcom=%~2 %~3
                goto MAIN
            ) else (
                if "%~5"=="" (
                    set oldcom=%~2 %~3 %~4
                    goto MAIN
                ) else (
                    if "%~6"=="" (
                        set oldcom=%~2 %~3 %~4 %~5
                        goto MAIN
                    ) else (
                        if "%~7"=="" (
                            set oldcom=%~2 %~3 %~4 %~5 %~6
                            goto MAIN
                        ) else (
                            if "%~8"=="" (
                                set oldcom=%~2 %~3 %~4 %~5 %~6 %~7
                                goto MAIN
                            ) else (
                                if "%~9"=="" (
                                    set oldcom=%~2 %~3 %~4 %~5 %~6 %~7 %~8
                                    goto MAIN
                                ) else (
                                    set oldcom=%~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9
                                    goto MAIN
                                )
                            )
                        )
                    )
                )
            )
        )
    )
)
rem ��Lif���Ɠ����̌��ʂɂȂ�悤�ɉϒ��̈�����A���������B
rem �ł��ȉ��̕��@�ł͂��܂��ł��Ȃ��B
rem set newcom=%1
rem set /a count=0
rem for %%f in (%*) do (
rem     echo %%f
rem     set /a count+=1
rem     if %count% geq 2 (set oldcom=%oldcom% %%f)
rem )

:MAIN
rem ��d���p���ň͂܂Ȃ���΂��܂��@�\���Ȃ�
rem git brv branch -v �y�� git brv "branch -v" �̂�����ł��@�\����
git config --global alias.%newcom% "%oldcom%"
echo git config --global alias.%newcom% "%oldcom%" >> git_aliases.bat

rem git brv branch -v �y�� git brv "branch -v" �̂���������܂������Ȃ�
rem git config --global alias.%newcom% %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9
rem git config --global alias.%newcom% "%~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9"
rem git config --global alias.%newcom% %2 %3 %4 %5 %6 %7 %8 %9
rem git config --global alias.%newcom% "%2 %3 %4 %5 %6 %7 %8 %9"
rem set orig=%~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9
rem set orig=%2 %3 %4 %5 %6 %7 %8 %9
rem git config --global alias.%newcom% "%orig%"
endlocal
exit /b 0

:Error
echo git�̃G�C���A�X���쐬���A���Y�G�C���A�X�R�}���h���t�@�C���ɒǋL����
echo usage: galias.bat �G�C���A�X�� �R�}���h...
exit /b 1
