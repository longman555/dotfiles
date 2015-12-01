@echo off
setlocal

if "%~1"=="/h" goto Error

set newcom=%~1
rem 引数が "branch -a" と二重引用符で囲まれて与えられればエラーになる
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
rem 上記if文と同等の結果になるように可変長の引数を連結したい。
rem でも以下の方法ではうまくできない。
rem set newcom=%1
rem set /a count=0
rem for %%f in (%*) do (
rem     echo %%f
rem     set /a count+=1
rem     if %count% geq 2 (set oldcom=%oldcom% %%f)
rem )

:MAIN
rem 二重引用符で囲まなければうまく機能しない
rem git brv branch -v 及び git brv "branch -v" のいずれでも機能する
git config --global alias.%newcom% "%oldcom%"
echo git config --global alias.%newcom% "%oldcom%" >> git_aliases.bat

rem git brv branch -v 及び git brv "branch -v" のいずれもうまくいかない
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
echo gitのエイリアスを作成し、当該エイリアスコマンドをファイルに追記する
echo usage: galias.bat エイリアス名 コマンド...
exit /b 1
