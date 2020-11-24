
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/Library/Python/2.7/bin:~/.npm-global/bin:$PATH
export EDITOR="vim"
export TERM="xterm-256color"
export KUBECONFIG=<replace me with a comma separated list of kubeconfigs>

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions zsh-syntax-highlighting docker git ssh-agent kubectl fzf aws)

source $ZSH/oh-my-zsh.sh

source $ZSH_CUSTOM/plugins/fzf-tab-completion/zsh/fzf-zsh-completion.sh
source ~/_istioctl
# only aws command completion
#zstyle ':completion:*:*:aws' fzf-search-display true
# or for everything
zstyle ':completion:*' fzf-search-display true

#AUTOSUGGESTION_HIGHLIGHT_COLOR="fg=8"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

## alias niceties
alias utc='TZ=UTC date +%FT%TZ'
alias history='fc -fl 1'
alias ll='ls -lah'
alias lt='ls -altrh'
alias mcd='mkdir -p $i; cd $i'
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
# Docker niceties
alias dl='docker ps -l -q'
# Reduce kubectl
alias k='kubectl'
alias kx='kubectx'
# vi/vim muscle memory
alias vim='nvim'
alias vi='nvim'
alias k='kubectl'
alias ks='kubectl -n kube-system'
alias kn='kubectl -n '
alias kg='kubectl get'
alias kd='kubectl describe'
alias tf='terraform'
#alias tf-12='/usr/local/Cellar/terraform@0.12/0.12.29/bin/terraform'
alias ssmh='aws ssm start-session --region us-west-2 --target'

function lssh {
  PROSSH_FILE=$(ls -t ~/Downloads | head -n1)
  if echo $PROSSH_FILE | grep "(" >/dev/null 2>&1
    then
      DIR=`echo $PROSSH_FILE | cut -d\( -f1 | cut -d' ' -f1`
    else
      DIR=`echo $PROSSH_FILE | cut -d. -f1`
  fi
  PROSSH_USER=$2
  PROSSH_IP=$1
  if [ -z "${PROSSH_USER}" ]; then
    PROSSH_USER='ubuntu'
  fi
  if [ -z "${PROSSH_IP}" ]; then
    PROSSH_IP=$(pbpaste)
  fi
  unzip -p ~/Downloads/"${PROSSH_FILE}" "${DIR}"/id_rsa > ~/.ssh/prossh
  chmod 600 ~/.ssh/prossh
  echo ${PROSSH_FILE} extracted, now sshing into ${PROSSH_IP}!
  ssh -A -i ~/.ssh/prossh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null ${PROSSH_USER}@${PROSSH_IP}
}
