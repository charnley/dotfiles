Dotfiles
========

for OSX, Debian and whatever HPC I need to work on. Some dotfiles are OS dependent. Check `Makefile` for depenencies, install and symlink setup.

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
    make install
    

.. code-block:: bash

    # Check for updated dotfiles and check all plugins (e.g. VIM plugin update)
    git pull
    make

