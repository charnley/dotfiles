
# Dotfiles


## Installation

very straight forward. 
I like to keep all my dotfiles in a git repo lime `~/git/dotfiles`

will remove your current dotfiles and symbolic link those in this repo

    cd ~
    mkdir git
    cd git
    git clone http://github.com/charnley/dotfiles
    cd dotfiles
    # if you need dependencies
    make depend
    # end if
    make install


## TODO

    - Map Ctrl+Tab and Ctrl+Shift+Tab to something else in the terminal, so I can use it for vim tabs

## Debian

    http://serverfault.com/questions/22414/how-can-i-run-debian-stable-but-install-some-packages-from-testing

