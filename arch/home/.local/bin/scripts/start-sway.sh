#!/usr/bin/env bash

# Not made by AI \o/

# Force apps to use Wayland backend by default
    # Chromium applications
export OZONE_PLATFORM=wayland
    # Qt applications
export QT_QPA_PLATFORM=wayland-egl
    # Electron applications
export ELECTRON_ENABLE_WAYLAND=1
    # EFL applications
    # ELM applications
export ELM_ENGINE=wayland_wgl
export ECORE_EVAS_ENGINE=wayland_egl
    # GTK applications
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
    # Java applications
export _JAVA_AWT_WM_NONREPARENTING=1
    # Mozilla applications
export MOZ_ENABLE_WAYLAND=1
    # SDL applications
export SDL_VIDEODRIVER=wayland

# No clue what that is, found it somewhere on reddit, I'll have to check what it does and if I need it
    # export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    # export QT_QPA_PLATFORMTHEME=qt5ct
    # export QT_STYLE_OVERRIDE=kvantum

# Set XDG_CURRENT_DESKTOP when using Sway
export XDG_CURRENT_DESKTOP=sway

# Set qt theme
export QT_QPA_PLATFORMTHEME=qt6ct

# Force Sway to use Intel GPU
export WLR_DRM_DEVICES=/dev/dri/card1

# Offload rendering to Nvidia GPU
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only

# redirect stdout/stderr to a log file
exec sway > ~/.cache/sway.log 2>&1
