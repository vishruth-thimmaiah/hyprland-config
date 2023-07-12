# Hyprland Configuration with Eww

## [Hyprland](https://github.com/hyprwm/Hyprland "Hyprland")

## [Eww](https://github.com/elkowar/eww "Eww")

![image](hypr/screenshots/desktop.png)
![image2](hypr/screenshots/dashboard.png)

### References

* [Sidebar by rxyhn](https://github.com/rxyhn/bspdots)
* [Dashboard by adi1090x](https://github.com/adi1090x/widgets)

### Other packages used:

* **hyprpaper**
* **playerctl**
* **dunst**
* **swaylock**
* **swayidle**
* **xss-lock**
* **cliphist**
* **light**
* **rofi**

#### Install:
to install packages on Arch with [yay](https://github.com/Jguer/yay):
```bash
yay -S hyprland eww-wayland hyprpaper playerctl dunst swaylock swayidle xss-lock cliphist light rofi
```
Copy repo:
```bash
git clone https://github.com/Vishruth-Thimmaiah/hyprland-config.git
```
cd into hyprland-config and copy hypr/, eww/, dunst/ and swaylock/ to $HOME/.config.
```bash
cd hyprland-config; cp -r * ~/.config/
```

For weather info, rename eww/dashboard/apis.sample.sh to eww/dashboard/apis.sh and add [openweather api key](https://openweathermap.org/api) and city to the file.

#### Optional

* **polkit-gnome** and **gnome-keying**

##### Install
On Arch:
```bash
yay -S polkit-gnome gnome-keyring
```

#### Note: This config has been tested only on Arch Linux

