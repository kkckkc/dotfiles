eval "$(/opt/homebrew/bin/brew shellenv)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
#eval "$(oh-my-posh --config ~/dotfiles/oh-my-posh.toml init zsh)"
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Autocomplete
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="$PATH:$HOME/Applications/bin:/Users/magnusjohansson/.local/bin"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# NVM Init
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(osx vscode fzf fzf-z z common-aliases docker history dotenv zsh-better-npm-completion zsh-nvm)


# User configuration
ZSH_DOTENV_FILE=.dotenv


alias mux=tmuxinator
export EDITOR=/opt/homebrew/bin/emacs

alias ls='ls --color'
export LSCOLORS=Gxfxcxdxbxegedabagacad

WORDCHARS=' *?_-.[]~=&;!#$%^(){}<>/'
autoload -Uz select-word-style
select-word-style normal
zstyle ':zle:*' word-style unspecified

function th() {
  tmux split-window "$*; echo '\nPress any key...'; read"
}

function tv() {
  tmux split-window -dh "$*; echo '\nPress any key...'; read"
}

function tw() {
  tmux new-window "$*; echo '\nPress any key...'; read"
}

unalias gitroot 2>/dev/null
function gitroot() {
  cd $(git rev-parse --show-toplevel)
  if [ "$#" -ne 0 ]; then
    eval "$*"
    cd -
  fi
}

alias gr gitroot

export FZFZ_EXTRA_OPTS='--keep-right --preview-window=right:30% --tiebreak=begin,length'
export FZFZ_PREVIEW_COMMAND='exa --level 1 --tree --color=always --group-directories-first --git-ignore {}'
export TERM=xterm-256color

# Shell integrations
eval "$(fzf --zsh)"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export LC_CTYPE=en_US.UTF-8

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/mc mc

# pnpm
export PNPM_HOME="/Users/magnusjohansson/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
