#!/bin/bash

###############################################################################
# NOTE: Must be run in the dotfiles directory
###############################################################################

# Fail if any step fails
set -e;

# Turn parts of the setup script on and off
INSTALL_PACKAGES=true
CONFIGURE_GIT=true
CONFIGURE_BASH=true
CONFIGURE_MOTD=true
CONFIGURE_TMUX=true
CONFIGURE_VIM=true



###############################################################################
# Install packages
###############################################################################

if $INSTALL_PACKAGES; then

# Require apt to install stuff
# TODO: Upgrade to use arbitrary package manager
if ! which apt; then
  echo "apt command required.";
  exit;
fi

# Update all pacakges, including python3 pip
sudo apt update && sudo apt --yes upgrade;
if which python3; then
  sudo python3 -m pip install --upgrade pip;
fi

# List of packages to apt install
PACKAGES=(
  curl
  zip
  wget
  gcc
  tmux
  # vim
  pandoc
  youtube-dl
  ffmpeg
  calibre
  texlive texlive-extra-utils texlive-latex-extra texlive-pictures poppler-utils
  jq
  imagemagick
  sopwith
  netcat
  nmap
  git
  gimp
  inkscape
  binutils
  htop
  tor
  xterm
  mlton
  smlnj
  sqlite3
  gdb
  valgrind
  socat
  build-essential
  exiftool
  hashcat
  neovim
)

sudo apt --yes install ${PACKAGES[@]};

# Install miscellaneous packages
# Install ttyd
if [ ! -f "/usr/local/bin/ttyd" ]; then
  # NOTE: Uses the x86_64 binary for ttyd
  sudo wget \
    --output-document "/usr/local/bin/ttyd" \
    "https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64";
  sudo chmod +x "/usr/local/bin/ttyd";
fi

# Install pup
if [ ! -f "/usr/local/bin/pup" ]; then
  mkdir -p ~/Downloads;
  cd ~/Downloads;
  wget \
    --output-document pup_v0.4.0_linux_amd64.zip \
    "https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip";
  unzip pup_v0.4.0_linux_amd64.zip;
  sudo mv ./pup /usr/local/bin/pup;
fi

fi # $INSTALL_PACKAGES


###############################################################################
# Configure Git
###############################################################################

if $CONFIGURE_GIT; then

cat .gitconfig >> ~/.gitconfig

fi # $CONFIGURE_GIT



###############################################################################
# Configure Bash
###############################################################################

if $CONFIGURE_BASH; then

cat .bashrc >> ~/.bashrc
cat .bash_profile >> ~/.bash_profile

fi # $CONFIGURE_BASH



###############################################################################
# Configure MOTD
###############################################################################

if $CONFIGURE_MOTD; then

cat motd | sudo tee --append /etc/motd > /dev/null

fi # $CONFIGURE_MOTD



###############################################################################
# Configure tmux
###############################################################################

if $CONFIGURE_TMUX; then

cat .tmux.conf >> ~/.tmux.conf

fi # $CONFIGURE_TMUX



###############################################################################
# Configure Vim and Neovim
###############################################################################

if $CONFIGURE_VIM; then

cat .vimrc >> ~/.vimrc

mkdir -p ~/.vim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
# echo 'alias vim="nvim"' >> ~/.bashrc

fi # $CONFIGURE_VIM



###############################################################################
# TODO
###############################################################################

# ~/.sowpithrc
# ~/.sopwith/keys
# custom scripts
