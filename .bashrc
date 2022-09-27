stty -ixon
shopt -s autocd
HISTSIZE= HISTFILESIZE=

# Set Bash prompt. Capitalize username and host if root user
if [ "$EUID" -ne 0 ]
	then export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
	else export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
fi

export GPG_TTY=$(tty)

alias x="exit"
alias push="rsync -avzP "
alias ka="killall"
alias rf="source ~/.bashrc"
alias bb="byobu"
alias starwars="telnet towel.blinkenlights.nl"

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias crep="grep --color=always"             # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=xterm256" # Color cat - print file with syntax highlighting.
