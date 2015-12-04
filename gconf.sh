#!/bin/bash
# gconf.sh: git config のラッパー
# グローバル(既定)/ローカルの設定ファイルに、変数(既定)/エイリアスを、
# セット(既定)/アンセットすることができる。

print_usage() {
    echo "使用法: $0 [オプション]... 変数名 変数値"
    echo "-g, --global             グローバルに設定"
    echo "-l, --local              ローカルに設定"
    echo "-v, --var, --variable    通常の変数を設定"
    echo "-a, --alias              エイリアスを設定"
    echo "                         この場合、変数名の'alias.'を省略することができる"
    echo "-u, --unset              変数・エイリアスをアンセット"
    echo "-h, --help               このメッセージを表示する"
    return 0
}

case $1 in "-h" | "--help") print_usage; exit 0 ;; esac

# 引数のオプションを検査
scope="--global"    # グローバル(default) or ローカル
target=""           # 通常の変数(default) or エイリアス
action=""           # セット(default) or アンセット
debug=""
dryrun=""
for arg in $@; do
    case $arg in
        "-g" | "--global")              ;;
        "-l" | "--local")               scope="--local" ;;
        "-v" | "--var" | "--variable")  ;;
        "-a" | "--alias")               target="alias." ;;
        "-s" | "--set")                 ;;
        "-u" | "--unset")               action="--unset" ;;
        "-d" | "--dryrun")              dryrun="dryrun" ;;
        "-D" | "--debug")               debug="debug" ;;
        *)                              break ;;
    esac
    shift
done

if [ -n "$dryrun" ]; then echo "Dry running..."; fi

# 簡易のエラー処理
if [ "_$1" = "_" ]; then echo "変数名がありません。"; exit 1; fi
# 変数をアンセットする場合は、変数値の指定がなくても構わない
if [ "_$2" = "_" -a "_$action" != "_--unset" ]; then
    echo "変数値がありません。"; exit 2;
fi

var_name=$1     # 変数名のはず
shift
var_val="$*"    # 変数値のはず

# -a オプション指定時に、変数値に接頭辞として alias. があっても、
# エラーにならないようにするための措置。
if [ "_`echo ${var_name} | cut -c 1-6`" =  "_${target}" ]; then target=""; fi

## 本処理 ##
if [ -n "$debug" ]; then
    echo "[debug] git config ${scope} ${action} ${target}${var_name} \"${var_val}\""
fi
if [ -z "$dryrun" ]; then
    git config ${scope} ${action} ${target}${var_name} "${var_val}"
fi

exit 0
