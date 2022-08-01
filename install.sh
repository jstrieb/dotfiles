#!/bin/bash

###############################################################################
# NOTE: Must be run in the dotfiles directory
###############################################################################

# Fail if any step fails
set -e;

# Turn parts of the setup script on and off
INSTALL_PACKAGES=false
CONFIGURE_GIT=true
CONFIGURE_BASH=true
CONFIGURE_MOTD=true
CONFIGURE_TMUX=true
CONFIGURE_VIM=true
CONFIGURE_GDB=true
CONFIGURE_I3=false
CONFIGURE_GRUB=false
CONFIGURE_SOPWITH=false



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

# Update all pacakges
sudo apt update && sudo apt --yes upgrade;

# List of packages to apt install
PACKAGES=(
  curl
  zip
  wget
  gcc
  tmux
  # vim
  pandoc
  # youtube-dl  # Download from pip below -- usually more up to date than apt
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
  openssh-server
  ncdu
  golang
  python3
  python3-pip
  grafx2
  p7zip-full
  magic-wormhole
  links
  makeself
  net-tools
  aircrack-ng tshark reaver bully cowpatty pciutils
)

sudo apt --ignore-missing --yes install ${PACKAGES[@]};

# Update python3 pip and install pip packages
if which python3; then
  PIP_PACKAGES=(
    pip
    setuptools
    wheel
    youtube-dl
  )
  python3 -m pip install --upgrade "${PIP_PACKAGES[@]}";
fi

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
  pushd ~/Downloads;
  wget \
    --output-document pup_v0.4.0_linux_amd64.zip \
    "https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip";
  unzip pup_v0.4.0_linux_amd64.zip;
  sudo mv ./pup /usr/local/bin/pup;
  popd;
fi

# Install figlet
if [ ! -f "/usr/local/bin/figlet" ]; then
  mkdir -p ~/Downloads;
  pushd ~/Downloads;
  git clone https://github.com/cmatsuoka/figlet.git;
  cd figlet/fonts;

  # Download additional figlet fonts
  curl "http://patorjk.com/software/taag/" \
    | grep --only-matching "[[:alnum:]][[:alnum:][:space:]]*\.flf" \
    | sort \
    | uniq \
    | sed "s/^\(.*\)/\"\1\"\n\"http:\/\/patorjk.com\/software\/taag\/fonts\/\1\"/g" \
    | xargs -L 2 -P 16 \
      curl --silent --output;

  cd ..;
  make;
  sudo make install;
  popd;
fi

# Install binwalk
if ! which binwalk; then
  mkdir -p ~/Downloads;
  pushd ~/Downloads;

  git clone "https://github.com:ReFirmLabs/binwalk";
  cd binwalk;
  bash deps.sh --yes;
  sudo python3 setup.py install;

  popd;
fi

# Install wifite
if ! sudo which wifite; then
  mkdir -p ~/Downloads;
  pushd ~/Downloads;

  git clone "https://github.com/derv82/wifite2.git";
  cd wifite2;
  sudo python3 setup.py install;

  popd;
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

cat motd \
  | sudo tee --append /etc/motd \
  > /dev/null

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
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
# echo 'alias vim="nvim"' >> ~/.bashrc

fi # $CONFIGURE_VIM



###############################################################################
# Configure GDB
###############################################################################

if $CONFIGURE_GDB; then

cat .gdbinit >> ~/.gdbinit
sed 's/\$r\(\w\w\)/\$e\1/g' .gdbinit \
  | sed 's/\/1xg/\/1xw/g' \
  | sed 's/8/4/g' \
  >> ~/.gdbinit-32

fi # $CONFIGURE_GDB



###############################################################################
# Configure i3
###############################################################################

if $CONFIGURE_I3; then

mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
cat i3 >> ~/.config/i3/config
cat i3status >> ~/.config/i3status/config

fi # $CONFIGURE_I3



###############################################################################
# Configure GRUB
###############################################################################

if $CONFIGURE_GRUB; then

cat grub/default \
  | sudo tee --append /etc/default/grub \
  > /dev/null
sudo cp grub/42_colors /etc/grub.d/
sudo update-grub

fi # $CONFIGURE_GRUB



###############################################################################
# Configure Sopwith
###############################################################################

if $CONFIGURE_SOPWITH; then

cat .sopwithrc > ~/.sopwithrc
cp -r .sopwith ~/.sopwith

fi # $CONFIGURE_SOPWITH



###############################################################################
# TODO
###############################################################################

# custom scripts
