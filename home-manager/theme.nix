{
  config,
  pkgs,
  ...
}: {
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
      package = pkgs.rose-pine-gtk-theme;
    };
    gtk4.theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
