@echo off
setlocal

rem gconf.bat: git config のラッパーコマンド
rem 変数(既定)・エイリアスを、グローバル(既定)・ローカルの設定ファイルへ、
rem セット(既定)・アンセット することができる。

rem shift を使用するため、このファイル名を念のため保存しておく。
set BATCH_FILE_NAME=%0
shift

rem ヘルプメッセージを出力する
if "%~0"=="/?"        (call :PrintUsage && goto End
) else if "%~0"=="/H" (call :PrintUsage && goto End
) else if "%~0"=="/h" (call :PrintUsage && goto End
)

rem 引数のスイッチを検査する 
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

rem 簡易なエラー処理
rem TODO もっと詳細なエラー処理を行うようにする
if "%~0"==""        ((echo;) && (echo 変数名がありません。) && (goto End)
) else if "%~1"=="" ((echo;) && (echo 変数値がありません。) && (goto End)
)

rem 変数名(のはず)
set name=%~0
shift

rem 変数値
set value=%~0
shift

rem まだあるかもしれない変数値をあるだけ連結し、変数に格納する
:Loop_ArgsConcat
    if "%~0"=="" goto End_ArgsConcat
    set value=%value% %~0
    shift
    goto Loop_ArgsConcat
:End_ArgsConcat

rem 本処理
rem echo [debug] git config %SCOPE% %OP% %PREFIX%%name% "%value%"
git config %SCOPE% %OP% %PREFIX%%name% "%value%"
rem 何らかのプログラムで、実行した git config の記録を取り、再現できるようにする

:End
endlocal
exit /b 0

:PrintUsage
echo;
echo 使用法: %BATCH_FILE_NAME% [/G^|/L] [/S^|/D] [/V^|/A] 変数名 変数値
echo /G = グローバルに設定(既定), /L = ローカルに設定
echo /S = 変数をセットする(既定), /D = 変数をアンセットする
echo /V = 通常の変数をセットする(既定), /A = エイリアスをセットする(alias.は省略可)
echo /H = このメッセージを表示する
echo ※スイッチは小文字や ? での指定も可
exit /b 0
