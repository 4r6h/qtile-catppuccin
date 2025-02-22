#!/usr/bin/env bash

# ***************************************
# * Author: 4r6h/Rahat                  *
# * github: https://www.github.com/4r6h *
# * forked: Ruturajn/Dotfiles           *
# ***************************************
# Copyright (c) 2022, Ruturaj A. Nanoti, Modified by 4r6h/Rahat All Rights Reserved
# Run this script for setting up the Rice.

BRed="\e[1;31m"
BGreen="\e[1;32m"
BYellow="\e[1;33m"
BBlue="\e[1;34m"
End_Colour="\e[0m"

echo -ne "\e[34m
 888888ba           dP                  dP   
 88     8b          88                  88   
 a88aaaa8P .d8888b. 88d888b. .d8888b. d8888P 
 88    8b  88    88 88    88 88    88   88   
 88     88 88.  .88 88    88 88.  .88   88   
 dP      dP 88888P8 dP    dP  88888P8   dP   
================================================

        Arch-Linux Qtile Setup Script                       

================================================
\e[0m
"

echo -e "${BRed}==========================================================================================================================${End_Colour}"
echo -e "${BRed}[ * ]!This script is going to backup your current .config folder and any vim related files that you mave have in the
     home directory to the folders named 'backup_dot_config' and 'vim_backup_files' respectively. Then it is going to
     install some packages that are required for the rice, and place the respective dotfiles in the .config directory.
     The .config directory in your system will not be replaced rather stuff will be added to it. So there will not be 
     loss of current config files.\n${End_Colour}"
echo -e "${BRed}==========================================================================================================================${End_Colour}"
read -rp "[1;34m[ * ]Do you want to proceed?[Y/n]:[0m" setup_ans

if [[ -z ${setup_ans} || ${setup_ans} == "y" || ${setup_ans} == "Y" ]]; then
	# Backup the current config files
	echo -e "${BYellow}[ * ]Backing up current config folder and files in backup_dot_config${End_Colour}"
	if [[ -d "${HOME}"/.config ]]; then
		mkdir "${HOME}"/backup_dot_config
		cp -r "${HOME}"/.config/. "${HOME}"/backup_old_config
	else
		mkdir "${HOME}"/.config
	fi

	# Backup vim related config files
	mkdir "${HOME}"/vim_backup_files
	echo -e "${BYellow}[ * ]Backing up vim related config files in vim_backup_files${End_Colour}"
	if [[ -f "${HOME}"/.vimrc ]]; then
		mv "${HOME}"/.vimrc "${HOME}"/vim_backup_files/.
	fi

	if [[ -d "${HOME}"/.vim ]]; then
		mv "${HOME}"/.vim "${HOME}"/vim_backup_files/.
	fi

	if [[ ! $(ls -A "${HOME}"/vim_backup_files) ]]; then
		rm -r "${HOME}"/vim_backup_files
	fi

	# Install the required packages for the Rice
	echo -e "${BYellow}[ * ]Installing packages${End_Colour}"
	pkgs=(
	'neofetch' 
	'htop'
	'nitrogen'
	'xorg'
	'fish'
	'rofi'
	'dunst'
	'dialog'
	'python-dbus'
	'linux-headers'
	'base'
	'base-devel'
	'p7zip'
	'unzip'
	'tar'
	'python-pip'
	'papirus-icon-theme'
	'cmatrix'
	'pamixer'
	'feh'
	'alsa-utils'
	'pavucontrol'
	'alacritty'
	'git'
	'vim'
	'curl'
	'flameshot'
	'pulseaudio'
	'playerctl'
	'scrot'
	'ttf-fantasque-sans-mono'
	'brightnessctl'
	'bc'
	'bashtop'
	'acpi'
	'github-cli'
	'wget'
	'shfmt'
	'lxsession'
	'lxappearance'
	'yad'
	'gnome-disk-utility'
	'ripgrep'
	'udiskie'
	'xclip'
	'dex'
	'starship'
	'ttf-joypixels'
	'python-neovim'
	'python'
	'bat'
	'ueberzug'
	'ffmpegthumbnailer'
	'libjpeg'
	'libpng'
	'ncdu'
	'tree'
	'xsel'
	'fd'
	'pcmanfm'
	'kvantum'
	'lxappearance'
	'vifm'
	)
	for pkg in "${pkgs[@]}";	do
		sudo pacman -S $pkg --noconfirm --needed
					done
	while true
	do
	# Adding a swapfile
	read -rp "[1;34m[ * ]Do you want to create a swapfile [Y/n]:[0m" ans
	if [[ -z ${ans} || ${ans} == "y" || ${ans} == "Y" ]]; then
		echo -e "${BYellow}[ * ]Creating 4G swapfile${End_Colour}"
		sudo dd if=/dev/zero of=/swapfile bs=1M count=4096
		sudo chmod 600 /swapfile
		sudo mkswap /swapfile
		sudo swapon /swapfile
		echo "/swapfile                                       none            swap            defaults        0 0" | sudo tee -a /etc/fstab
		echo -e "${BGreen}Swapfile creation and configuration successfull !!${End_Colour}"
		break
	elif [[ ${ans} == "n" || ${ans} == "N" ]]; then
		echo -e "${BRed}Skipping Swapfile creation${End_Colour}"
		break
	else
		echo -e "${BRed}Not a valid option, please select an option.${End_Colour}"
	fi
	done

	# Install stuff with pip
	# echo -e "${BYellow}[ * ]Installing fontawesome and dbus-next for icons and notifications${End_Colour}"
	echo -e "${BYellow}[ * ]Installing fontawesome${End_Colour}"
	sudo pacman -S python-pip --noconfirm --needed
	sudo pip3 install fontawesome

	# Install `paru` as the AUR Helper, interact wherever required
	aur_name="paru"
	if [[ -z $(which ${aur_name}) ]]; then
	read -rp "[1;34m[ * ]Do you want to install paru as the AUR Helper? [Y/n]:[0m" aur_ans
	if [[ ${aur_ans} == "n" || ${aur_ans} == "N" ]]; then
		read -rp "[1;34m[ * ]Please enter the name of the already installed AUR Helper:[0m" aur_name
		if [[ -z ${aur_name} ]]; then
			echo -e "${BRed}FATAL : Cannot proceed without an AUR Helper !!${End_Colour}" && exit
		fi
	elif [[ -z ${aur_ans} || ${aur_ans} == "y" || ${aur_ans} == "Y" ]]; then
		echo -e "${BYellow}[ * ]Installing paru as the AUR Helper${End_Colour}"
		git clone https://aur.archlinux.org/paru.git
		cd ./paru || exit
		makepkg -si
	fi
	fi

	# Upgrade system with paru
	echo -e "${BYellow}[ * ]Updating and Upgrading system with ${aur_name}${End_Colour}"
	"${aur_name}" -Syu --noconfirm --needed

	# Install lsd for the ls command and qtile-extras from desired AUR Helper
	echo -e "${BYellow}[ * ]Installing lsd, qtile-git, and qtile-extras with ${aur_name}${End_Colour}"
	"${aur_name}" -S lsd qtile-git qtile-extras-git --noconfirm --needed

	# Install the required fonts
	echo -e "${BYellow}[ * ]Installing Nerd Fonts Complete with ${aur_name}${End_Colour}"
	"${aur_name}" -S nerd-fonts-complete --noconfirm --needed

	# Install pipes,cava, and brave-bin with paru
	echo -e "${BYellow}[ * ]Installing pipes.sh, cava, brave-bin and wpgtk with ${aur_name}${End_Colour}"
	"${aur_name}" -S pipes.sh cava brave-bin wpgtk --noconfirm --needed

	# Install some other packages with paru
	echo -e "${BYellow}[ * ]Installing some other misc. packages with ${aur_name}${End_Colour}"
	"${aur_name}" -S lf i3lock-color betterlockscreen tty-clock-git cbonsai --noconfirm --needed

	# Getting pfetch as fetch tool
	echo -e "${BYellow}[ * ]Installing pfetch as the fetch tool${End_Colour}"
	"${aur_name}" -S pfetch --noconfirm --needed
	
	# Getting cursor themes
	echo -e "${BYellow}[ * ]Installing cursor themes${End_Colour}"
	"${aur_name}" -S sweet-cursors-theme-git --noconfirm --needed
	
	# Getting gtk+ and qt themes
	echo -e "${BYellow}[ * ]Installing gtk+ themes${End_Colour}"
	"${aur_name}" -S dracula-gtk-theme ant-dracula-kvantum-theme-git --noconfirm --needed

	# Place all the folders in the $(HOME)/.config directory
	echo -e "${BYellow}[ * ]Placing dunst folder in ~/.config/dunst and making vol_script executable${End_Colour}"
	cp -r ../dunst "${HOME}"/.config/
	sed -i "s|    icon_path = .*|    icon_path = $HOME/.config/dunst/icons|" "${HOME}"/.config/dunst/dunstrc

	echo -e "${BYellow}[ * ]Placing rofi folder in ~/.config/rofi${End_Colour}"
	cp -r ../rofi "${HOME}"/.config/

	echo -e "${BYellow}[ * ]Placing cava folder in ~/.config/cava${End_Colour}"
	cp -r ../cava "${HOME}"/.config/

	echo -e "${BYellow}[ * ]Placing qtile/config.py and qtile/autostart.sh folder in ~/.config/qtile  and making autostart.sh executable${End_Colour}"
	cp -r ../qtile "${HOME}"/.config/
	sudo mv ../qtile-wallpapers /usr/share/backgrounds/
	echo "nitrogen --set-zoom-fill /usr/share/backgrounds/China_Town.jpg --save" | sudo tee -a "${HOME}"/.config/qtile/autostart.sh
	echo "~/.config/qtile/Scripts/get_ip.sh &" | sudo tee -a "${HOME}"/.config/qtile/autostart.sh
	chmod +x "${HOME}"/.config/qtile/autostart.sh

	echo -e "${BYellow}[ * ]Placing alacritty config in ~/.config/${End_Colour}"
	mkdir -p "${HOME}/.config/alacritty"
	curl -fsSL "https://raw.githubusercontent.com/4r6h/Dot4iles/main/AlacrittyConfig/alacritty.yml" >"${HOME}"/.config/alacritty/alacritty.yml
	curl -fsSL "https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin.yml" >"${HOME}"/.config/alacritty/catppuccin.yml

	echo -e "${BYellow}[ * ]Placing vifm folder in ~/.config/vifm${End_Colour}"
	cp -r ../vifm "${HOME}"/.config/

	viminstall() {
		echo -e "${BYellow}[ * ]Installing Vim${End_Colour}"
		echo -e "${BYellow}[ * ]Placing .vimrc in ~/${End_Colour}"
		cp ../.vimrc "${HOME}"/

		echo -e "${BYellow}[ *]Making ~/.vim/plugged directory"
		mkdir -p "${HOME}"/.vim/plugged

		echo -e "${BYellow}[ * ]Installing Vim-Plug${End_Colour}"
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

		echo -e "${BYellow}[ * ]Sourcing .vimrc${End_Colour}"
		source "${HOME}"/.vimrc

		echo -e "${BYellow}[ * ]Installing vim plugins${End_Colour}"
		vim +'PlugInstall --sync' +qa
	}

	nviminstall() {
		echo -e "${BYellow}[ * ]Installing Neovim${End_Colour}"

		# Installing Vim-Plug for neovim
		echo -e "${BYellow}[ * ]Installing Vim-Plug${End_Colour}"
		sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

		# Check if neovim is installed, if it is remove it and install latest
		echo -e "${BYellow}[ * ]Installing Latest Neovim${End_Colour}"
		sudo pacman -S neovim --noconfirm --needed

		echo -e "${BYellow}[ * ]Placing nvim directory in ~/.config${End_Colour}"
		cp -r ../nvim ~/.config

		# Install nodejs
		echo -e "${BYellow}[ * ]Installing Latest Nodejs${End_Colour}"
		sudo pacman -S npm nodejs --noconfirm --needed
		
		# Make a plugged directory in ~/.config/nvim/
		echo -e "${BYellow}[ * ]Making directory ~/.config/nvim/plugged${End_Colour}"
		mkdir -p ~/.config/nvim/plugged

		# Install plugins
		nvim +'PlugInstall --sync' +qa

		# Install LSP Servers
		# nvim +'LspInstall --sync pyright' +qa
		# nvim +'LspInstall --sync sumneko_lua' +qa

		# # Install Rust if not installed
		# echo -e "${BYellow}[ * ]Installing Latest Rust${End_Colour}"
		# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
		# source "${HOME}"/.cargo/env
		# rustup component add rust-src
		# nvim +'LspInstall --sync rust_analyzer' +qa

		sudo pacman -S lua-language-server pyright rust-analyzer
	}

	bothinstall() {
		viminstall
		nviminstall
	}

	while true
	do
	echo -e "${BYellow}[ * ]Choose your Preferred Editor : "
	echo -e "1) vim"
	echo -e "2) neovim"
	echo -e "3) vim & neovim"
	read -rp "[1;34m[ * ]Enter your choice : [0m" editor_ans

	case "${editor_ans}" in
	1)
		viminstall
		break
		;;

	2)
		nviminstall
		break
		;;
	
	3)
		bothinstall
		break
		;;
	*)
		echo -e "${BRed} please select type an option. then press enter${End_Colour}"
	esac
	done

	echo -e "${BYellow}[ * ]Making ~/.config/picom${End_Colour}"
	mkdir -p "${HOME}"/.config/picom

	while true
	do
	echo -e "${BYellow}[ * ]Choose the option for the compositor:"
	echo -e "1) picom"
	echo -e "2) jonaburg-picom"
	echo -e "3) ibhagwan-picom${End_Colour}"
	echo -e "${BGreen}Normal picom, i.e. option '1' works best in a VM${End_Colour}"
	read -rp "[1;34m[ * ]Enter the number for the picom compositor you want to install :[0m" picom_ans

	case "${picom_ans}" in
	1)
		echo -e "${BYellow}[ * ]Installing picom${End_Colour}"
		sudo pacman -S picom --noconfirm --needed

		echo -e "${BYellow}[ * ]Placing picom config in ~/.config/picom${End_Colour}"
		cp ../picom/picom.conf "${HOME}"/.config/picom/
		break
		;;
	2)
		echo -e "${BYellow}[ * ]Installing picom-jonaburg-git with ${aur_name}${End_Colour}"
		"${aur_name}" -S picom-jonaburg-git --noconfirm --needed

		echo -e "${BYellow}[ * ]Placing picom config in ~/.config/picom${End_Colour}"
		cp ../picom/jonaburg_picom.conf "${HOME}"/.config/picom/picom.conf
		break
		;;
	3)
		echo -e "${BYellow}[ * ]Installing picom-ibhagwan-git with ${aur_name}${End_Colour}"
		"${aur_name}" -S picom-ibhagwan-git --noconfirm --needed

		echo -e "${BYellow}[ * ]Placing picom config in ~/.config/picom${End_Colour}"
		curl -fsSL "https://raw.githubusercontent.com/ibhagwan/picom/next-rebase/picom.sample.conf" >"${HOME}"/.config/picom/picom.conf
		break
		;;
	*)
		echo -e "${BRed} please select type an option. then press enter${End_Colour}"

	esac
	done

	echo -e "${BYellow}[ * ]Changing the picom executable call in autostart.sh${End_Colour}"
	if [[ $(systemd-detect-virt) ]]; then
		sed -i 's|picom.*|picom --no-vsync \&|' "${HOME}"/.config/qtile/autostart.sh
	fi

	# Installing material design icon font
	echo -e "${BYellow}[ * ]Installing Material-Design-Icon Font${End_Colour}"
	wget -cqP "https://github.com/4r6h/material-design-icons/raw/master/font/MaterialIcons-Regular.ttf"
	sudo mv *.ttf /usr/share/fonts
	sudo mv ../*.ttf /usr/share/fonts
	fc-cache -fv

	# echo -e "${BYellow}[ *]Installing JetBrains Mono Nerd Font${End_Colour}"
	# wget -cqP "${HOME}"/.fonts "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"
	# fc-cache -fv

	# Install fish and change default shell
	while true
	do
	read -rp "[1;34m[ * ]Do you want to change the default shell to fish? [Y/n]:[0m" shell_ans
	if [[ -z ${shell_ans} || ${shell_ans} == "y" || ${shell_ans} == "Y" ]]; then
		echo -e "${BYellow}[ * ]Changing Default shell to fish and installing omf with robbyrussell theme${End_Colour}"
		chsh -s /usr/bin/fish
		echo -e "${BYellow}[ * ]Placing fish config in ~/.config/fish${End_Colour}"
		mkdir -p "${HOME}"/.config/fish
		curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install >install
		fish install --path=~/.local/share/omf --config=~/.config/omf --noninteractive
		fish -c "omf install robbyrussell"
		cp ../fish/config.fish "${HOME}"/.config/fish/config.fish
		sed -i 's|set -gx fish_user_paths ~/.local/bin/|set -gx fish_user_paths ~/.local/bin/ ~/.local/share/nvim/lsp_servers/python/node_modules/.bin ~/.local/share/nvim/lsp_servers/rust ~/.cargo/bin ~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin|g' "${HOME}"/.config/fish/config.fish
		rm install
		break
	elif [[ ${shell_ans} == "n" || ${shell_ans} == "N" ]]; then
		echo -e "${BRed}Skipping Shell change${End_Colour}"
		break
	else
		echo -e "${BRed}Not a valid option, please type [Y/n] then press enter.${End_Colour}"
	fi
	done
	echo -e "[ * ]Placing lf in ~/.config${End_Colour}"
	cp -r ../lf "${HOME}"/.config/

	echo -e "[ * ]Placing betterlockscreen config file in ~/.config${End_Colour}"
	cp ../betterlockscreenrc "${HOME}"/.config/

	# Enabling pulseaudio for user
	echo -e "${BYellow}[ * ]Enabling pulseaudio at startup${End_Colour}"
	systemctl --user enable pulseaudio

	# Adding user to video group
	echo -e "${BYellow}[ * ]Add user to video and audio group${End_Colour}"
	sudo usermod -aG video "$USER"
	sudo usermod -aG audio "$USER"


	#sddm_themes_dir
	sddm_conf="/etc/sddm.conf"
	sugar_candy="/usr/share/sddm/themes/Sugar-Candy"

	#lightdm_themes_dir
	lightdm_conf="/etc/lightdm/lightdm.conf"
	aether="/usr/share/lightdm-webkit/themes/lightdm-webkit-theme-aether"
	glorious="/usr/share/lightdm-webkit/themes/glorious"
	slick="/etc/lightdm/slick-greeter.conf"

	# # Enable lightdm service with the following steps
	# read -rp "[1;34m[ * ]Do you want to install the lightdm login manager?[Y/n]:[0m" lightdm_ans
	# if [[ -z ${lightdm_ans} || ${lightdm_ans} == "y" || ${lightdm_ans} == "Y" ]] ; then
	#     echo -e "${BYellow}[ * ]Installing Lightdm${End_Colour}"
	#     sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
	#     echo -e "${BYellow}[ * ]Uncommenting 'greeter-session' option in '/etc/lightdm/lightdm.conf' and replacing with 'greeter-session=lightdm'${End_Colour}"
	#     sudo sed -i "s/# greeter-session = Session to load for greeter/greeter-session=lightdm/g" /etc/lightdm/lightdm.conf
	#     echo -e "${BYellow}[ * ]Starting the lightdm service at boot with 'sudo systemctl enable lightdm.service'${End_Colour}"
	#     sudo systemctl enable lightdm.service
	#     echo -e "${BYellow}[ * ]Reboot the system with 'sudo systemctl reboot'${End_Colour}"
	# elif [[ ${lightdm_ans} == "n" || ${lightdm_ans} == "N" ]] ; then
	#     echo -e "${BRed}Skipping Lightdm Installation${End_Colour}"
	# else
	#     echo -e "${BRed}Not a valid option, Skipping Lightdm Installation${End_Colour}"
	# fi

	base_sddm() {
		echo -e "${BYellow}[ * ]Installing sddm${End_Colour}"
		sudo pacman -S sddm
	}

	# sddm themes

	sugar_candy() {
		base_sddm	
		echo -e "${BYellow}[ * ]Installing Sugar Candy theme for sddm and Sweet-Cursor theme with ${aur_name}${End_Colour}"
		"${aur_name}" -S sddm-theme-sugar-candy-git --noconfirm --needed
		echo -e "${BYellow}[ * ]Editing the conf file for sddm to change the theme to Sugar-Candy${End_Colour}"
		sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf
		sudo sed -i 's/Current=.*/Current=Sugar-Candy/' /etc/sddm.conf
		echo -e "${BYellow}[ * ]Editing the conf file for Sugar-Candy to change the cursor theme to Sweet-Cursors${End_Colour}"
		sudo sed -i 's/CursorTheme=.*/CursorTheme=Sweet-cursors/' /etc/sddm.conf
		echo -e "${BYellow}[ * ]Editing the conf file for Sugar-Candy to change the time to 12 hours format (AM/PM)${End_Colour}"
		sudo sed -i 's/HourFormat=.*/HourFormat="h:mm:ss A"/' /usr/share/sddm/themes/Sugar-Candy/theme.conf
		echo -e "${BYellow}[ * ]Starting the sddm service at boot with 'sudo systemctl enable sddm.service'${End_Colour}"
		sudo systemctl enable sddm.service
		echo -e "${BYellow}[ * ]Reboot the system with 'sudo systemctl reboot'${End_Colour}"
	}

	sddm() {
		# Install and Enable sddm service with the following steps
		
		while true 
		do
		echo "(0) Back to previous menu"
		echo "(1) Sugar Candy sddm theme. [Pre Configured and Tested]"
		read -rp "[1;34m[ * ]What lightdm theme do you want to install:[0m" lm_theme
		case $lm_theme in
			(0)
					break;;
			(1) sugar_candy
					break;;	
			(*) echo -e "${BRed}cannot proceed withouta login manager!!${End_Colour}"
		esac
		done
	}

	base_lightdm() {
		
		echo -e "${BYellow}[ * ]Installing lightdm${End_Colour}"
		sudo pacman -S lightdm
	}

	# lightdm themes
		aether() {	
			base_lightdm
			echo -e "${BYellow}[ * ]Installing Auther theme for lightdm and Sweet-Cursor theme with ${aur_name}${End_Colour}"
			"${aur_name}" -S lightdm-webkit-theme-aether --noconfirm --needed
			echo -e "${BYellow}[ * ]Editing the conf file for lightdm to change the theme to Aether${End_Colour}"
			sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = lightdm-webkit-theme-aether #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
			sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
			echo -e "${BYellow}[ * ]Starting the lightdm service at boot with 'sudo systemctl enable lightdm.service'${End_Colour}"
			sudo systemctl enable lightdm.service
			echo -e "${BYellow}[ * ]Reboot the system with 'sudo systemctl reboot'${End_Colour}"
		}

		glorious() {
			base_lightdm
			echo -e "${BYellow}[ * ]Installing Glorious theme for lightdm theme with ${aur_name}${End_Colour}"
			"${aur_name}" -S lightdm-webkit2-theme-glorious --noconfirm --needed
			echo -e "${BYellow}[ * ]Editing the conf file for lightdm to change the theme to Glorious${End_Colour}"
			sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
			sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
			sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
			echo -e "${BYellow}[ * ]Starting the lightdm service at boot with 'sudo systemctl enable lightdm.service'${End_Colour}"
			sudo systemctl enable lightdm.service
			echo -e "${BYellow}[ * ]Reboot the system with 'sudo systemctl reboot'${End_Colour}"
		}

		slick() {
			base_lightdm
			echo -e "${BYellow}[ * ]Installing Slick-greeter theme for lightdm with ${aur_name}${End_Colour}"
			"${aur_name}" -S lightdm-slick-greeter --noconfirm --needed
			echo -e "${BYellow}[ * ]Editing the conf file for lightdm to change the theme to Slick-greeter${End_Colour}"
			cp ../slick-greeter.conf /etc/lightdm/ 
			sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-slick-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
			echo -e "${BYellow}[ * ]Starting the lightdm service at boot with 'sudo systemctl enable lightdm.service'${End_Colour}"
			sudo systemctl enable lightdm.service
			echo -e "${BYellow}[ * ]Reboot the system with 'sudo systemctl reboot'${End_Colour}"
		}

	lightdm() {
		# Install and Enable lightdm service with the following steps	
	
		while true 
		do
		echo "(0) Back to previous menu"
		echo "(1) Aether lightdm webkit theme. [Not Tested]"
		echo "(2) Glorious lightdm webkit2 theme. [Not Tested]"
		echo "(3) Slick lightdm gtk theme. [Not Tested]"
		read -rp "[1;34m[ * ]What lightdm theme do you want to install:[0m" lm_theme
		case $lm_theme in
			(0)
					break;;
			(1) aether
					break;;
			(2) glorious
					break;;
			(3) slick
					break;;
			(*) echo -e "${BRed}cannot proceed withouta login manager!!${End_Colour}"
		esac
		done
	}
	while true
	do
		echo "(1) Sddm already configured only 1 theme. [Default]"
		echo "(2) Lightdm not configured and chose a theme from"
		echo "    3 defferent themes. [Not Tested]"
		read -rp "[1;34m[ * ]What login manager do you want to install:[0m" lm_ans
		case $lm_ans in
			(1) sddm
					if [[ -d $sugar_candy && -e $sddm_conf ]]; then
						break
					else
						echo -e "\n${BRed}cannot proceed without a login manager!!${End_Colour}\n"
						continue
					fi
						;;
			(2) lightdm
					if [[ -d $aether || -d $glorious || -d $slick && -e $lightdm_conf ]]; then
						break
					else
						echo -e "\n${BRed}cannot proceed without a login manager!!${End_Colour}\n"
						continue	
					fi
						;;
			(*) echo -e "\n${BRed}cannot proceed without a login manager!!${End_Colour}\n"
		esac
	done
	# Installation Success
	echo -e "${BGreen}Installation Successfull,${End_Colour}"
	echo -e "${BGreen}press any key to reboot your system.${End_Colour}"
	read input
	case $input in
		(*) sudo systemctl reboot;;
	esac

else
	echo -e "${BRed}[ * ]Skipping Rice Setup${End_Colour}"
	exit
fi
