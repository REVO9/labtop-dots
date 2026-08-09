{
  description = "Rosé Pine GTK theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    rose-pine-gtk = {
      url = "github:rose-pine/gtk?tag=v2.2.0";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      rose-pine-gtk,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "rose-pine-gtk-theme";
            version = "2.2.0";

            src = rose-pine-gtk;

            # don't need that
            # buildInputs = [
            #   pkgs.gnome-themes-extra # adwaita engine for Gtk2
            #   pkgs.gtk_engines       # pixmap engine for Gtk2
            # ];
            #
            # propagatedUserEnvPkgs = [
            #   pkgs.gtk-engine-murrine # murrine engine for Gtk2
            # ];

            # Avoid the makefile which is only for theme maintainers.
            dontBuild = true;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/share/themes/rose-pine{,-dawn,-moon}/gtk-4.0

              variants=("rose-pine" "rose-pine-dawn" "rose-pine-moon")
              for n in "''${variants[@]}"; do
                cp -r $src/gtk3/"''${n}"-gtk/* \
                  $out/share/themes/"''${n}"

                cp -r $src/gtk4/"''${n}".css \
                  $out/share/themes/"''${n}"/gtk-4.0/gtk.css
              done

              runHook postInstall
            '';

            meta = {
              description = "Rosé Pine theme for GTK";
              homepage = "https://github.com/rose-pine/gtk";
              license = pkgs.lib.licenses.gpl3Only;
              platforms = pkgs.lib.platforms.linux;
              maintainers = with pkgs.lib.maintainers; [
                romildo
                the-argus
              ];
            };
          };
        }
      );
    };
}
