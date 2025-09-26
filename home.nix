{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "revo";
  home.homeDirectory = "/home/revo";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    pavucontrol
    gitui
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';


    ".zshrc".source = ./home/.zshrc;
    ".p10k.zsh".source = ./home/.p10k.zsh;
    ".scripts" = {
      source = ./home/scripts;
      recursive = true;
    };
  };

  xdg.configFile = {
    "hypr" = {
      source = ./config/hypr;
      recursive = true;
    };
    "waybar" = {
      source = ./config/waybar;
      recursive = true;
    };
    "gitui" = {
      source = ./config/gitui;
      recursive = true;
    };
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.scripts/"
  ];

  programs = {
    kitty = {
      enable = true;
      settings = {
        font_family = "JetBrains Mono Nerd Font";
        font_size = 11;
        background_opacity = 0.75;
        confirm_os_window_close = 0;

        resize_debounce_time = 0.0;

        cursor_trail = 1;
        cursor_trail_start_threshold = 0;

        foreground = "#9da5c1";
        background = "#0a081b";
        cursor = "#9da5c1";

        color0 = " #0a081b";
        color8 = " #6d7387";
        color1 = " #204578";
        color9 = " #244578";
        color2 = " #5F4869";
        color10 = " #5F4869";
        color3 = " #AE3F45";
        color11 = " #AE3F45";
        color4 = " #A15358";
        color12 = " #A15358";
        color5 = " #E8B161";
        color13 = " #E8B161";
        color6 = " #1C5296";
        color14 = " #1C5296";
        color7 = " #9da5c1";
        color15 = " #9da5c1";
      };
    };
    waybar.enable = true;
    git = {
      enable = true;
      userName = "REVO9";
      userEmail = "luisdanker@gmx.de";
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    font.name = "JetBrains Mono";
    font.size = 11;
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
