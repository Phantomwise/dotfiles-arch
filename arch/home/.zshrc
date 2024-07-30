# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# █║░░░░░░░░░░███████╗███████╗██╗░░██╗██████╗░░██████╗░░░░░░░░░░█║
# █║░░░░░░░░░░╚══███╔╝██╔════╝██║░░██║██╔══██╗██╔════╝░░░░░░░░░░█║
# █║░░░░░░░░░░░░███╔╝░███████╗███████║██████╔╝██║░░░░░░░░░░░░░░░█║
# █║░░░░░░░░░░░███╔╝░░╚════██║██╔══██║██╔══██╗██║░░░░░░░░░░░░░░░█║
# █║░░░░░░░░░░███████╗███████║██║░░██║██║░░██║╚██████╗░░░░░░░░░░█║
# █║░░░░░░░░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░░░░░░░░░░█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# █║░░░░░░░░░░░░░░░░░░░░░░ by Phantomwise ░░░░░░░░░░░░░░░░░░░░░░█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░ ~/.zshrc ░░░░░░░░░░░░░░░░░░░░░░░░░█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

# Lines configured by zsh-newuser-install
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/phantomwise/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░ PROMPT ░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

PROMPT="%K{18}%F{black}%f%k%B%K{18}%F{white}%n%f%k%b%K{black}%F{18}%f%k%K{21}%F{black}%f%k%B%K{21}%F{white}@%m%f%k%b%K{black}%F{21}%f%k%K{26}%F{black}%f%k%B%K{26}%F{white}%d%f%k%b%K{black}%F{26}%f%k %B%#%b "
RPROMPT="%K{black}%F{26}%f%k%B%K{26}%F{white}%*%f%k%b%K{26}%F{black}%f%k%K{black}%F{21}%f%k%B%K{21}%F{white}%y%f%k%b%K{21}%F{black}%f%k%K{black}%F{18}%f%k%B%K{18}%F{white}zsh%f%k%b%K{18}%F{black}%f%k"

    # Transient prompt from https://www.zsh.org/mla/users/2019/msg00633.html
    zle-line-init() {
        emulate -L zsh

        [[ $CONTEXT == start ]] || return 0

        while true; do
            zle .recursive-edit
            local -i ret=$?
            [[ $ret == 0 && $KEYS == $'\4' ]] || break
            [[ -o ignore_eof ]] || exit 0
        done

        local saved_prompt=$PROMPT
        local saved_rprompt=$RPROMPT
        PROMPT="%K{18}%F{black}%f%k%B%K{18}%F{white}%n%f%k%b%K{black}%F{18}%f%k%K{26}%F{black}%f%k%B%K{26}%F{white}%~%f%k%b%K{black}%F{26}%f%k %B%#%b "
        RPROMPT="%K{black}%F{18}%f%k%B%K{18}%F{white}%*%f%k%b%K{18}%F{black}%f%k"
        zle .reset-prompt
        PROMPT=$saved_prompt
        RPROMPT=$saved_rprompt

        if (( ret )); then
            zle .send-break
        else
            zle .accept-line
        fi
        return ret
    }

    zle -N zle-line-init

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░ AUTOSTART ░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

# Check if running in a terminal emulator
# NB: Change the check to look at $XDG_SESSION_TYPE = tty instead ?)
if [[ -n "$TERM_PROGRAM" || -n "$COLORTERM" ]]; then
    fastfetch
else
    echo -e "\n"
    echo -e "Logged into \e[1;34m$(tty)\e[0m as \e[1;34m$(whoami)\e[0m."
    echo -e "Current date and time: \e[1;34m$(date)\e[0m"
    # Check for running graphical session
    # if [[ -n "$DISPLAY" ]] || pgrep -x "Xorg" > /dev/null; then
    if [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
        echo "An Xorg session is already running."
    # elif [[ -n "$WAYLAND_DISPLAY" ]] || pgrep -f "wayland" > /dev/null; then
    elif [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
        echo "A Wayland session is already running."
    # Additional checks and information
        # Check for Wayland compositor
        wayland_compositor=$(pgrep -afi "(hyprland|sway|weston|wayfire|waymonad|river|niri|xwayland)" | head -n 1 | awk '{print $2}')
        echo -e "Wayland compositor: \e[1;34m$wayland_compositor\e[0m"
    else
        echo "No graphical session detected."
    fi
    echo -e "\n"
fi

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░ ALIASES ░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

alias shred="shred -vz"
alias nmtui="NEWT_COLORS='root=black,black;window=black,black;border=white,black;listbox=white,black;label=blue,black;checkbox=red,black;title=green,black;button=white,red;actsellistbox=white,red;actlistbox=white,gray;compactbutton=white,gray;actcheckbox=white,blue;entry=lightgray,black;textbox=blue,black' nmtui"

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░ COLOR SUPPORT ░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░ KEY BINDINGS ░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

# Making the following keys work : Home, End, Delete
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░ HISTORY ░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000

# Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.
setopt EXTENDED_HISTORY
# This option both imports new commands from the history file, and also causes your typed commands to be appended to the history file (the latter is like specifying INC_APPEND_HISTORY, which should be turned off if this option is in effect). The history lines are also output with timestamps ala EXTENDED_HISTORY (which makes it easier to find the spot where we left off reading the file after it gets re-written). 
setopt SHARE_HISTORY
# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
# If a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event). 
# HIST_IGNORE_ALL_DUPS
# When writing out the history file, older commands that duplicate newer ones are omitted. 
# HIST_SAVE_NO_DUPS
# If the internal history needs to be trimmed to add the current command line, setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event from the list. You should be sure to set the value of HISTSIZE to a larger number than SAVEHIST in order to give you some room for the duplicated events, otherwise this option will behave just like HIST_IGNORE_ALL_DUPS once the history fills up with unique events. 
setopt HIST_EXPIRE_DUPS_FIRST

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░ PATH ░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

# Separate config to add directories to $PATH in both bashrc and zshrc if they are not already there. Avoids duplicate entries in $PATH.
# Sourced by both bashrc and zshrc
if [ -f "$HOME/.config/shell/path-config" ]; then
    source "$HOME/.config/shell/path-config"
fi

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░ ENV ░░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

# Set ksshaskpass for askpass because the regular sshaskpass package is X11 only >_<
export SSH_ASKPASS=/usr/bin/ksshaskpass

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░ MISC ░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

# Activate zsh-syntax-highlinghting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Activate zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Source emoji-cli plugin
source /usr/share/zsh/plugins/emoji-cli/emoji-cli.zsh

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░ END ░░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝
