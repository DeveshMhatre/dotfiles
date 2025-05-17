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
alias tmux="tmux -u new-session \; set-option -g status-right ''"
alias yrs="yarn run start"
alias start-rails="RUBYOPT='-W0' rails server"
alias test-ruby="bundle exec rspec"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/bin:$PATH"
export JAVA_HOME="/usr/lib64/jvm/java-17-openjdk-17"

# Android Studio Config
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Ruby Config
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Python virtualenvwrapper Config
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# export WORKON_HOME=$HOME/.envs
# export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
# source $HOME/.local/bin/virtualenvwrapper.sh

# PyEnv Config
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/opt/nvim"

export GREP_COLORS="mt=1;33"

# Go Config
export PATH="$HOME/go/bin:/usr/local/go/bin:$PATH"

export BROWSER="google-chrome-stable"

# SkyMD Docker Config
function restoredockerspace () {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -a -q)
  docker volume rm $(docker volume ls -q)
}

alias rc='docker exec -it skymdbackend rails console'
alias rmg='docker exec -it skymdbackend rake db:migrate'
alias dbc='docker exec -it skymdbackend rake db:create'
alias dcrs='restoredockerspace && docker-compose -f docker-compose-development.yml up --build --force-recreate -d && docker attach skymdbackend'
# Need to run these 3 every time the server is to be started
alias rs='docker-compose -f docker-compose-development.yml up -d && docker attach skymdbackend'
alias dsq='docker exec -it skymdbackend bundle exec sidekiq'
alias dslr='docker exec -it skymdbackend rake sunspot:solr:start'
# Execute these after importing a DB dump, while keeping rs and dsq running
alias dslri='docker exec -it skymdbackend rake sunspot:solr:reindex'


# Penpot Docker Config
alias start-penpot='docker compose -p penpot -f /home/dev/build/docker-compose-files/penpot/docker-compose.yaml up -d'
alias stop-penpot='docker compose -p penpot -f /home/dev/build/docker-compose-files/penpot/docker-compose.yaml down'

# Start SSH Agent if not already running
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#   ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
#   source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

. "$HOME/.cargo/env"
