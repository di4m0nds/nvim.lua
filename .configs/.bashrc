# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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

if [ "$color_prompt" = yes ]; then
  # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  # Define colors
  RESET_COLOR="\[\e[0m\]"
  GREEN="\[\e[38;5;48m\]"
  CYAN="\[\e[38;5;39m\]"
  PURPLE="\[\e[38;5;171m\]"
  RED="\[\e[38;5;196m\]"
  BOLD_GREEN="\[\e[1;32m\]"
  BOLD_CYAN="\[\e[1;36m\]"
  BOLD_PURPLE="\[\e[1;35m\]"
  BOLD_RED="\[\e[1;31m\]"
  
  # Set the new prompt with Git status and branch
  # PS1="${RESET_COLOR}╭${RESET_COLOR}─${GREEN}${BOLD_GREEN}\u${RESET_COLOR} at ${CYAN}${BOLD_CYAN}\h${RESET_COLOR} in ${BOLD_PURPLE}\w${BOLD_GREEN}\$(parse_git_status)\[${BOLD_RED}\$(parse_git_branch)\]\n${RESET_COLOR}╰${RESET_COLOR}─➤ "
  PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]${BOLD_GREEN}\$(parse_git_status)\[${BOLD_RED}\$(parse_git_branch)\]\n${RESET_COLOR}\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
custom_alert() {
    local custom_message="$1"
    notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$custom_message"
    paplay $HOME/Music/mixkit_alert.wav
}
alias alert='custom_alert'

# alias t10a='timer 10s && alert "Finished Timer"'

alias timer-break='timer 15m && alert "Lets back to work!"'
alias timer-work='timer 45m && alert "Take a break!"'

alias showdate='. $HOME/bash_programs/datetime.sh'

alias oterm='gnome-terminal --working-directory="$PWD" --geometry=120x40+10+10'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

# pnpm
export PNPM_HOME="/home/di4m0nds/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Nvim Aliases
alias nvim='~/.local/bin/nvim'
alias v='~/.local/bin/nvim'

alias x='exit'
alias ..='cd ..'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias glg='git log --all --oneline -10 --decorate --graph'

# Ubuntu Terminal Prompt - Show Git Status
parse_git_branch() {
    local echoString=""
    #local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    if [[ -n "$branch" ]]; then
      echoString+="branch:$branch"
    fi

    echo "$echoString"
}
parse_git_status() {
    local status="$(git status --porcelain 2>/dev/null)"
    local commits_unpushed="$(git log --branches --not --remotes --oneline 2>/dev/null | wc -l)"

    local echoString=""

    if [[ -n "$status" ]]; then
        # echoString+=" ⚡"
        echoString+=" +changes"
    else
        echoString+=" "
    fi

    if [[ "$commits_unpushed" -gt 0 ]]; then
        # echoString+=" 🔥+$commits_unpushed "
        echoString+=" unpushed+$commits_unpushed "
    else
        echoString+=" "
    fi

    echo "$echoString"
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# Java
export JAVA_HOME=/opt/jdk-21.0.1
export PATH=$PATH:$JAVA_HOME/bin
