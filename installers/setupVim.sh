#! /bin/bash

mkdir -p ~/.vim/bundle
if [ ! -d "~/.vim/bundle/Vundle.Vim" ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "Installing vundle packages"
vim +BundleInstall +qall 

echo "building YouCompleteMe"
cd ~/.vim/bundle/youcompleteme
./install.py --clang-completer --omnisharp-completer --gocode-completer
