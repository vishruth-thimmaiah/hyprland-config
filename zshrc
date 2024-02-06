# If you come from bash you might have to change your $PATH.

export PATH=$HOME/.local/bin/:$PATH

# variable exports

export COLUMNS=$COLUMNS
export EDITOR="nvim" 
export LINES=$LINES
export terminal=$(ps -p $(ps -p $$ -o ppid=) o args=)
export BAT_THEME="Catppuccin-mocha"
export FZF_DEFAULT_COMMAND='fd --hidden'
export PAGER="bat"
export TERMINFO="/usr/share/terminfo"
export MAMBA_ROOT_PREFIX=~/environents/mamba
# Show info depending on terminal used.
if [[ $terminal =~ 'tmux.*' ]]; then
	PF_COL1=1 PF_COL3=3 pfetch
fi


echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# ZLE_RPROMPT_INDENT=0

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
setopt nocorrectall
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
	archlinux
    zsh-autosuggestions
    python
    command-not-found
    sudo
    web-search
    fancy-ctrl-z
    zsh-syntax-highlighting
	# zsh-completion-generator
)

source $ZSH/oh-my-zsh.sh

zstyle ':completion::complete:*' use-cache 1


# User configuration


# Change cursor shape for different vi modes.
bindkey -v
bindkey -v '^[;' autosuggest-accept
bindkey -v '^N' forward-word
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select


function fs() {
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias nvi="neovide"
alias conda='micromamba'
alias mariadb="mariadb -p"
alias neo="neo --charset=ascii"
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias mvim="nvim -u NONE"
alias locate="find . -name"
alias qa="exit"
alias clr="clear;pfetch"
alias cd="nocorrect z"
alias ls="eza --icons"
alias tree="eza --icons --tree"
# alias fs="yazi"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF
source /usr/share/fzf/key-bindings.zsh

# pip zsh completion start
function _pip_completion {
	local words cword
	read -Ac words
	read -cn cword
	reply=( $( COMP_WORDS="$words[*]" \
		COMP_CWORD=$(( cword-1 )) \
		PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
	}
compctl -K _pip_completion pip3
compctl -K _pip_completion pip
# pip zsh completion end

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#spicetify
export PATH=$PATH:$HOME/.spicetify

# Extra completions
fpath=( $HOME/.oh-my-zsh/completions $fpath )
compdef _gnu_generic hyprland neofetch
zstyle ':autocomplete:*' default-context history-incremental-search-backward

# zoxide
eval "$(zoxide init zsh)"

# Micromamba
eval "$(micromamba shell hook --shell zsh)"

