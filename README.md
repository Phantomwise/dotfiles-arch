```
╔═══╗              ╓            
║   ║              ║            
╠══╦╝ ╔══╗ ╒══╗ ╔══╣ ╔═╦═╗ ╔══╗ 
║  ╚╗ ╠══╝ ╔══╣ ║  ║ ║ ║ ║ ╠══╝ 
╜   ╙ ╚══╛ ╚══╝ ╚══╝ ╜ ╙ ╙ ╚══╛ 
```

This is my attempt to use stow, git and github to organise my config files, hopefully it'll be less of a mess this way ^_^"

![Hyprland Busy Workspace](https://raw.githubusercontent.com/Phantomwise/dotfiles/main/arch/screenshot-busy-workspace-2.png "Busy Workspace")

## Currently included

Everything Wayland only because I hate myself.

- Shell :
  - **bash**
  - **zsh**
- Applications :
  - 🚧 **[dunst](https://github.com/dunst-project/dunst)** : notification daemon
  - ✅ **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** : fetch
  - ✅ **[Hyprland](https://github.com/hyprwm/Hyprland)** : wayland compositor (dynamic tiler)
  - 💩 **[Hyprpaper](https://github.com/hyprwm/hyprpaper)** : wallpaper manager *(to rewrite)*
  - ✅ **[Kitty](https://sw.kovidgoyal.net/kitty/)** : terminal emulator
  - 🗑️ ~~[Mako](https://github.com/emersion/mako)~~ : notification daemon *(outdated, replaced by dunst)*
  - 🗑️ ~~[Neofetch](https://github.com/dylanaraps/neofetch)~~ : fetch *(outdated, replaced by fastfetch)*
  - ✅ **[Rofi lbonn Wayland fork](https://github.com/lbonn/rofi)** : app launcher / everything launch menu / rofi is great rofi is awesome rofi is god
  - ✅ **[Swayimg](https://github.com/artemsen/swayimg)** : image viewer
  - ✅ **[VSCodium](https://github.com/VSCodium/vscodium)** : code editor
  - ✅ **[Waybar](https://github.com/Alexays/Waybar)** : bar
- Other stuff :
  - 💩 **systemd** : services and stuff *(to rewrite)*
  - ✅ **/etc/issue** : tty pre-login banner *🎵 oooh you're so preeeetty 🎵*<BR />
![Preview of /etc/issue](https://raw.githubusercontent.com/Phantomwise/dotfiles/main/arch/screenshot-etc-issue-preview.png "/etc/issue")
- Resources :
  - Icons
  - Scripts
  - Sounds

## To add
- Wallpapers
- Keyboard layouts (GUI and tty)
  - GUI
    - 💩 /usr/share/X11/xkb/symbols/us
  - tty
    - ✅ /etc/vconsole.conf
    - 🚧 /usr/share/kbd/keymaps/i386/colemak/colemak-custom.map

## Not yet configured I really should get around to it
- ⏳ [Swaybg](https://github.com/swaywm/swaybg)
- ⏳ [Swaylock](https://github.com/swaywm/swaylock)
- ⏳ [Hypridle](https://github.com/hyprwm/hypridle)
- ⏳ [Sway](https://github.com/swaywm/sway) *(lost my config T_T)*

## Stuff to try
- 📌 [Hyprland plugins](https://github.com/hyprwm/hyprland-plugins)
  - 📌 [hy3](https://github.com/outfoxxed/hy3) : i3 plugin for Hyprland ==> better tabbed grouping of windows ?
- 📌 [Niri](https://github.com/YaLTeR/niri) : wayland compositor (infinitely scrollable tiler)

## Legend
- ✅ Working config
- 💩 Working config, but it's a mess and really badly done, need to rewrite
- 🚧 WIP, only partially working, probably full of broken stuff and temporary code for testing
- 🗑️ Outdated, not used anymore
- ⏳ To configure
- 📌 To try
