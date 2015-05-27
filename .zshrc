source ~/.antigen.zsh
# Load various lib files


antigen use oh-my-zsh

#
# Antigen Bundles
#

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen bundle tmuxinator
antigen bundle tmux
antigen bundle rupa/z

# For SSH, starting ssh-agent is annoying
antigen bundle ssh-agent


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# User configuration
autoload -U compinit
compinit

if [[ -x "`whence -p dircolors`" ]]; then
  eval `dircolors`
  alias ls='ls -F --color=auto'
else
  alias ls='ls -F'
fi


alias ll='ls -l'
alias la='ls -a'

HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory

REPORTTIME=10



export PATH="/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin/:/home/dirvine/Devel/go/bin:/usr/local/nim/bin:/home/dirvine/node/bin/:/home/dirvine/sage:/usr/bin"
# export MANPATH="/usr/local/man:$MANPATH"
alias -s rs=vim 
alias -s html=google-chrome
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function apt-list-packages {
  dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | grep -v deinstall | sort -n | awk '{print $1" "$2}'
}


setxkbmap -option ctrl:nocaps
# Antigen Theme
#
antigen theme muse 
