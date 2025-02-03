# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

DISABLE_AUTO_UPDATE=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
#    zsh-autosuggestions
#    zsh-syntax-highlighting
)

# PATH="$PATH:$HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin/bin"

source $ZSH/oh-my-zsh.sh

# source ~/.oh-my-zsh/custom/plugins/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# setopt extended_glob

# PS1="%F{11}%n@%m %F{13}%~%F{8}%(!.#.\$)%f "
# PS1="%F{11}%n@%m %F{13}%~%(?:%F{8}%(!.#.\$)%f:%F{1}%(!.#.\$)%f) "
export CC=clang
export CXX=clang++
export EDITOR=nvim

# aliases
alias claer=clear
alias v='xclip -o -selection clipboard'
alias c='xclip -selection clipboard'
alias vim=nvim

# functions
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

update-all() {
    if type dnf &> /dev/null; then
        print -P "%F{191}sudo dnf update%f"
        sudo dnf update
    fi
    if type yay &> /dev/null; then
        print -P "%F{191}yay -Syyu%f"
        # stupid npm sometimes breaks the update process
        yay -Syyu --overwrite '/usr/lib/node_modules/*'
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
    if type omz &> /dev/null; then
        print -P "%f{191}omz update%f"
        omz update
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

set-prompt() {
    if [ "$1" "==" "short" ]; then
        PS1="%F{13}%1~%F{8}%(!.#.\$)%f "
    else
        PS1="%F{11}%n@%m %F{13}%~%F{8}%(!.#.\$)%f "
    fi
}

set-prompt

# syntax highlighting
# source ~/prog/vsce/TypeDark/zsh-typedark.sh

# Uamp shell integration
if type uamp &> /dev/null; then
    `uamp sh tab`
fi

# Fzf shell integration
if type fzf &> /dev/null; then
    source <(fzf --zsh)
fi
