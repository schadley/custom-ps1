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
    PS1='$BoxCornerUL$LineHoriz ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='$BoxCornerUL$LineHoriz ${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

in_git_repo() {
    [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}
git_branch() {
    local branch=$(git branch 2>/dev/null | grep -Po "(?<=\* ).+")
    echo "$branch"
}

print_git_status() {
    if in_git_repo; then
        local status="\n$Tpipe$LineHoriz B:$(git_branch)"
        echo -e "$status"
    fi
}

PS1+='$(print_git_status)'

PS1+='\n$BoxCornerLL\$ '
