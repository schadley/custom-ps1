#!/bin/sh
BoxCornerUL='┌' #u250c
BoxCornerLL='└' #u2514
Tpipe='├' #u251c
LineHoriz='─' #u2500
Delta='Δ' #u0394
Minus='−' #u2212

Red='\e[0;31m'
Green='\e[0;32m'
NC='\e[0m'

if [ "$color_prompt" = yes ]; then
    PS1='$BoxCornerUL$LineHoriz ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
else
    PS1='$BoxCornerUL$LineHoriz ${debian_chroot:+($debian_chroot)}\u@\h:\w'
fi
unset color_prompt force_color_prompt

in_git_repo() {
    [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}
git_branch() {
    local branch=$(git branch 2>/dev/null | grep -Po "(?<=\* ).+")
    echo "$branch"
}
git_index() {
    local new=$(git status --porcelain | grep '^[AC][ MD]' | wc -l)
    local modified=$(git status --porcelain | grep '^[MR][ MD]' | wc -l)
    local deleted=$(git status --porcelain | grep '^D ' | wc -l)
    echo "$Green+:$new $Delta:$modified $Minus:$deleted$NC"
}
git_worktree() {
    local modified=$(git status --porcelain | grep '^[ MARC]M' | wc -l)
    local deleted=$(git status --porcelain | grep '^[ MARC]D' | wc -l)
    local untracked=$(git status --porcelain | grep '^??' | wc -l)
    echo "$Red$Delta:$modified $Minus:$deleted ?:$untracked$NC"
}

print_git_status() {
    if in_git_repo; then
        local status="\n$Tpipe$LineHoriz B:$(git_branch)"
        status+="    $(git_index)"
        status+="    $(git_worktree)"
        echo -e "$status"
    fi
}

PS1+='$(print_git_status)'

PS1+='\n$BoxCornerLL\$ '
