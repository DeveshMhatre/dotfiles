while inotifywait -e close_write ~/dotfiles/.config/waybar; do killall -SIGUSR2 .waybar-wrapped; done
