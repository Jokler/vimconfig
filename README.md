##Vim Config
This vim configuration is just intended for me, don´t expect it to work out of the box.

####Linux
* git clone https://github.com/Jokler/vimconfig.git ~/.vim
* ln -s ~/.vim/vimrc ~/.vimrc
* mkdir ~/.vimtmp/
* cd ~/.vim
* git submodule update --init
* Run ":Helptags" in Vim

####Windows
* Open the command prompt as admin
* cd %USERPROFILE%
* git clone https://github.com/Jokler/vimconfig.git ./vimfiles
* mklink "/_vimrc" "./vimfiles/vimrc"
* mkdir "./vimtmp/"
* cd ./vimfiles
* git submodule update --init
* Run ":Helptags" in Vim

###Updates
To update run either   
"git pull origin master" for my configuration or  
"git submodule foreach git pull origin master" for the latest updates of the plugins.
