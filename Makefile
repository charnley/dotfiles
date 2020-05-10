
all:
	./vim_update.sh

install: fuzzy symlink_clean symlink fuzzy vim_install vim_update tmux_install bin_folder
	bash --login

symlink:
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	mkdir -p ~/.ssh
	ln -sf `pwd`/ssh_config ~/.ssh/config

symlink_clean:
	rm -f ~/.vimrc ~/.gitconfig  ~/.bashrc ~/.bash_aliases ~/.bash_profile ~/.inputrc ~/.tmux.conf

zsh:
	# TODO Download dependencies

vim:
	# TODO all dependencies, potentially compile yourself?

vim_install:
	./vim_install.sh

vim_update:
	./vim_update.sh

fuzzy:
	./fzf_setup.sh

packages:
	sudo apt-get install silversearcher-ag # for fast searching
	sudo apt-get install vim-nox # for python binding vim, for vim-plug (plugin manager)
	sudo apt-get install tmux # keep my sessions alive
	sudo apt-get install curl # vim install
	sudo apt-get install tree # nice tool for showing tree of dir

packages.linux:
	# server related

packages.linux.x:
	echo # x related

packages.mac:
	# brew packages

tmux_install:
	git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

bin_folder:
	mkdir -p ~/bin
	# Don't overwrite anything
	for x in bin/*; do \
		if [ ! -f ~/$$x  ]; then\
			ln -s `pwd`/$$x ~/$$x;\
		fi; \
	done

