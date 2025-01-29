#
# .zshrc
#
# @author Jake Turner
#

ZSH_THEME="oxide"

# Colors.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# # Nicer prompt.
# export PS1=$'\n'"%F{green} %*%F %3~ %F{white}"$'\n'"$ "

# Nicer prompt.
export PS1=$'\n'"%F{green} %n@%m %* %F{8} %~ %F{white} $ "

# Enable plugins.
plugins=(git brew history kubectl history-substring-search)

# Bash-style time output.
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.aliases ]
then
  source ~/.aliases
fi

# Git aliases.
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Completions.
autoload -Uz compinit && compinit

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
    share_path="/opt/homebrew/share"
else
    echo "Unknown architecture: ${arch_name}"
fi

# Allow history search via up/down keys.
source ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Set zsh to save history
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export HISTTIMEFORMAT="[%F %T] "
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# random aliases
alias mtr='sudo mtr'

# kubectl aliases
alias k='kubectl'
alias kgc='kubectl get configmaps | sort'
alias kgd='kubectl get deployments | sort'
alias kgi='kubectl get ingress | sort'
alias kgn='kubectl get nodes | sort'
alias kgh='kubectl get hpa -A'
alias kgp='kubectl get pod | sort'
alias kgpa='kubectl get pod --all-namespaces | sort'
alias kgpaw='kubectl get pod --all-namespaces -o wide'
alias kgpi='kubectl get pod -o=custom-columns=NAME:metadata.name,IMAGE:spec.containers[0].image,CREATED:metadata.creationTimestamp | sort'
alias kgpia='kubectl get pod --all-namespaces -o=custom-columns=NAME:metadata.name,IMAGE:spec.containers[0].image,CREATED:metadata.creationTimestamp | sort'
alias kgpw='kubectl get pod -o wide | sort'
alias kgr='kubectl get replicasets | sort'
alias kgs='kubectl get services -A | sort'
alias kgss='kubectl get secrets | sort'
alias kbad='kgpa > /tmp/badpods; egrep -v "NAME|Running|Completed" /tmp/badpods > /tmp/badpods1; egrep "0/" /tmp/badpods | grep -v "Completed" >> /tmp/badpods1; sort -u /tmp/badpods1; echo "`sort -u /tmp/badpods1|wc -l` bad pods"'
alias kw="kubectl config current-context"
alias kge="kubectl get events --sort-by='.metadata.creationTimestamp' -A"

export GPG_TTY=$(tty)
