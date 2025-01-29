# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi


if [ $SHELL = '/bin/zsh' ]; then
    autoload -U colors && colors
    # Reset
    NONE='%{$reset_color%}'      # Text Reset
    # Regular Colors
    BLACK='%{$fg[black]%}'       # Black
    RED='%{$fg[red]%}'           # Red
    GREEN='%{$fg[green]%}'       # Green
    YELLOW='%{$fg[yellow]%}'     # Yellow
    BLUE='%{$fg[blue]%}'         # Blue
    # PURPLE=''                  # Purple
    CYAN='%{$fg[cyan]%}'         # Cyan
    WHITE='%{$fg[white]%}'       # White

    WORK_DIR='%~'
    WORK_DIR_SHORT='%~'

    setopt PROMPT_SUBST
else
    # Reset
    NONE='\[\033[0m\]'            # Text Reset
    # Regular Colors
    BLACK='\[\033[0;30m\]'        # Black
    RED='\[\033[0;31m\]'          # Red
    GREEN='\[\033[0;32m\]'        # Green
    YELLOW='\[\033[0;33m\]'       # Yellow
    BLUE='\[\033[0;34m\]'         # Blue
    PURPLE='\[\033[0;35m\]'       # Purple
    CYAN='\[\033[0;36m\]'         # Cyan
    WHITE='\[\033[0;37m\]'        # White

    WORK_DIR='\W'
    WORK_DIR_SHORT='\w'
fi

export GIT_PS1_SHOWDIRTYSTATE=1


source ~/.git-prompt.sh


PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local EXIT_CODE="$?"
    local CURRENT_FOLDER="${BLUE}$([[ ! -d .git ]] && echo "${WORK_DIR_SHORT}" || echo "${WORK_DIR}")${NONE}"
    local GIT="$(__git_ps1 "%s")"
	
    local VENV=${VIRTUAL_ENV##*/}

    PS1=""
    
    if [ -f ~/.bash-config/machine_name ]; then
        PS1+="[`cat ~/.bash-config/machine_name`] "
    fi

    if [ "$VENV" != "" ]; then
        PS1+="(${GREEN}${VENV}${NONE}) "
    fi

    PS1+="${CURRENT_FOLDER} "


    if [ "$GIT" != "" ]; then
        PS1+="[${YELLOW}${GIT}${NONE}] "
    fi

    if [ $EXIT_CODE = 0 ]; then
        PS1+="✔ "
    else
        PS1+="${RED}✖${NONE} "
    fi
}
precmd() { eval "$PROMPT_COMMAND" }



if [ -f ~/.bash-config/aliases ]; then
    . ~/.bash-config/aliases
fi

