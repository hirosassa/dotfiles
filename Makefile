DOP= `cat ${HOME}/Dropbox/arch/pkglist.txt`
DOY= `cat ${HOME}/Dropbox/arch/yaourtlist.txt`

init: ## deploy this dotfiles
	ln -vsf ${PWD}/.zshrc   ${HOME}/.zshrc
	ln -vsf ${PWD}/.gitconfig   ${HOME}/.gitconfig
	ln -vsf ${PWD}/.screenrc   ${HOME}/.screenrc
	ln -vsf ${PWD}/.tmux.conf   ${HOME}/.tmux.conf
	ln -vsf ${PWD}/.xinitrc   ${HOME}/.xinitrc
	ln -vsf ${PWD}/.aspell.conf   ${HOME}/.aspell.conf
	ln -vsf ${PWD}/.config/redshift.conf   ${HOME}/.config/redshift.conf
	ln -vsf ${PWD}/.config/psd/psd.conf   ${HOME}/.config/psd/psd.conf
	ln -vsf ${PWD}/.config/fish/conf.d/omf.fish   ${HOME}/.config/fish/conf.d/omf.fish
	ln -vsf ${PWD}/.config/parcellite/parcelliterc   ${HOME}/.config/parcellite/parcelliterc
	test -L ${HOME}/.peco || rm -rf ${HOME}/.peco
	ln -vsfn ${PWD}/.peco   ${HOME}/.peco
	test -L ${HOME}/.emacs.d || rm -rf ${HOME}/.emacs.d
	ln -vsfn ${PWD}/.emacs.d   ${HOME}/.emacs.d
	test -L ${HOME}/.ssh || rm -rf ${HOME}/.ssh
	ln -vsfn ${HOME}/Dropbox/ssh   ${HOME}/.ssh
	test -L ${HOME}/.sylpheed-2.0 || rm -rf ${HOME}/.sylpheed-2.0
	ln -vsfn ${HOME}/Dropbox/sylpheed/.sylpheed-2.0   ${HOME}/.sylpheed-2.0
	test -L ${HOME}/.mozc || rm -rf ${HOME}/.mozc
	ln -vsfn ${HOME}/Dropbox/mozc/.mozc   ${HOME}/.mozc
	chmod 600   ${HOME}/.ssh/id_rsa
	cd ${HOME}/.emacs.d/;   cask upgrade;   cask install

update: ## update cask depend on melpa
	cd ${HOME}/.emacs.d/;   cask upgrade;   cask update

install: ## install development environment powerd by arch linux
	export GOPATH=${HOME}
	export PATH="$PATH:$GOPATH/bin"
	chmod u+x ${PWD}/bin/continue.sh
	${PWD}/bin/continue.sh && \
	cat ${HOME}/.bashrc | grep screenstart || echo "alias screenstart='screen -D -RR'" >> ${HOME}/.bashrc
	cat ${HOME}/.bashrc | grep tmuxstart || echo "alias tmuxstart='tmux new-session -A -s main'" >> ${HOME}/.bashrc
	sudo pacman -S go zsh git vim dropbox nautilus-dropbox tmux keychain zsh-completions \
	gnome-tweak-tool xsel sylpheed emacs curl archlinux-wallpaper evince inkscape gimp unrar \
	file-roller vlc xclip atool trash-cli the_silver_searcher powertop cifs-utils gnome-system-monitor \
	gvfs gvfs-smb seahorse gnome-keyring cups-pdf redshift eog mcomix libreoffice-fresh-ja \
	firefox firefox-i18n-ja otf-ipafont openssh pkgfile baobab dconf-editor rsync elixir \
	phantomjs parcellite whois nmap poppler-data rtmpdump ffmpeg swftools fish sbcl \
	aspell aspell-en httperf gdb ripgrep hub wmctrl transmission-gtk calibre
	mkdir -p ${HOME}/{bin,src}
	go get -u github.com/nsf/gocode
	go get -u github.com/rogpeppe/godef
	yaourt google-chrome
	yaourt peco-git
	yaourt noto-fonts-cjk
	yaourt ttf-ricty
	yaourt profile-sync-daemon
	yaourt man-pages-ja
	yaourt global
	yaourt hugo
	yaourt ghq
	yaourt casperjs-git
	yaourt nkf
	yaourt ibus-mozc
	yaourt mozc
	yaourt the_platinum_searcher
	yaourt osx-arc-shadow
	yaourt gtk-theme-arc
	yaourt slack-desktop
	yaourt cmigemo-git
	sudo pkgfile --update
	curl -L http://get.oh-my.fish | fish
	curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python

backup: ## backup arch linux package at dropbox
	mkdir -p ${HOME}/Dropbox/arch
	pacman -Qqen > ${HOME}/Dropbox/arch/pkglist.txt
	pacman -Qqem > ${HOME}/Dropbox/arch/yaourtlist.txt

recover: ## recovery from backup arch linux package at dropbox
	sudo pacman -S --needed $(DOP)
	yaourt -S --needed $(DOY)
	cat ${HOME}/.bashrc | grep screenstart || echo "alias screenstart='screen -D -RR'" >> ${HOME}/.bashrc
	cat ${HOME}/.bashrc | grep tmuxstart || echo "alias tmuxstart='tmux new-session -A -s main'" >> ${HOME}/.bashrc
	mkdir -p ${HOME}/{bin,src}
	export GOPATH=${HOME}
	export PATH="$PATH:$GOPATH/bin"
	go get -u github.com/nsf/gocode
	go get -u github.com/rogpeppe/godef
	sudo pkgfile --update

test: ## print environment value
	export GOPATH=${HOME}
	export PATH="${PATH}:${GOPATH}/bin"
	printenv

all: init update install test help backup recover

.PHONY: all

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
