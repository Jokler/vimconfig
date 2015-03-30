##Vim Config
This vim configuration is just intended for me, don´t expect it to work out of the box.

####Linux
-cd ~
-git clone https://github.com/Jokler/vimconfig.git ~/.vim
-ln -s ~/.vim/vimrc ~/.vimrc
-cd ~/.vim
-git submodule init
-git submodule update

####Windows
-Open the command prompt as admin
-cd ~
-git clone https://github.com/Jokler/vimconfig.git ~/vimfiles
-mklink ~/vimfiles/vimrc ~/_vimrc
-cd ~/vimfiles
-git submodule init
-git submodule update
