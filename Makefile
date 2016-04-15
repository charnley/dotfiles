
all:
	cp vimrc ~/.vimrc
	cp gitconfig ~/.gitconfig
	cp bashrc ~/.bashrc
	cp bash_aliases ~/.bash_aliases
	cp bash_profile ~/.bash_profile
	cp inputrc ~/.inputrc
	
	./vundle_update.sh

symlink:
	ln -s `pwd`/vimrc ~/.vimrc
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/bashrc ~/.bashrc
	ln -s `pwd`/bash_aliases ~/.bash_aliases
	ln -s `pwd`/bash_profile ~/.bash_profile
	ln -s `pwd`/inputrc ~/.inputrc
	
	./vundle_update.sh

symlink_clean:
	rm ~/.vimrc
	rm ~/.gitconfig
	rm ~/.bashrc
	rm ~/.bash_aliases
	rm ~/.bash_profile
	rm ~/.inputrc

vundle:
	./vundle_update.sh

vundle_install:
	./vundle_setup.sh

