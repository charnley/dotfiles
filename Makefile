
# Check operating system
ifeq '$(findstring ;,$(PATH))' ';'
	detected_OS := Windows
else
	detected_OS := $(shell uname 2>/dev/null || echo Unknown)
	detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
	detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
	detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

ifeq ($(detected_OS),Darwin)        # Mac OS X
	OS = osx
endif

ifeq ($(detected_OS),Linux)
	OS = deb
endif

.PHONY: vim_plugins install

all: vim_plugins tmux_plugins

vim_plugins:
	~/bin/vim +PlugClean[!] +PlugInstall +PlugUpdate +qall

tmux_plugins:
	bash ./setup/tmux_plugins.sh

~/bin/vim:
	bash setup.$(OS)/nvim_setup.sh
	~/bin/vim +PlugClean[!] +PlugInstall +PlugUpdate +qall

~/bin/tmux:
	bash ./setup.$(OS)/tmux_compile.sh
	bash ./setup/tmux_plugins.sh

~/.bashrc: symlink

symlink:
	bash setup.$(OS)/setup_dotfiles.sh

install: ~/.bashrc ~/bin/vim vim_plugins

symlink_clean:
	# TODO if there and is symlink, rm

packages.linux:
	# server related

packages.linux.x:
	echo # x related

packages.mac:
	# brew packages

bin_folder:
	# TODO Needs to find a better and osx specific way
	mkdir -p ~/bin
	# Don't overwrite anything
	for x in bin/*; do \
		if [ ! -f ~/$$x  ]; then\
			ln -s `pwd`/$$x ~/$$x;\
		fi; \
	done

