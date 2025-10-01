{
  config,
  pkgs,
  ...
}: {
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
    "vesktop/themes/rose-pine.css".source =
      pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "discord";
        rev = "main";
        sha256 = "00sz681dd3jm1vjga6wcj2jv0ninm8bms9jkz5fax1p6nm6bvlrr";
      }
      + "/dist/rose-pine.css";
    "mako/config".source = ./config/mako/config;
    "wofi" = {
      source = ./config/wofi;
      recursive = true;
    };
    "swaync" = {
      source = ./config/swaync;
      recursive = true;
    };
  };

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
        color0 = "#1a152e";
        color1 = "#3a629d";
        color2 = "#7a5e7f";
        color3 = "#c35a60";
        color4 = "#b46b70";
        color5 = "#f0c47a";
        color6 = "#2a68b3";
        color7 = "#b0b7d4";
        color8 = "#6d7387";
        color9 = "#244578";
        color10 = "#5F4869";
        color11 = "#AE3F45";
        color12 = "#A15358";
        color13 = "#E8B161";
        color14 = "#1C5296";
        color15 = "#9da5c1";
      };
    };

    waybar = {
      enable = true;
      settings = {};
    };

    git = {
      enable = true;
      userName = "REVO9";
      userEmail = "luisdanker@gmx.de";
    };

    vesktop = {
      enable = true;
      settings.enabledThemes = "[ rose-pine.css ]";
    };
  };
}
