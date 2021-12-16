
# Note
# $@ - sources
# $< - target

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

# Dummy targets
.PHONY: vim_plugins install clean dotfiles directories

# Default targets
all: dotfiles bin vim_plugins tmux_plugins

vim_plugins:
	${HOME}/bin/vim +PlugClean[!] +PlugInstall +PlugUpdate +qall

tmux_plugins:
	bash ./setup/tmux_plugins.sh

# Directories

${HOME}/bin:
	mkdir $@

${HOME}/.config/neovim:
	mkdir $@

${HOME}/.ssh:
	mkdir $@

${HOME}/.i3:
	mkdir $@

${HOME}/.config/i3status:
	mkdir $@

directories: ${HOME}/bin ${HOME}/.config/neovim

# Executables

${HOME}/bin/vim:
	ln -fs `pwd`/bin.$(OS)/vim ${HOME}/bin/vim

${HOME}/opt/neovim: ${HOME}/opt/nvm ${HOME}/bin/vim
	bash setup.$(OS)/nvim_setup.sh
	${HOME}/bin/vim +PlugClean[!] +PlugInstall +PlugUpdate +qall

${HOME}/bin/tmux:
	bash ./setup.$(OS)/tmux_compile.sh
	bash ./setup/tmux_plugins.sh

${HOME}/opt/nvm:
	bash ./setup/javascript_nvm.sh
	bash ./setup/javascript_node.sh
	bash ./setup/javascript_yarn.sh

# TODO for bin folder, I should probably use CMakefile for rule generation
bin: ${HOME}/bin bindir_default bindir_$(OS)

bindir_default:
	@bash ./setup/install_bin_directories.sh bin

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

${HOME}/.%:
	ln -s `pwd`/$< $@

dotfiles_defaults: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_aliases ${HOME}/.condarc ${HOME}/.gitconfig ${HOME}/.tmux.conf ${HOME}/.tmux-osx ${HOME}/.tmux-linux ${HOME}/.config/nvim/init.vim ${HOME}/.config/nvim/lua ${HOME}/.vsnip

${HOME}/.bash_aliases: ./dot/bash_aliases
${HOME}/.bash_profile: ./dot/bash_profile
${HOME}/.bashrc: ./dot/bashrc
${HOME}/.condarc: ./dot/condarc
${HOME}/.gitconfig: ./dot/gitconfig
${HOME}/.tmux.conf: ./dot/tmux.conf
${HOME}/.tmux-linux: ./dot/tmux.linux.conf
${HOME}/.tmux-osx: ./dot/tmux.osx.conf

${HOME}/.config/nvim/init.vim: ./dot/neovim/init.vim
${HOME}/.config/nvim/lua: ./dot/neovim/lua
${HOME}/.vsnip: ./dot/neovim/snippets

dotfiles_osx: ${HOME}/.yabairc ${HOME}/.skhdrc ${HOME}/.gitignore

${HOME}/.yabairc: ./dot.osx/yabairc
${HOME}/.skhdrc: ./dot.osx/skhdrc
${HOME}/.gitignore: ./dot.osx/gitignore

dotfiles_deb: ${HOME}/.inputrc

${HOME}/.inputrc: ./dot.deb/inputrc

dotfiles_deb.x: ${HOME}/.Xresources ${HOME}/.config/dunstrc ${HOME}/.config/i3status/config ${HOME}/.i3/config

${HOME}/.Xresources: ./dot.deb.x/Xresources
${HOME}/.config/dunstrc: ./dot.deb.x/dunstrc
${HOME}/.config/i3status/config: ./dot.deb.x/i3status
${HOME}/.i3/config: ./dot.deb.x/i3config

# Meta

install: dotfiles ${HOME}/opt/neovim

symlink_clean:
	# TODO if there and is symlink, rm. For example, if symlink points to dotfiles, but is deprecated

packages.linux:
	# server related

packages.linux.x:
	echo # x related

packages.mac:
	# brew packages

clean: symlink_clean
