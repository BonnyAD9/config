setopt extended_glob

PS1="%F{11}%n@%m %F{13}%~%F{8}%(!.#.\$)%f "

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
        print -P "%F{191}yay -Syu%f"
        # stupid npm sometimes breaks the update process
        yay -Syu --overwrite '/usr/lib/node_modules/*'
    fi
    if type rustup &> /dev/null; then
        print -P "%F{191}rustup update%f"
        rustup update
    fi
    if type ghcup &> /dev/null; then
        print -P "%F{191}ghcup upgrade%f"
        ghcup upgrade
    fi
    if type npm &> /dev/null; then
        print -P "%F{191}sudo npm update -g%f"
        sudo npm update -g
    fi
}

# moves head to the next commit (opposite of git `checkout HEAD~`)
git-next() {
    git checkout `git log --reverse --ancestry-path HEAD..master | head -n 1 | cut -d \  -f 2`
}

ncol() {
    local R=""
    for i in `seq 0 255`; do
        R="$R %F{$i}$i%f"
    done
    print -P -a -C 16 ${=R}
}
