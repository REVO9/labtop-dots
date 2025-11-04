{
  config,
  pkgs,
  ...
}: {
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
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  # };
}
