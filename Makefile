
all:
	cp .vimrc ~/
	cp .gitconfig ~/
	cp .bashrc ~/
	cp .zshrc ~/
	cp .bash_aliases ~/
	cp .bash_profile ~/
	cp .inputrc ~/
	./vundle_update.sh

vundle:
	./vundle_setup.sh

