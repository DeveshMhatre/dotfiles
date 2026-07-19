{
  config,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    dunst = "dunst";
    i3 = "i3";
    kitty = "kitty";
    lazygit = "lazygit";
    nvim = "nvim";
    picom = "picom";
    polybar = "polybar";
    rofi = "rofi";
  };
in {
  home.username = "dev";
  home.homeDirectory = "/home/dev";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Devesh Mhatre";
        email = "deveshmhtr.mhatre92@gmail.com";
      };
    };

    signing = {
      key = "FBBE1B4C0B95A377";
      signByDefault = true;
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      "~/.ssh/config.local"
    ];
  };

  programs.bash = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
      tmux = "tmux -u new-session -s lab";
      update = "sudo nixos-rebuild switch --impure --flake ~/dotfiles#itnava";
      vim = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
      ];
      theme = "avit";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };

  programs.tmux = {
    enable = true;

    shortcut = "a";

    plugins = with pkgs; [
      tmuxPlugins.continuum

      {
        plugin = tmuxPlugins.dotbar;
        extraConfig = ''
          # tmux-dotbar config
          set -g @tmux-dotbar-position "top"
          set -g @tmux-dotbar-bold-current-window true
          set -g @tmux-dotbar-ssh-icon '󰌘'
          set -g @tmux-dotbar-ssh-icon-only false
          set -g @tmux-dotbar-ssh-enabled true
          set -g @tmux-dotbar-bg "default"
        '';
      }

      tmuxPlugins.resurrect
    ];

    extraConfig = ''
      # Use Alt-arrow keys to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Use Shift-arrow to keys to switch panes
      bind -n S-Left previous-window
      bind -n S-Right previous-window

      # Set easier window split keys
      bind-key v split-window -h
      bind-key h split-window -v

      # Easy config reload
      bind-key r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."

      # Enable True color support
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -gq allow-passthrough on

      # Default terminal settings
      # set -g default-shell /bin/zsh
      set -g focus-events on
      set -g status-style bg=default
      set -g status-left-length 99
      set -g status-right-length 99
      set -g status-justify absolute-centre
      set-option -g renumber-windows on
      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };

  xdg.configFile =
    builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/.config/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    # Core Desktop & Utilities
    kitty
    rofi # App launcher
    nitrogen # Wallpaper setter
    picom # Compositor
    dunst # Notification daemon
    polybar # Status bar
    unzip
    thunar
    nwjs

    # Neovim and dependencies
    neovim
    lazygit
    ripgrep
    tree-sitter

    # Programming languages, LSPs, formatters and libs
    alejandra # Nix code formatter
    clang-tools
    gcc
    go
    gopls
    lua-language-server
    nixd
    rubocop
    ruby-lsp
    rustup
    stylua
    vtsls

    # System & Applets
    dex # Autostart wrapper
    networkmanagerapplet # Provides nm-applet
    psmisc # Provides the 'killall' command

    # Lock Screen & Status Bar
    xss-lock # Screen locker watcher
    i3lock # Lock screen
    i3status # Fallback status bar (referenced in your volume binds)

    # Audio Control
    pulseaudio # Provides 'pactl' for volume/mute controls

    # Clipboard Management
    haskellPackages.greenclip # Provides 'greenclip' daemon and rofi integration

    # Screenshots
    maim # Screenshot tool
    xdotool # Gets active window ID for maim
    xclip # Copies images to clipboard
  ];

  fonts.fontconfig.enable = true;

  home.file.".local/share/fonts/feather.ttf".source = "${dotfiles}/fonts/Icomoon-Feather.ttf";
}
