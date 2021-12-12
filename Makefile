
# Note
# $@ - target
# $< - source

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

pwd := $(dir $(mkfile_path))

.PHONY: vim_plugins install clean dotfiles

all: dotfiles bin vim_plugins tmux_plugins

vim_plugins:
	${HOME}/bin/vim +PlugClean[!] +PlugInstall +PlugUpdate +qall

tmux_plugins:
	bash ./setup/tmux_plugins.sh

# Directories

${HOME}/bin:
	mkdir ${HOME}/bin

# Executables

${HOME}/bin/vim:
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
bin: bindir_default bindir_$(OS)

bindir_default:
	export src=`pwd` && cd ${HOME}/bin/ && ln -fs $$src/bin/* .

bindir_deb:
	export src=`pwd` && cd ${HOME}/bin/ && ln -fs $$src/bin.deb/* .

bindir_deb.x:
	export src=`pwd` && cd ${HOME}/bin/ && ln -fs $$src/bin.deb.x/* .

bindir_osx:
	export src=`pwd` && cd ${HOME}/bin/ && ln -fs $$src/bin.osx/* .

bindir_hpc:
	export src=`pwd` && cd ${HOME}/bin/ && ln -fs $$src/bin.hpc/* .

# Dotfiles

dotfiles: dotfiles_defaults dotfiles_$(OS)

dotfiles_defaults: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_aliases

${HOME}/.bashrc: ./dot/bashrc
	ln -s `pwd`/$< $@

${HOME}/.bash_profile: ./dot/bash_profile
	ln -s `pwd`/$< $@

${HOME}/.bash_aliases: ./dot/bash_aliases
	ln -s `pwd`/$< $@

dotfiles_osx: ${HOME}/.yabairc ${HOME}/.skhdrc

${HOME}/.yabairc: ./dot.osx/yabairc
	ln -s `pwd`/$< $@

${HOME}/.skhdrc: ./dot.osx/skhdrc
	ln -s `pwd`/$< $@

dotfiles_deb:

dotfiles_deb.x:

dotfiles_hpc:

symlink:
	bash setup.$(OS)/setup_dotfiles.sh

install: ${HOME}/.bashrc ~/bin/vim vim_plugins

symlink_clean:
	# TODO if there and is symlink, rm. For example, if symlink points to dotfiles, but is deprecated

packages.linux:
	# server related

packages.linux.x:
	echo # x related

packages.mac:
	# brew packages

clean: symlink_clean
