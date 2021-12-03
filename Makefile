
.PHONY: vim_update

all: vim_update

vim_update:
	vim +PlugClean +PlugInstall +PlugUpdate +qall

~/bin/vim:
	bash setup/nvim_setup.sh

~/bin/tmux:
	bash setup/tmux_compile.sh

install: ~/bin/vim ~/bin/tmux vim_update

symlink:
	# TODO needs to be OSX specific

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

