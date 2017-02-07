
all:
	./vim_update.sh

install: depends fuzzy symlink_clean symlink fuzzy vim_install vim_update
	bash --login

symlink:
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/bashrc ~/.bashrc
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/bash_profile ~/.bash_profile
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	ln -sf `pwd`/ssh_config ~/.ssh/config
	
	ln -sf `pwd`/bin/gitclone ~/bin/gitclone
	ln -sf `pwd`/bin/mnt ~/bin/mnt

symlink_clean:
	rm ~/.vimrc ~/.gitconfig  ~/.bashrc ~/.bash_aliases ~/.bash_profile ~/.inputrc ~/.tmux.conf

bash_autocomplete:
	sudo cp bash_completion/tma /etc/bash_completion.d/tma
	sudo cp bash_completion/tmk /etc/bash_completion.d/tmk

vim_install:
	./vim_install.sh

vim_update:
	./vim_update.sh

fuzzy:
	./fzf_setup.sh

depends:
	sudo apt-get install silversearcher-ag # for fast searching
	sudo apt-get install vim-nox # for python binding vim, for vim-plug (plugin manager)
	sudo apt-get install tmux # keep my sessions alive
	sudo apt-get install curl # vim install
	sudo apt-get install tree # nice tool for showing tree of dir

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

