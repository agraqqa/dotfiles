# WARN: zsh session is being logged to $AUDIT_TO folder
# Do not use zsh for reasons other than _workspace_ routine!
# AUDIT_TO=~/workspace/logs/zsh/
# if [ -z "$SCRIPT_SESSION" ]; then
#     export SCRIPT_SESSION=1
#     log_file=$AUDIT_TO/$(date '+%Y-%m-%d-%H-%M-%S').log
#     mkdir -p $(dirname $log_file)
#     exec script -a $log_file $(which zsh)
# fi

# Load .env file
if [ -f ~/dotfiles/.env ]; then
  export $(grep -v '^#' ~/dotfiles/.env | xargs)
fi

WORKSPACE="workspace"

ZSH_THEME="macbook" # set by `omz`
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# oh-my-zsh
plugins=(ansible brew colored-man-pages docker docker-compose git history macos python sudo zsh-autosuggestions z zsh-syntax-highlighting)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LC_ALL=en_US.UTF-8

# Get rid of .zcompdump files in root folder
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Set hashicorp vault credentials
export VAULT_USERNAME=$VAULT_USERNAME
export VAULT_PASSWORD=$VAULT_PASSWORD

# Git project dir for gclone
export GIT_PROJECT_DIR=$GIT_PROJECT_DIR

# Git settings
export GIT_PAGER=cat

# Enable vi mode
bindkey -v
bindkey -M vicmd v edit-command-line

# Aliases
alias p9="ping 9.9.9.9"
alias dscu="dscacheutil -q host -a name"
alias cpr="cp -r"
alias kf="killall Finder"
alias la="eza -la"
alias zshrc="nvim ~/.zshrc"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com."
alias g="git"
alias rsy="rsync -atrv --info=progress2"
alias x="exit"
alias weather="curl wttr.in"
alias tffmtplan="terraform fmt && terraform plan"
alias k=" kubectl"

# Initialize pyenv
eval "$(pyenv init --path)"

# Add GOPATH/bin to PATH
export PATH=$PATH:$(go env GOPATH)/bin

# Load bash completions
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/Cellar/tfenv/3.0.0/versions/1.4.6/terraform terraform

# atuin configuration
export ATUIN_CONFIG_DIR=$HOME/.config/atuin-zsh
eval "$(atuin init zsh)"
