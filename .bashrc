export PROMPT_COMMAND=__prompt_command
function __prompt_command() {
    local EXIT="$?"             # This needs to be first

    #local RCol='\[\e[0m\]'
    local RCol='\[\033[00m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\033[36m\]'
    local Pur='\[\e[0;35m\]'

    local status=""
    if [ $EXIT != 0 ]; then
        status="${Red}\u${RCol}"      # Add red if exit code non 0
    else
        status="${Gre}\u${RCol}"
    fi

    if [[ -n "$SYS_VERSION" ]]
    then
        PS1="${Pur}\w\n$status${RCol}@${BBlu}\h${RCol}:$SYS_VERSION> "
    else
        PS1="${Pur}\w\n$status${RCol}@${BBlu}\h${RCol}> "
    fi
}

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

export HISTSIZE=5000
HISTFILESIZE=10000

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF -1'
alias psu='ps -u eiva'
alias r='vim -R -p'
alias v='vim -p'
alias vi='vim -p'

ulimit -c unlimited
umask 022 # all to me, read to group and others
