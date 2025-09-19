
# Note
# $@ - sources
# $< - target

# Check operating system
ifeq '$(findstring ;,$(PATH))' ';' # Windows
	detected_OS := Windows
else
	detected_OS := $(shell uname 2>/dev/null || echo Unknown)
	detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
	detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
	detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

ifeq ($(detected_OS),Darwin) # Mac OS X
	OS = osx
endif

ifeq ($(detected_OS),Linux) # Linux
	OS = deb
endif

# Dummy targets
.PHONY: vim_plugins install clean dotfiles directories

# Default targets
all: dotfiles bin tmux_plugins

vim_benchmark:
	${HOME}/bin/vim -c 'StartupTime'

# vim_plugins:
# 	NEOVIM_SETUP=1 ${HOME}/bin/vim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'

tmux_plugins:
	bash ./setup/tmux_plugins.sh

tmux_tpm:
	bash ./setup/tmux_tpm.sh

# Directories

${HOME}/bin:
	mkdir -p $@

${HOME}/.config:
	mkdir -p $@

${HOME}/.config/nvim: ${HOME}/.config
	mkdir -p $@

${HOME}/.ssh:
	mkdir -p $@

${HOME}/.config/i3:
	mkdir -p $@

${HOME}/.config/i3status: ${HOME}/.config
	mkdir $@

directories: ${HOME}/bin ${HOME}/.config/nvim

directories.x: ${HOME}/.config/i3status ${HOME}/.config/i3

# Executables

${HOME}/bin/vim:
	ln -fs `pwd`/bin.$(OS)/vim ${HOME}/bin/vim

${HOME}/opt/neovim: ${HOME}/opt/nvm
	bash setup.$(OS)/nvim_setup.sh

${HOME}/opt/tmux-3.2a:
	bash ./setup/tmux_compile.sh 1> /dev/null
	bash ./setup/tmux_tpm.sh
	bash ./setup/tmux_plugins.sh

${HOME}/opt/nvm:
	bash ./setup/javascript_nvm.sh
	bash ./setup/javascript_node.sh
	bash ./setup/javascript_yarn.sh

${HOME}/bin/zsh:
	bash ./setup/zsh_install.sh

${HOME}/.oh-my-zsh:
	bash ./setup/zsh_ohmyzsh.sh
	bash ./setup/zsh_ohmyzsh_plugins.sh

# TODO for bin folder, I should probably use CMakefile for rule generation
bin: ${HOME}/bin bindir_default bindir_$(OS) bindir_dev

bindir_default:
	@bash ./setup/install_bin_directories.sh bin

bindir_dev:
	@bash ./setup/install_bin_directories.sh bin.dev

bindir_deb:
	@bash ./setup/install_bin_directories.sh bin.deb

bindir_deb.x:
	@bash ./setup/install_bin_directories.sh bin.deb.x

bindir_osx:
	@bash ./setup/install_bin_directories.sh bin.osx

bindir_hpc:
	@bash ./setup/install_bin_directories.sh bin.hpc

# Dotfiles

dotfiles: directories dotfiles_defaults dotfiles_$(OS)

dotfiles.x: directories.x bindir_deb.x dotfiles_deb.x

${HOME}/.%:
	test -f $@ && mv $@ $@.bk;:
	ln -s `pwd`/$< $@

dotfiles_defaults: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_aliases ${HOME}/.bash_paths ${HOME}/.condarc ${HOME}/.gitconfig ${HOME}/.tmux.conf ${HOME}/.tmux-osx ${HOME}/.tmux-linux ${HOME}/.config/nvim/init.lua ${HOME}/.config/nvim/lua ${HOME}/.vsnip ${HOME}/.zshrc ${HOME}/.config/alacritty ${HOME}/.config/neofetch ${HOME}/.hushlogin

${HOME}/.bash_aliases: ./dot/bash_aliases
${HOME}/.bash_paths: ./dot/bash_paths
${HOME}/.bash_profile: ./dot/bash_profile
${HOME}/.bashrc: ./dot/bashrc
${HOME}/.condarc: ./dot/condarc
${HOME}/.gitconfig: ./dot/gitconfig
${HOME}/.hushlogin: ./dot/hushlogin
${HOME}/.tmux-linux: ./dot/tmux.linux.conf
${HOME}/.tmux-osx: ./dot/tmux.osx.conf
${HOME}/.tmux.conf: ./dot/tmux.conf
${HOME}/.zshrc: ./dot/zshrc
${HOME}/.ssh/config: ./dot/ssh_config

${HOME}/.config/neofetch: ./dot/neofetch
${HOME}/.config/alacritty: ./dot/alacritty
${HOME}/.config/nvim/init.lua: ./dot/neovim/init.lua
${HOME}/.config/nvim/lua: ./dot/neovim/lua
${HOME}/.vsnip: ./dot/neovim/snippets

dotfiles_osx: ${HOME}/.yabairc ${HOME}/.skhdrc ${HOME}/.gitignore ${HOME}/.ssh/config

${HOME}/.yabairc: ./dot.osx/yabairc
${HOME}/.skhdrc: ./dot.osx/skhdrc
${HOME}/.gitignore: ./dot.osx/gitignore

dotfiles_deb: ${HOME}/.inputrc

${HOME}/.inputrc: ./dot.deb/inputrc

dotfiles_deb.x: ${HOME}/.Xresources ${HOME}/.config/dunstrc ${HOME}/.config/i3status/config ${HOME}/.config/i3/config

${HOME}/.Xresources: ./dot.deb.x/Xresources
${HOME}/.config/dunstrc: ./dot.deb.x/dunstrc
${HOME}/.config/i3status/config: ./dot.deb.x/i3status
${HOME}/.config/i3/config: ./dot.deb.x/i3config

${HOME}/.fzf:
	bash ./setup/fzf_setup.sh

${HOME}/note:
	mkdir -p $@
	ln -s `pwd`/.zk $@/.zk
	cd $@ && git init

${HOME}/bin/zk:
	bash ./setup/setup_zettelkasten.sh
	test ! -f ${HOME}/bin/zk && ln -s ${HOME}/opt/zk.git/zk ${HOME}/bin/zk

# Meta

install: dotfiles bin ${HOME}/opt/neovim ${HOME}/.fzf ${HOME}/opt/tmux-3.2a ${HOME}/.oh-my-zsh ${HOME}/bin/zk ${HOME}/note

install_osx: ${HOME}/opt/homebrew
	brew bundle --file ./lists/gnu.Brewfile
	HOMEBREW_CASK_OPTS="--no-quarantine" brew bundle --file ./lists/i3like.Brewfile

${HOME}/opt/homebrew:
	bash ./setup.osx/setup_brew.sh

install_laptop: install_apt install_apt_x install_fonts

install_apt:
	apt install $$(cat ./lists/packages.apt) -y

install_apt_x:
	apt install $$(cat ./lists/packages.apt.x) -y

install_fonts:
	bash ./fonts/setup_mononoki.sh

install_fonts_post_deb:
	fc-cache -f -v

symlink_clean:
	# TODO if there and is symlink, rm. For example, if symlink points to dotfiles, but is deprecated

clean: symlink_clean

clean_neovim:
	mkdir -p ~/tmp/trash/
	mv ~/opt/neovim/ ~/tmp/trash/
	mv ~/bin/vim ~/tmp/trash/
	mv ~/.local/share/nvim/ ~/tmp/trash/
	rm -rf ~/tmp/trash/
