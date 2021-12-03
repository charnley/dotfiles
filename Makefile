
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

all: vim_plugins

vim_plugins:
	vim +PlugClean +PlugInstall +PlugUpdate +qall

tmux_plugins:
	# TODO one liner for tmux plugins

~/bin/vim:
	bash setup.$(OS)/nvim_setup.sh

~/bin/tmux:
	bash setup.$(OS)/tmux_compile.sh

~/.bashrc: symlink

symlink:
	bash setup.$(OS)/setup_dotfiles.sh

install: ~/.bashrc ~/bin/vim ~/bin/tmux vim_plugins

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

