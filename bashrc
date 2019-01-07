# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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


if [ -f ~/.bash-config/aliases ]; then
    . ~/.bash-config/aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# Reset
NONE='\[\033[0m\]'       # Text Reset

# Regular Colors
BLACK='\[\033[0;30m\]'        # Black
RED='\[\033[0;31m\]'          # Red
GREEN='\[\033[0;32m\]'        # Green
YELLOW='\[\033[0;33m\]'       # Yellow
BLUE='\[\033[0;34m\]'         # Blue
PURPLE='\[\033[0;35m\]'       # Purple
CYAN='\[\033[0;36m\]'         # Cyan
WHITE='\[\033[0;37m\]'        # White

export GIT_PS1_SHOWDIRTYSTATE=1


PROMPT_COMMAND=__prompt_command
__prompt_command() {
	local EXIT_CODE="$?"
	local CURRENT_FOLDER="${BLUE}$([[ ! -d .git ]] && echo "\w" || echo "\W")${NONE}"
	local GIT="$(__git_ps1 "[${YELLOW}%s${NONE}] ")"
	
    local VENV=${VIRTUAL_ENV##*/}
    PS1=""

    if [ "$VENV" != "" ]; then
    	PS1+="($GREEN$VENV$NONE) "
    fi

	PS1+="${CURRENT_FOLDER} ${GIT}"

	if [ $EXIT_CODE == 0 ]; then
		PS1+="✔ "
	else
		PS1+="✖ "
	fi
}


source ~/.git-prompt.sh
