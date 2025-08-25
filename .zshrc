export ZSH="/home/devesh/.oh-my-zsh"

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
alias tmux="tmux -u new-session \; set-option -g status-right ''"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/bin:$PATH"
export JAVA_HOME="/usr/lib64/jvm/java-17-openjdk-17"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GREP_COLORS="mt=1;33"

export BROWSER="google-chrome-stable"

# Start SSH Agent if not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# . "$HOME/.cargo/env"
eval "$(/home/devesh/.local/bin/mise activate zsh)"
