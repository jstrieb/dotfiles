# Dotfiles

Included dotfiles are used for configuring common programs:

- NeoVim
- Bash
- Git
- GDB
- tmux
- Alacritty
- i3
- SDL Sopwith

```
dotfiles
├── alacritty.yml
├── .bash_profile
├── .bashrc
├── .gdbinit
├── .gitconfig
├── .gitignore
├── i3
├── i3status
├── install.sh
├── motd
├── .sopwith
│   ├── keys.original
│   └── keys.pocketchip
├── .sopwithrc
├── .tmux.conf
└── .vimrc
```

## Quick Start

Clone the repository and edit the `install.sh` script and comment out programs
and packages to skip installing them. Likewise, edit the booleans at the top of
the file to adjust what configuration steps the script performs.

If on an x86 system that uses the `apt` package manager, install by running
`./install.sh` from the command line. Otherwise, configure to use the
appropriate package manager and CPU architecture before running the install
script.

If you're not me, you'll probably want to edit the `motd` file so that it
doesn't welcome "Jacob Strieb" when you log in.
