# everything in this file can be deleted afterwards
ESC=$(printf "\e")

RESET="$ESC[0m"
DGRAY="$ESC[90m"
GREEN="$ESC[92m"
YELLOW="$ESC[93m"
BLUE="$ESC[94m"
MAGENTA="$ESC[95m"

function err-exit() {
    echo "${RED}something failed, quitting$RESET"
    exit
}

HOME_PATH=$1
if [ ! -d "$HOME_PATH" ]; then
    echo "invalid argument"
    err-exit
fi

# do this in new folder
echo "${BLUE}mkdir config-tmp$RESET"
mkdir config-tmp || err-exit
cd config-tmp

# Make configuration files
echo "${BLUE}writing config files, old files are in folder old$RESET"
mkdir "old"

if [ -f $HOME_PATH/.bashrc ]; then
    cp $HOME_PATH/.bashrc old/.bashrc-old
fi
cat .bashrc >> $HOME_PATH/.bashrc

if [ -f $HOME_PATH/.bashrc ]; then
    cp $HOME_PATH/.bashrc old/.bashrc-old
fi
cat .bashrc > $HOME_PATH/.bashrc

if [ -f $HOME_PATH/.gitconfig ]; then
    cp $HOME_PATH/.gitconfig
fi
cat .gitconfig > $HOME_PATH/.gitconfig

# install basic packages with pacman
echo "${BLUE}install with pacman$RESET"
pacman -Syu --needed git base-devel glibc libc++ vim llvm clang lldb ffmpeg \
        vlc vivaldi vivaldi-ffmpeg-codecs discord steam obs-studio texlive \
        texlive-langczechslovak dotnet-sdk \
    || err-exit

# install yay
echo "${BLUE}install yay$RESET"
git clone https://aur.archlinux.org/yay-bin.git \
    && cd yay-bin \
    && makepkg -si \
    && cd ..
    || err-exit

# install rust
echo "${BLUE}install rust$RESET"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh \
    || err-exit

# install with yay
echo "${BLUE}install with yay$RESET"
yay -Syu \
    && yay -S --needed heroic-games-launcher-bin visual-studio-code-bin \
        makemake \
    || err-exit

# install makemake templates
echo "${BLUE}installing makemake templates$RESET"
git clone https://github.com/BonnyAD9/makemake-templates.git \
    && cd makemake-templates \
    && ./install-all \
    && cd .. \
    || err-exit

# install aswp
echo "${BLUE}installing aswp$RESET"
if type aswp &> /dev/null; then
    echo "${MAGENTA}aswp already installed$RESET"
else
    git clone https://github.com/BonnyAD9/aswp.git \
        && cd aswp \
        && sudo cp aswp.sh /usr/bin/aswp \
        && cd .. \
        || err-exit
fi

# install mproc
echo "${BLUE}installing mproc$RESET"
if type mproc &> /dev/null; then
    echo "${MAGENTA}mproc already installed$RESET"
else
    git clone https://github.com/BonnyAD9/mproc.git \
        && cd mproc \
        && cargo build -r \
        && sudo cp target/release/mproc /usr/bin/mproc \
        && cd .. \
        || err-exit
fi

# install meme-cutter
echo "${BLUE}installing meme-cutter$RESET"
if type meme-cutter &> /dev/null; then
    echo "${MAGENTA}meme-cutter already installed$RESET"
else
    git clone https://github.com/BonnyAD9/meme-cutter.git \
        && cd meme-cutter
        && cargo build -r \
        && sudo cp target/release/meme-cutter /usr/bin/meme-cutter \
        && cd .. \
        || err-exit
fi

# install loopover
echo "${BLUE}installing loopover$RESET"
if type loopover &> /dev/null; then
    echo "${MAGENTA}loopover already installed$RESET"
else
    git clone https://github.com/BonnyAD9/Loopover.git \
        && cd Loopover \
        && dotnet publish -r linux-x64 -p:PublishSingleFile=true \
            --self-contained true \
        && sudo cp Loopover/bin/Debug/*/linux-x64/publish/Loopover \
            /usr/bin/loopover \
        && cd .. \
        || err-exit
fi

echo "${YELLOW}Don't forget to run 'aswp config' to configure it$RESET"
