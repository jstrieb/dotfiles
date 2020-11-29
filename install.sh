#!/bin/bash

###############################################################################
# NOTE: Must be run with `sudo`
###############################################################################

# Fail if any step fails
set -e;

# Turn parts of the setup script on and off
INSTALL_PACKAGES=true
CONFIGURE_GIT=true



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
apt update && apt --yes upgrade;
if which python3; then
  python3 -m pip install --upgrade pip;
fi

# List of packages to apt install
PACKAGES=(
  curl
  wget
  gcc
  tmux
  vim
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
)

apt --yes install ${PACKAGES[@]};

# Install miscellaneous packages
# Install ttyd
wget \
  --output-document "/usr/local/bin/ttyd" \
  "https://github.com/tsl0922/ttyd/releases/latest/download/ttyd_linux.x86_64";
chmod +x "/usr/local/bin/ttyd";

fi # $INSTALL_PACKAGES


###############################################################################
# Configure Git
###############################################################################

if $CONFIGURE_GIT; then

cat ~/.gitconfig .gitconfig > ~/.gitconfig

fi # $CONFIGURE_GIT



###############################################################################
# TODO
###############################################################################

# ~/.sowpithrc
# ~/.sopwith/keys
# ~/.tmux.conf
# ~/.bashrc
# ~/.vimrc
# custom scripts
# dotfile backup script
# crontab
# upgrade pip

