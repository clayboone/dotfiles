# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH

# Theme (use "random" for random)
# Note: Set theme *before* sourcing oh-my-zsh
#ZSH_THEME="agnoster"
#ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

# Source oh-my-zsh first since I want to overwrite some of the aliases.
export ZSH="/home/clay/.oh-my-zsh"

# Options
ENABLE_CORRECTION="true"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode)
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status root_indicator background_jobs)
export POWERLEVEL9K_VI_INSERT_MODE_STRING='<<<'
export POWERLEVEL9K_VI_COMMAND_MODE_STRING='   '

# Set env's
export EDITOR="vim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Source autojump for easy navigation (debian)
if [ -f /usr/share/autojump/autojump.zsh ]; then
	source /usr/share/autojump/autojump.zsh
fi

# Vi-keys in autocomplete
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Don't insert tabs when no chars left of the cursor
zstyle ':completion:*' insert-tab false

# git status all
#gsa() {
#	originalDir=${PWD}
#	for project in `ls ${HOME}/Projects`; do
#		cd "${HOME}/Projects/${project}"
#		echo "${project}:"
#		git status --short
#	done
#	cd ${originalDir}
#}

# Colorful for man pages
function man {
	env \
	LESS_TERMCAP_mb=$(printf "\x1b[38;2;255;200;200m") \
    	LESS_TERMCAP_md=$(printf "\x1b[38;2;255;100;200m") \
    	LESS_TERMCAP_me=$(printf "\x1b[0m") \
    	LESS_TERMCAP_so=$(printf "\x1b[38;2;60;90;90;48;2;40;40;40m") \
    	LESS_TERMCAP_se=$(printf "\x1b[0m") \
    	LESS_TERMCAP_us=$(printf "\x1b[38;2;150;100;200m") \
    	LESS_TERMCAP_ue=$(printf "\x1b[0m") \
    	man "$@"
}

# Attempt to reuse tmux sessions (unless explicitly told to create new)
tmux_cmd=$(which tmux)
tmux() {
	if [ -z $tmux_cmd ]; then
		echo "tmux not installed" 1>&2
		return 1
	fi

	if [ $# -gt 0 ]; then
		$tmux_cmd "$@"
	else
		session=$($tmux_cmd ls 2>/dev/null | head -n 1 | cut -d: -f1)
		if [ -z $session ]; then
			$tmux_cmd new-session
		else
			$tmux_cmd attach-session -t $session
		fi
	fi
}

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set aliases after sourcing oh-my-zsh
alias config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/"
alias grep="rg"

unalias la
unalias ll
unalias l
unalias lsa
alias ls="exa -h"
alias la="ls -l"

unalias g
alias g='git log --stat --graph'

# disable flow control (for vim's <C-s>)
stty -ixon

# set colors from wal
(cat ~/.cache/wal/sequences &)

# print any config status changes
config status -s
