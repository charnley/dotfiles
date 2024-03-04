# Setup a nice terminal

- Download and install alacritty https://alacritty.org/
- The config path for alacritty toml is `%APPDATA`/alacritty

# Setup WSL Ubuntu

    sudo apt update
    sudo apt upgrade
    sudo apt install make

    make install_apt
    make install_snap
    make install
    make

# Config

    # Setup local
    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8

    # Change shell
    sudo apt install zsh
    chsh $USER -s `which zsh`
