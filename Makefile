
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

# Bin directory symlink targets
BIN_DEFAULT_FILES   := $(wildcard bin/*)
BIN_DEV_FILES       := $(wildcard bin.dev/*)
BIN_OSX_FILES       := $(wildcard bin.osx/*)
BIN_DEB_FILES       := $(wildcard bin.deb/*)
BIN_DEB_X_FILES     := $(wildcard bin.deb.x/*)
BIN_HPC_FILES       := $(wildcard bin.hpc/*)

BIN_DEFAULT_TARGETS := $(patsubst bin/%,$(HOME)/bin/%,$(BIN_DEFAULT_FILES))
BIN_DEV_TARGETS     := $(patsubst bin.dev/%,$(HOME)/bin/%,$(BIN_DEV_FILES))
BIN_OSX_TARGETS     := $(patsubst bin.osx/%,$(HOME)/bin/%,$(BIN_OSX_FILES))
BIN_DEB_TARGETS     := $(patsubst bin.deb/%,$(HOME)/bin/%,$(BIN_DEB_FILES))
BIN_DEB_X_TARGETS   := $(patsubst bin.deb.x/%,$(HOME)/bin/%,$(BIN_DEB_X_FILES))
BIN_HPC_TARGETS     := $(patsubst bin.hpc/%,$(HOME)/bin/%,$(BIN_HPC_FILES))

# Dummy targets
.PHONY: all bin vim-benchmark \
	directories directories-x \
	dotfiles dotfiles-defaults \
	dotfiles-deb dotfiles-deb-x \
	dotfiles-osx dotfiles-osx-yabai dotfiles-osx-aerospace \
	install-bin-links install-bin-links-dev \
	install-bin-links-deb install-bin-links-deb-x \
	install-bin-links-osx install-bin-links-hpc \
	install install-deb-x install-osx install-laptop \
	install-apt install-apt-x \
	install-fonts install-fonts-post-deb \
	install-dev-langs install-dev-envs \
	has-go has-rust \
	install-rust-packages install-brew-packages \
	clean clean-symlinks clean-neovim \
	format

# Default target
all: dotfiles bin

vim-benchmark:
	${HOME}/bin/vim -c 'StartupTime'

#
# Directories
#

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
	mkdir -p $@

${HOME}/.config/dunst: ${HOME}/.config
	mkdir -p $@

${HOME}/.moc:
	mkdir -p $@

directories: ${HOME}/bin ${HOME}/.config/nvim ${HOME}/.moc

directories-x: ${HOME}/.config/i3status ${HOME}/.config/i3 ${HOME}/.config/dunst

#
# Executables
#

${HOME}/bin/vim:
	ln -fs `pwd`/bin.$(OS)/vim ${HOME}/bin/vim

${HOME}/opt/neovim: ${HOME}/opt/nvm
	bash setup.$(OS)/install-neovim.sh

${HOME}/opt/tmux:
	bash ./setup/install-tmux-compile.sh 1> /dev/null
	bash ./setup/install-tmux-tpm.sh
	bash ./setup/install-tmux-plugins.sh

${HOME}/opt/nvm:
	bash ./setup/install-node-nvm.sh

${HOME}/bin/zsh:
	bash ./setup/install-zsh.sh

${HOME}/.oh-my-zsh:
	bash ./setup/install-zsh-ohmyzsh.sh
	bash ./setup/install-zsh-ohmyzsh-plugins.sh

#
# Bin folder
#

bin:
	$(MAKE) ${HOME}/bin
	$(MAKE) install-bin-links
	$(MAKE) install-bin-links-$(OS)
	$(MAKE) install-bin-links-dev

install-bin-links: $(BIN_DEFAULT_TARGETS)
install-bin-links-dev: $(BIN_DEV_TARGETS)
install-bin-links-deb: $(BIN_DEB_TARGETS)
install-bin-links-deb-x: $(BIN_DEB_X_TARGETS)
install-bin-links-osx: $(BIN_OSX_TARGETS)
install-bin-links-hpc: $(BIN_HPC_TARGETS)

$(HOME)/bin/%: bin/%
	ln -s $(CURDIR)/bin/$* $@

$(HOME)/bin/%: bin.dev/%
	ln -s $(CURDIR)/bin.dev/$* $@

$(HOME)/bin/%: bin.osx/%
	ln -s $(CURDIR)/bin.osx/$* $@

$(HOME)/bin/%: bin.deb/%
	ln -s $(CURDIR)/bin.deb/$* $@

$(HOME)/bin/%: bin.deb.x/%
	ln -s $(CURDIR)/bin.deb.x/$* $@

$(HOME)/bin/%: bin.hpc/%
	ln -s $(CURDIR)/bin.hpc/$* $@

#
# Dotfiles
#

# Base: OS-agnostic dotfiles from dot/
dotfiles: directories dotfiles-defaults

# Leaf: symlinks from dot/
dotfiles-defaults: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_aliases ${HOME}/.bash_paths ${HOME}/.condarc ${HOME}/.gitconfig ${HOME}/.tmux.conf ${HOME}/.tmux-osx ${HOME}/.tmux-linux ${HOME}/.config/nvim/init.lua ${HOME}/.config/nvim/lua ${HOME}/.vsnip ${HOME}/.zshrc ${HOME}/.config/alacritty ${HOME}/.config/neofetch ${HOME}/.hushlogin ${HOME}/.moc/themes

${HOME}/.%:
	test -f $@ && mv $@ $@.bk;:
	ln -s $(CURDIR)/$< $@

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
${HOME}/.moc/themes: ${HOME}/.moc ./dot/mocp_themes
	ln -sf $(CURDIR)/dot/mocp_themes $@
${HOME}/.config/nvim/init.lua: ./dot/neovim/init.lua
${HOME}/.config/nvim/lua: ./dot/neovim/lua
${HOME}/.vsnip: ./dot/neovim/snippets

# TODO DefaultKeyBinding

# deb: base + dot.deb/ symlinks
dotfiles-deb: dotfiles ${HOME}/.inputrc

${HOME}/.inputrc: ./dot.deb/inputrc

# deb-x: deb + X11 dirs + dot.deb.x/ symlinks + deb.x bin links
dotfiles-deb-x: dotfiles-deb directories-x ${HOME}/.Xresources ${HOME}/.config/dunst/dunstrc ${HOME}/.config/i3status/config ${HOME}/.config/i3/config install-bin-links-deb-x

${HOME}/.Xresources: ./dot.deb.x/Xresources
${HOME}/.config/dunst/dunstrc: ./dot.deb.x/dunstrc
${HOME}/.config/i3status/config: ./dot.deb.x/i3status
${HOME}/.config/i3/config: ./dot.deb.x/i3config

# osx: base + dot.osx/ symlinks
dotfiles-osx: dotfiles ${HOME}/.gitignore ${HOME}/.ssh ${HOME}/.ssh/config

dotfiles-osx-yabai: ${HOME}/.yabairc ${HOME}/.skhdrc
dotfiles-osx-aerospace: ${HOME}/.config/aerospace ${HOME}/.config/aerospace/aerospace.toml

${HOME}/.gitignore: ./dot.osx/gitignore
${HOME}/.config/aerospace:
	mkdir ${HOME}/.config/aerospace

${HOME}/.config/aerospace/aerospace.toml: ./dot.osx/aerospace.toml
${HOME}/.yabairc: ./dot.osx/yabairc
${HOME}/.skhdrc: ./dot.osx/skhdrc

#
# Installers
#

${HOME}/.fzf:
	bash ./setup/install-fzf.sh

${HOME}/bin/zk: has-go
	bash ./setup/install-zettelkasten.sh

# Full install: auto-dispatches dotfiles-deb or dotfiles-osx via $(OS)
install: dotfiles-$(OS) bin ${HOME}/opt/neovim ${HOME}/.fzf ${HOME}/opt/tmux ${HOME}/.oh-my-zsh ${HOME}/bin/zk

# Full deb+X11 install: one command to rule them all
install-deb-x: install-apt-x install dotfiles-deb-x install-dev-envs install-fonts install-fonts-post-deb

install-osx:
	bash ./setup.osx/install-homebrew.sh
	$(MAKE) install-brew-packages

install-laptop: install-apt-x install-fonts

#
# Apt packages
#

install-apt:
	sudo apt install $$(cat ./lists/packages.apt) -y

install-apt-x: install-apt
	sudo apt install $$(cat ./lists/packages.apt.x) -y

#
# Fonts
#

install-fonts:
	bash ./fonts/setup_mononoki.sh

install-fonts-post-deb:
	fc-cache -f -v

#
# Languages
#

has-go: ${HOME}/opt/go
has-rust: ${HOME}/.cargo

${HOME}/opt/go:
	bash ./setup/install-go.sh

${HOME}/.cargo:
	bash ./setup/install-rust.sh

# Language runtimes
install-dev-langs: has-rust ${HOME}/opt/nvm
	bash ./setup/install-node-default.sh
	bash ./setup/install-python-uv.sh
	bash ./setup/install-lua.sh
	$(MAKE) has-go

# Dev environment tools (require language runtimes)
install-dev-envs: install-dev-langs
	bash ./setup/install-neovim-language_servers.sh
	bash ./setup/install-opencode.sh

# Global packages
install-rust-packages:
	xargs cargo install < ./lists/packages.rust

install-brew-packages:
	brew bundle --file ./lists/gnu.Brewfile

#
# Clean
#

clean-symlinks:
	# TODO if there and is symlink, rm. For example, if symlink points to dotfiles, but is deprecated

clean: clean-symlinks

clean-neovim:
	mkdir -p ~/tmp/trash/
	mv ~/opt/neovim/ ~/tmp/trash/
	mv ~/bin/vim ~/tmp/trash/
	mv ~/.local/share/nvim/ ~/tmp/trash/
	rm -rf ~/tmp/trash/

#
# Misc
#

format:
	pre-commit run --all-files
