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

PS1+='\n$BoxCornerLL\$ '
