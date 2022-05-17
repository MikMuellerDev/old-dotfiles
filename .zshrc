export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="zish"
plugins=(git zsh-autosuggestions history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

DISABLE_MAGIC_FUNCTIONS="true"

plugins=(
    git
    zsh-autosuggestions
    history-substring-search
    zsh-syntax-highlighting
    sudo
    cp
)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC='42'
ZSH_HIGHLIGHT_STYLES[arg0]=fg=4
ZSH_HIGHLIGHT_STYLES[command]=fg=4
ZSH_HIGHLIGHT_STYLES[alias]=fg=4
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=4
ZSH_HIGHLIGHT_STYLES[precommand]=fg=4,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=6,bold
ZSH_HIGHLIGHT_STYLES[default]=fg=12
ZSH_HIGHLIGHT_STYLES[path]=fg=12
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=5
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=208,bold
ZSH_HIGHLIGHT_STYLES[assign]=fg=14

source ~/.config/.aliasrc.zsh
source /home/mik/.config/.aliasrc.zsh

export ANDROID_SDK=/home/mik/Android/Sdk

export PATH=$PATH:/usr/local/go/bin
export GOBIN=/home/mik/go/bin
export GOPATH=/home/mik/go
export PATH=$PATH:$GOBIN

# Self-hosted goproxy
export GOPROXY=http://proxy.gp,direct

# Ruby-Gems path
export PATH=$PATH:/usr/lib/ruby/gems/3.0.0

# [[ $- != *i* ]] && return
# echo
# pixfetch
