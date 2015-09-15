#! /bin/bash

echo "Installing tooling and dev dependencies"
sudo apt-get update
sudo apt-get install build-essential 
sudo apt-get install cmake 

echo "Building vim from source and getting rid of other versions"
sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev git

# remove existing vim
sudo apt-get remove vim vim-runtime gvim

# build and configure vim
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install

# Set vim as default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

# get location of running script
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}/..

# make symlinks to config files
ln -s ${DIR}/../.vimrc ~/.vimrc
ln -s .${DIR}/../.gitconfig ~/.gitconfig
ln -s .${DIR}/../.hgrc ~/.hgrc
ln -s .${DIR}/../.jscsrc ~/.jscsrc
ln -s .${DIR}/../.ctags ~/.ctags
ln -s ${DIR}/../map-cmdline.hist ~/map-cmdline.hist