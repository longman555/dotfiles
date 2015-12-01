@echo off
rem サブコマンドにオプションを付ける場合は、二重引用符で囲む必要がある。
rem 一重引用符ではうまく登録されない(Windowsでは)

rem git config
git config --global alias.egc "config --global -e"

rem git status
git config --global alias.st status

rem git log
git config --global alias.plog "log --oneline --decorate"
git config --global alias.pplog "log --oneline --decorate --graph --all"

rem git branch
git config --global alias.br branch
git config --global alias.bra "branch -a"

rem git checkout
git config --global alias.co "checkout -"
git config --global alias.cob "checkout -b"
