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
  - ✅ **bash**
  - ✅ **zsh**
- Applications :
  - 🚧 **[dunst](https://github.com/dunst-project/dunst)** : notification daemon *(WIP, finally made notifications that can be triggered by udev rules !!! \o/)*
  - ✅ **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** : fetch
  - 🚧 **[GDB](https://www.gnu.org/software/gdb/)** : debugger
  - 🗑️ **[Hyprland](https://github.com/hyprwm/Hyprland)** : dynamic tiling wayland compositor *(outdated, went back to sway)*
  - 🗑️ **[Hyprpaper](https://github.com/hyprwm/hyprpaper)** : wallpaper utility *(to rewrite)* *(outdated, switched to swaybg)*
  - ✅ **[Kitty](https://sw.kovidgoyal.net/kitty/)** : terminal emulator
  - 🗑️ ~~[Mako](https://github.com/emersion/mako)~~ : notification daemon *(outdated, replaced by dunst)*
  - 🗑️ ~~[Neofetch](https://github.com/dylanaraps/neofetch)~~ : fetch *(outdated, replaced by fastfetch)*
is awesome rofi is god
  - ✅ **[Rofi lbonn Wayland fork](https://github.com/lbonn/rofi)** : app launcher / everything launch menu / rofi is great rofi
  - ✅ **[Sway](https://github.com/swaywm/sway)** : manual tiling wayland compositor
  - ✅ **[Swaybg](https://github.com/swaywm/swaybg)** : wallpaper utility
  - ✅ **[Swayimg](https://github.com/artemsen/swayimg)** : image viewer
  - 💩 **[Vim](https://www.vim.org/)** : terminal text editor *(Can't be bothered to recompile it to make clipboard support work, nor to remap EVERYTHING so it's not god-awful with a colemak keyboard layout)*
  - 🗑️ **[VSCodium](https://github.com/VSCodium/vscodium)** : code editor
  - ✅ **[Waybar](https://github.com/Alexays/Waybar)** : bar
- Other stuff :
  - 💩 **systemd** : services and stuff *(to rewrite, it's a mess)*
  - ✅ **/etc/issue** : tty pre-login banner *🎵 oooh you're so preeeetty 🎵*<BR />
![Preview of /etc/issue](https://raw.githubusercontent.com/Phantomwise/dotfiles/main/arch/screenshot-etc-issue-preview.png "/etc/issue")
- Keyboard layouts
  - GUI
    - 💩 `/usr/share/X11/xkb/symbols/us` *(It works but it's kind of a mess)*
  - tty
    - ✅ `/etc/vconsole.conf`
    - 🚧 `/usr/share/kbd/keymaps/i386/colemak/colemak-custom.map`
<!--
- Resources :
  - Icons
  - Scripts
  - Sounds
  - Wallpapers
-->

## To add
- ...

## Not yet configured I really should get around to it
- ⏳ [Swaylock](https://github.com/swaywm/swaylock)
- ⏳ [Hypridle](https://github.com/hyprwm/hypridle)
- 📌 nushell

## Stuff to try
- 📌 [Niri](https://github.com/YaLTeR/niri) : wayland compositor (infinitely scrollable tiler)

## Legend
- ✅ Working config
- 💩 Works but it's a mess that needs rewriting
- 🚧 WIP, only partially working, probably full of broken stuff and temporary code for testing
- 🗑️ Outdated, not used anymore
- ⏳ To configure
- 📌 To try
