#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. /usr/share/blesh/ble.sh --noattach

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
export CC=clang
export CXX=clang++

# define color codes
ESC=$(printf "\e")

RESET="$ESC[0m"
DGRAY="$ESC[90m"
GREEN="$ESC[92m"
YELLOW="$ESC[93m"
BLUE="$ESC[94m"
MAGENTA="$ESC[95m"

# change prompt
PS1="\[${YELLOW}\]\u@\h\[${RESET}\] \[${MAGENTA}\]\w\[${DGRAY}\]\$\[${RESET}\] "

# aliases
alias claer=clear
alias c='xclip -i'
alias v='xclip -o'
alias cb='xclip -selection clipboard'

# functions
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

vsnew() {
    VSNEW_PATH=/mnt/x/Programming/
    mkcd "$VSNEW_PATH$1"
    code .
}

update-all() {
    if type yay &> /dev/null; then
        echo "${YELLOW}yay -Syu$RESET"
        yay -Syu
    fi
    if type rustup &> /dev/null; then
        echo "${YELLOW}rustup update$RESET"
        rustup update
    fi
    if type ghcup &> /dev/null; then
        echo "${YELLOW}ghcup upgrade$RESET"
        ghcup upgrade
    fi
    if type npm &> /dev/null; then
        echo "${YELLOW}sudo npm update -g$RESET"
        sudo npm update -g
    fi
}

# moves head to the next commit (opposite of git `checkout HEAD~`)
git-next() {
    git checkout `git log --reverse --ancestry-path HEAD..master | head -n 1 | cut -d \  -f 2`
}

[[ ${BLE_VERSION-} ]] && ble-attach
