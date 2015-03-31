##Vim Config
This vim configuration is just intended for me, don´t expect it to work out of the box.

####Linux
* git clone https://github.com/Jokler/vimconfig.git ~/.vim
* ln -s ~/.vim/vimrc ~/.vimrc
* cd ~/.vim
* git submodule update --init

####Windows
* Open the command prompt as admin
* cd %USERPROFILE%
* git clone https://github.com/Jokler/vimconfig.git ./vimfiles
* mklink ./_vimrc ./vimfiles/vimrc
* cd ./vimfiles
* git submodule update --init
