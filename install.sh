# /bin/bash

git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay && makepkg -si && rm -rf ~/yay


yay -S --noconfirm go cmake npm fzf git alsa-utils ctags p7zip grub \
    git xorg-server xorg-xinit vlc slock vim cmake htop ranger python-pipenv \
    zip dialog wpa_supplicant sudo ttf-roboto vimiv\
    xorg-xbacklight bash-completion ttf-dejavu redshift gimp bluez-utils \
    jupyter-notebook firefox ntp telegram-desktop xf86-video-intel udiskie \
    xf86-input-synaptics rxvt-unicode-pixbuf zsh-syntax-highlighting-git \
    powerline-fonts-git vim-plug-git nerd-fonts-fira-code

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
