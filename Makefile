
all:
	cp vimrc ~/.vimrc
	cp gitconfig ~/.gitconfig
	cp bashrc ~/.bashrc
	cp bash_aliases ~/.bash_aliases
	cp bash_profile ~/.bash_profile
	cp inputrc ~/.inputrc
	
	./vim_update.sh

install: vundle_install fuzzyshell symlink_clean symlink bash_completion
	bash --login

symlink:
	ln -s `pwd`/vimrc ~/.vimrc
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/bashrc ~/.bashrc
	ln -s `pwd`/bash_aliases ~/.bash_aliases
	ln -s `pwd`/bash_profile ~/.bash_profile
	ln -s `pwd`/inputrc ~/.inputrc
	ln -s `pwd`/tmux.conf ~/.tmux.conf
	
	./vim_update.sh

symlink_clean:
	rm ~/.vimrc ~/.gitconfig  ~/.bashrc ~/.bash_aliases ~/.bash_profile ~/.inputrc

vim:
	./vim_update.sh

bash_completion:
	sudo cp bash_completion/tma /etc/bash_completion.d/tma

vim_install:
	./vim_install.sh

fuzzy:
	./fzf_setup.sh


