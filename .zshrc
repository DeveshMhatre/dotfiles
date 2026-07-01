export ZSH="/home/dev/.oh-my-zsh"

ZSH_THEME="avit"

plugins=(
	git
	sudo
	zsh-autosuggestions
	z
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias tmux="tmux -u new-session -s lab"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GREP_COLORS="mt=1;33"

# Start SSH Agent if not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

. "$HOME/.cargo/env"
