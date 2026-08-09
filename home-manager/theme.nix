{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.pointerCursor = {
    gtk.enable = true;

    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    size = 16;
  };

  gtk = {
    enable = true;
    colorScheme = "light";
    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
    };
    gtk3.theme = {
      name = "rose-pine";
      package = inputs.rose-pine-gtk-theme.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    gtk4.theme = {
      name = "rose-pine";
      package = inputs.rose-pine-gtk-theme.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
