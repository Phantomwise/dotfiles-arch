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

alias shred='shred -vz'

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

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░ PATH ░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝

export PATH="$PATH:$HOME/Scripts"

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

# ███████████████████████████████████████████████████████████████╗
# █╔════════════════════════════════════════════════════════════█║
# █║░░░░░░░░░░░░░░░░░░░░░░░░░░░ END ░░░░░░░░░░░░░░░░░░░░░░░░░░░░█║
# ███████████████████████████████████████████████████████████████║
# ╚══════════════════════════════════════════════════════════════╝
