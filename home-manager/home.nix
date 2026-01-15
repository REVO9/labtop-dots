{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  pinnedPkgs = import inputs.rnote-pinned {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
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
    pinnedPkgs.rnote
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
    songrec
    rsync
    obs-studio
    typst
    qutebrowser
    eduvpn-client

    # terminal fluff
    cava
    unimatrix
    cbonsai
    lolcat
    figlet
    tplay
  ];

  home.file = {
    ".zshrc".source = ./config/zshrc;
    ".p10k.zsh".source = ./config/p10k.zsh;
    ".scripts" = {
      source = ./home/scripts;
      recursive = true;
    };
    "Pictures/Wallpapers" = {
      source = ./home/wallpapers;
      recursive = true;
    };
    "Videos/yippie.gif".source = ./home/yippie.gif;
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
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/webp" = "org.gnome.eog.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "image/gif" = "org.gnome.eog.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
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
