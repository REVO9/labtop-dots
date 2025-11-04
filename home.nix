{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./theme.nix
    ./config.nix
    ./fastfetch.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "revo";
  home.homeDirectory = "/home/revo";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    (writeShellScriptBin "pavucontrol" ''
      GTK_THEME=Adwaita:dark ${pkgs.pavucontrol}/bin/pavucontrol "$@"
    '')
    gitui
    nordzy-cursor-theme
    xfce.thunar
    xfce.tumbler
    hyprpicker
    blueman
    grim
    slurp
    imagemagick
    mpv
    rnote
    wvkbd
    thunderbird
    libreoffice
    wasistlos
    evince
    zathura
    tectonic
    texlab
    inkscape
    gnome-network-displays

    # terminal fluff
    cava
    unimatrix
    cbonsai
    lolcat
    figlet
  ];

  home.file = {
    ".zshrc".source = ./home/.zshrc;
    ".p10k.zsh".source = ./home/.p10k.zsh;
    ".scripts" = {
      source = ./home/scripts;
      recursive = true;
    };
    "Pictures/Wallpapers" = {
      source = ./home/wallpapers;
      recursive = true;
    };
  };

  xdg.dataFile."fonts/Rodondo.otf".source = ./fonts/Rodondo.otf;

  home.sessionVariables = {};

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.scripts/"
  ];

  services = {
    udiskie = {
      enable = true;
      settings.program_options.tray = true;
    };
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
    swaync = {
      enable = true;
    };
  };

  xdg.desktopEntries.pavucontrol = {
    name = "Volume Control";
    exec = "${pkgs.writeShellScriptBin "pavucontrol" ''
      GTK_THEME=Adwaita:dark ${pkgs.pavucontrol}/bin/pavucontrol "$@"
    ''}/bin/pavucontrol %U";
    icon = "multimedia-volume-control";
    categories = ["AudioVideo" "Audio" "Mixer"];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
    };
  };

  xdg.desktopEntries = {
    steam-bigpicture = {
      name = "Steam Big Picture Mode";
      comment = "Start Steam in Big Picture Mode";
      exec = "${pkgs.gamescope}/bin/gamescope -e -W 1920 -H 1200 -- ${pkgs.steam}/bin/steam -tenfoot";
      type = "Application";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = with pkgs; [
      inputs.hyprgrass.packages.${pkgs.system}.default
      # hyprlandPlugins.hyprgrass
    ];

    settings = {
      source = [
        "~/.config/hypr/main.conf"
      ];
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
