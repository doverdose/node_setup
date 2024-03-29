#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node, as well as node-gyp
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12
npm install -g node-gyp

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-get install software-properties-common
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh


# Install tmux
sudo apt-get install -y tmux

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi

cp -f .screenrc ../dotfiles/
cp -f .bash_profile ../dotfiles/
cp -f .bashrc ../dotfiles/
cp -f .bashrc_custom ../dotfiles/
cp -f -r .emacs.d ../dotfiles/
cp -f .dircolors ../dotfiles/

ln -sb dotfiles/.screenrc ../.
ln -sb dotfiles/.bash_profile ../.
ln -sb dotfiles/.bashrc ../.
ln -sb dotfiles/.bashrc_custom ../.
ln -sf dotfiles/.emacs.d ../.
ln -sb dotfiles/.dircolors ../.
