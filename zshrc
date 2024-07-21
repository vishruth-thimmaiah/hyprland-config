export terminal=$(ps -p $(ps -p $$ -o ppid=) o args=)

if [[ $terminal =~ 'tmux.*' ]]; then
	PF_COL1=1 PF_COL3=3 pfetch
fi

# Customise Cursor
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Plugins
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/sudo/sudo.zsh
source ~/.zsh/fancy-ctrl-z/fancy-ctrl-z.zsh
source ~/.zsh/command-not-found/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completions
_ls_colors="di=1;34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"


zstyle ':completion:*:default' list-colors "${(s.:.)_ls_colors}"
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

autoload -U compinit; compinit

# Zsh History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=''

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M viins "^[[A" up-line-or-beginning-search
bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M viins "^[[B" down-line-or-beginning-search
bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search


# Correction
ENABLE_CORRECTION="true"
setopt nocorrectall
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "


# Keybinds
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


# Custom Functions
function fs() {
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | wl-copy
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Environment Variables
export COLUMNS=$COLUMNS
export EDITOR="nvim" 
export LINES=$LINES
export BAT_THEME="Catppuccin-mocha"
export FZF_DEFAULT_COMMAND='fd --hidden'
export PAGER="bat"
export DELTA_PAGER="less"
export TERMINFO="/usr/share/terminfo"
export MAMBA_ROOT_PREFIX=~/environents/mamba


# Aliases
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
alias lsa="eza -lah --icons --total-size"
alias tree="eza --icons --tree"
alias ..="cd .."

# Path
export PATH="$HOME/go/bin:$PATH"


# zoxide
eval "$(zoxide init zsh)"


# FZF
source /usr/share/fzf/key-bindings.zsh


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

eval "$(micromamba shell hook --shell zsh)"
