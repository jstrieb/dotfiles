#!/bin/bash

# Fail if any step fails
set -e;

# Turn parts of the setup script on and off
INSTALL_PACKAGES=false


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


# List of packages to apt install
PACKAGES=(
  tmux
  vim
  pandoc
  youtube-dl
  ffmpeg
  calibre
  texlive texlive-extra-utils texlive-latex-extra texlive-pictures poppler-utils
  jq
)

apt install ${PACKAGES[@]};


# Install miscellaneous packages
# Install ttyd
wget \
  --output-document "/usr/local/bin/ttyd" \
  "https://github.com/tsl0922/ttyd/releases/latest/download/ttyd_linux.x86_64";
chmod +x "/usr/local/bin/ttyd";

fi # $INSTALL_PACKAGES
