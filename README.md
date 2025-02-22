# qtile-catppuccin

***Now, a custom Arch-Based Distro/ISO is available for this Rice @ https://gitlab.com/ruturajn/RnOS_ISO. Do check it out.***

My Config Files for starship, qtile, rofi, fish, etc. I have a three bash scripts in this repo, two of those are for installing this setup
and for a base Arch-Linux Install respectively, present in the `Arch-Setup-Scripts` directory. The other one is for setting up this rice on Ubuntu,
which you can find in the `ubuntu` branch.

To use the config on Arch, you will need to do a few things apart from installing the required packages (If you are not using one of the setup scripts):
- Edit line `202` in the [dunstrc](https://github.com/4r6h/qtile-catppuccin/blob/main/dunst/dunstrc) to add the path to dunst icons, which should be
  `~/.config/dunst/icons`, or if you have not moved the `dunst` folder to your `~/.config` directory `<Path_to_these_dotfiles>/dunst/icons`.
- Edit line `6` in the [autostart.sh](https://github.com/4r6h/qtile-catppuccin/blob/main/qtile/autostart.sh) script to add the path to your wallpaper. 
  This can be skipped if you want to use nitrogen, to set your wallaper. To do that, you will need to set a wallpaper the first time you login to Qtile
  with `nitrogen`. This is only a one time thing, and the wallpaper you chose will persist, due to line `9` in the 
  [autostart.sh](https://github.com/4r6h/qtile-catppuccin/blob/main/qtile/autostart.sh) script. Also, you will need to make the autostart script executable,
  with `chmod +x <Path-to-autostart.sh>/autostart.sh`.
- Get the required fonts, i.e. [Material Icons Font](https://github.com/google/material-design-icons/raw/master/font/MaterialIcons-Regular.ttf), 
  [JetBrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf), and finally copy all fonts along
  with the `Feather.ttf` in the `fonts` directory to `~/.fonts`. Then, to update the font cache run `$ fc-cache -fv`.
- For setting up neovim navigate to this dotfiles repo and follow,
  ```
  $ sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  $ sudo pacman -S neovim
  $ cp -r <Path_To_These_Dotfiles>/nvim ~/.config/
  $ sudo pacman -S npm nodejs
  $ mkdir -p ~/.config/nvim/plugged
  $ nvim +'PlugInstall --sync' +qa
  $ sudo pacman -S lua-language-server pyright rust-analyzer
  ```
  whereas, for setting, up vim,
  ```
  $ cp <Path_To_These_Dotfiles>/.vimrc "${HOME}"/
  $ mkdir -p "${HOME}"/.vim/plugged
  $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  $ source "${HOME}"/.vimrc
  $ vim +'PlugInstall --sync' +qa
  ```
  Please, see the `echo` commands, on lines `158` to `211` in [Arch_Setup_Install.sh](https://github.com/4r6h/qtile-catppuccin/blob/main/Arch-Setup-Scripts/Arch_Setup_Install.sh) as explanation on what these lines do, for neovim and vim setup respectively, if you are unfamiliar with them.
- (Optional) Using `wpgtk` and `pywal`. The modifications, required to use them are present in the `qtile config`, and the `wal-set` script is 
  placed under `qtile/Scripts` directory. To use it with my dotfiles, follow these steps:
  ```
  # Install wpgtk from the AUR, I use 'yay', you can use any AUR-Helper you like
  $ yay -S wpgtk
  
  # Then add this line to the fish config, at the end of the 'if' block
  cat ~/.config/wpg/sequences
  
  # After that, remove the line from the autostart.sh file, that restores the wallpaper with 'nitrogen',
  # and replace it with,
  wal -R
  
  # Now, run the wal-set script using 'Alt+P'. Once, the colorscheme is generated, run
  # the following to generate gtk and icon theme.
  $ wpg-install.sh -gi
  ```
  To apply the gtk and icon theme, use `lxappearance` (or any other application that you like), for choosing the theme, whose name will be displayed, 
  when you run the command `$ wpg-install.sh -gi`. Now, this should setup everything, and whenever you run the `wal-set` script, the theme will reflect 
  everywhere. I do not use this scheme for neovim, since the generated schemes do not look that great in it. You can use it, by installing a [plugin](https://github.com/deviantfero/wpgtk.vim).
  
*Note:* 
- *The Setup Install Script places the config files in their respective directories and installs the dependencies. Please read the ```README.md``` file placed
under the `Arch-Setup-Scripts` directory and the script ,before running the script. You can just get the script using curl (see 
[Arch-Setup-Scripts/README.md](https://github.com/4r6h/qtile-catppuccin/tree/main/Arch-Setup-Scripts)), it will clone this repo and do the needfull.*
- *The Arch Install Script adds a user, partitions the disk, does a base Arch Installation etc. (see [Arch-Setup-Scripts/README.md](https://github.com/4r6h/qtile-catppuccin/tree/main/Arch-Setup-Scripts)).*
- *The `picom.conf` file here, is to be used with the original picom. For [Jonaburg's Fork of picom](https://github.com/jonaburg/picom),
  I use `jonaburg_picom.conf`. If you want to use jonaburg-picom use that.*
- If you don't see the `wifi` widget show up, change line `364` in [qtile/config.py](https://github.com/4r6h/qtile-catppuccin/blob/main/qtile/config.py)
  to your network interface.
- *To use the [bright_control](https://github.com/4r6h/qtile-catppuccin/blob/main/qtile/bright_control) script, the user will need to be a part of the 
  `video` group. This can be done by : `$ sudo usermod -aG video $USER`.*

If you are using the [Arch_Setup_Install.sh](https://github.com/4r6h/qtile-catppuccin/blob/main/Arch-Setup-Scripts/Arch_Setup_Install.sh) script all of 
these things mentioned about editing files, picom configs (It will also ask you which fork of picom you require and place the default config
from that fork in `~/.config/picom/picom.conf`), adding your user to the groups and giving you the choice to choose `pywal` with `wpgtk` will
be taken care of by the script. It will also backup your `$HOME/.config` directory before making any changes, so you will not loose any data.
Check the links from the **Theme** section, in the [Setup Details](#setup-details) section if you have any issues while installing `wpgtk` or `pywal`.

<br />

## Setup Details

| Category | Tool Used |
| --- | --- |
| Window Manager | [Qtile](https://github.com/qtile/qtile) (with [Qtile-Extras](https://github.com/elParaguayo/qtile-extras)) |
| Terminal | [Alacritty](https://github.com/alacritty/alacritty) |
| Shell    | [Fish](https://github.com/fish-shell/fish-shell) (with [Oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)) |
| Compositor | [Jonaburg's Fork of picom](https://github.com/jonaburg/picom) |
| Application Launcher | [Rofi](https://github.com/davatorium/rofi) | 
| Text Editor | [Vim](https://github.com/vim/vim), [Neovim](https://github.com/neovim/neovim) or Both|
| Browser | [Brave](https://brave.com/) |
| Notifications | [Dunst](https://github.com/dunst-project/dunst) |
| File Manager | [PCManFM](https://github.com/lxde/pcmanfm) |
| Fonts | [Fantasque Sans Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono/Regular/complete), [JetBrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete), [Fontawesome Font](https://github.com/FortAwesome/Font-Awesome) and [Material Design Icon Font](https://github.com/google/material-design-icons/blob/master/font/MaterialIcons-Regular.ttf) |
| Fetch Program | [pfetch](https://github.com/dylanaraps/pfetch), [fm6000](https://github.com/anhsirk0/fetch-master-6000) and [nerdfetch](https://github.com/ThatOneCalculator/NerdFetch) |
| Terminal Programs | [cava](https://github.com/karlstav/cava), [bashtop](https://github.com/aristocratos/bashtop), [pipes.sh](https://github.com/pipeseroni/pipes.sh), [cmatrix](https://github.com/abishekvashok/cmatrix) and [cbonsai](https://gitlab.com/jallbrit/cbonsai) |
| Theme | [Catppuccin](https://github.com/catppuccin/catppuccin) or [pywal](https://github.com/dylanaraps/pywal) with [wpgtk](https://github.com/deviantfero/wpgtk) |

<br />

## Gallery

<details>
<summary>Videos and Screenshots</summary>

https://user-images.githubusercontent.com/56625259/177325808-e83bf6b4-9f1b-420c-9234-0499991397b8.mp4

![Arch-Rice-1](https://user-images.githubusercontent.com/56625259/174547792-39bc37b6-37a7-4078-9612-7304c7d0cf2e.png)

![Arch-Rice-2](https://user-images.githubusercontent.com/56625259/174547817-b29b94e0-2054-4bce-a4a9-8f1faecc7003.png)

![Arch-Rice-Rofi](https://user-images.githubusercontent.com/56625259/174547828-075cb18c-647f-42c6-a0d2-835c86cb39d7.png)

![Arch-Rice-Wifi](https://user-images.githubusercontent.com/56625259/174547884-b01229f9-703c-4e2b-bb6f-0b21c4e6a4b5.png)

![Arch-Rice-Powermenu](https://user-images.githubusercontent.com/56625259/174547906-0334b18f-71a7-4dc7-a0f4-73a1a8ed0e47.png)

</details>

## Screenshots (Showing Volume and Brightness Control)
<details>
<summary>Old Screenshots</summary>
<br>

![Arch_Rice_Qtile](https://user-images.githubusercontent.com/56625259/170982950-a64198cd-11c6-4372-b731-699f6e24422f.png)

![Arch_Rice_Qtile_1](https://user-images.githubusercontent.com/56625259/170983002-f8f7a216-383c-4a12-967f-8c12be56008f.png)

![Arch_Rice_Qtile_Rofi](https://user-images.githubusercontent.com/56625259/170983036-b79e3f1c-ad1e-4a70-a4b0-2b106fefdbeb.png)

![Arch_Rice_Qtile_Vol-Up](https://user-images.githubusercontent.com/56625259/170983071-5ced2d72-36a0-40ff-8742-ea7f110885e1.png)

![Arch_Rice_Qtile_Vol-Down](https://user-images.githubusercontent.com/56625259/170983084-7ebc4cdb-5bdf-447d-90f2-37a14d1538ff.png)

![Arch_Rice_Qtile_Vol-Mute](https://user-images.githubusercontent.com/56625259/170983101-205fc931-5138-4d9b-a145-4cedd5ab8e1e.png)

![Arch_Rice_Qtile_Vol-UnMute](https://user-images.githubusercontent.com/56625259/170983129-452a26be-e0ee-4194-9e9f-35296a9c6be6.png)

![Arch_Rice_Qtile_Brightness](https://user-images.githubusercontent.com/56625259/170983161-d5827eee-dd7f-406a-95bd-a026cfc34b20.png)

<br />
  
</details>

## Credits

Wallpapers taken from [wallpaperscraft](https://wallpaperscraft.com), and [wallpaperbetter](https://www.wallpaperbetter.com/en/search?q=1920x1080).
