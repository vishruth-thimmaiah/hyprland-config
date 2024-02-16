# Dotfiles

#### WM: Hyprland
#### Widgets: Eww
* tray icons use [this fork](https://github.com/ralismark/eww/tree/tray-3)
#### Theme: Catppuccin
#### Icons: Candy Icons
#### Terminal: Alacritty
#### Browser: Firefox

#### [Wallpaper](https://sh.reddit.com/r/wallpaper/comments/17prscu/city_train_3840x2160/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

---
# Preview
![image1](https://github.com/Vishruth-Thimmaiah/hyprland-config/assets/111981004/bcd8f451-d77c-4ebe-a4ef-ca5aee8f62ec)
![image2](https://github.com/Vishruth-Thimmaiah/hyprland-config/assets/111981004/6375730d-2b94-495d-aef4-50d2ac5ad030)
![image3](https://github.com/Vishruth-Thimmaiah/hyprland-config/assets/111981004/e4e3d42c-9af9-4cb3-a9de-0402f0380470)



---

## Other packages used:

* **swww**
* **playerctl**
* **dunst**
* **swaylock**
* **swayidle**
* **cliphist**
* **light**
* **rofi**
* **gammastep**
* **chayang**
* **imagemagick**

---

# Installation:

#### 1. Install packages on Arch with [yay](https://github.com/Jguer/yay):
```bash
yay -S hyprland eww-tray-wayland-git swww playerctl dunst swaylock-effects-git swayidle sway-audio-idle-inhibit-git cliphist light rofi-lbonn-wayland chayang gammastep imagemagick
# Fonts
yay -S ttf-maple ttf-firacode-nerd
```
#### 2. clone repo:
```bash
git clone https://github.com/Vishruth-Thimmaiah/hyprland-config.git
```
#### 3.
- ##### Using [dotter-rs](https://github.com/SuperCuber/dotter)
    ```bash
    cd hyprland-config
    ./dotter
    rename .dotter/.local.toml .dotter/local.toml
    ```
    Replace the variables with its correct values in local.toml
- ##### manually
    ```bash
    cd hyprland-config
    cp config ~/.config -r
    cp firefox/chrome ~/.mozilla/firefox/xxxxxxxx.default-release/chrome/ -r # replace xxxxxxxx with the respective directory name
    cp bin ~/.local/bin -r
    cp zshrc ~/.zshrc
    cp p10k.zsh ~/.p10k.zsh
    ```
    Replace ```{{lan}}```, ```{{lon}}``` in ```.config/gammastep/config.ini``` with your latitute and longitude, and ```{{weather_api}}```, ```{{weather_city}}``` with your openweather api and city in ```.config/eww/menu/scripts/api```.
