Dotfiles
========

For OSX, Debian and whatever HPC I need to work on. Some dotfiles are OS dependent. Check `Makefile` for dependencies, install and symlink setup.

I use `Makefile` to coordinate everything. You should too. `Make` everything.

Mac OSX
-------

|macosx|

window manager: yabai

Debian
------

|debian|

window manager: i3wm

.. |debian| image:: https://raw.githubusercontent.com/charnley/dotfiles/master/setup.deb.x/screenshot.png
.. |macosx| image:: https://raw.githubusercontent.com/charnley/dotfiles/master/setup.osx/screenshot.png

Setup
-----

.. code-block:: bash

    # fresh installation on new system

    make install_apt # only for systems you have sudo
    make install # Compile and download dependencies (such as tmux and neovim)

.. code-block:: bash

    # Check for updated dotfiles and check all plugins (e.g. VIM plugin update)
    git pull # Get latest changed
    make # Check all symlinks and plugins
