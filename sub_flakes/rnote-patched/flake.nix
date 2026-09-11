{
  description = "Rnote - Simple drawing application to create handwritten notes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rnote-repo = {
      url = "github:flxzt/rnote/main";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      rnote-repo,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import rust-overlay) ];
      };

      rust = pkgs.rust-bin.stable.latest.default;

      mkRnote =
        {
          profile ? "default",
        }:
        pkgs.stdenv.mkDerivation rec {
          pname = "rnote";
          version = "0.14.2";

          src = rnote-repo;

          cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
            inherit src;
            hash = "sha256-z/68zpjHSwtTDmYtDANRUnulG10GOeZjHbdAcZroyUE=";
          };

          nativeBuildInputs = with pkgs; [
            appstream-glib
            cmake
            desktop-file-utils
            dos2unix
            meson
            ninja
            pkg-config
            python3
            rustPlatform.bindgenHook
            rustPlatform.cargoSetupHook
            rust
            shared-mime-info
            wrapGAppsHook4
          ];

          buildInputs =
            with pkgs;
            [
              appstream
              glib
              gst_all_1.gstreamer
              gtk4
              libadwaita
              libxml2
              poppler
            ]
            ++ lib.optionals stdenv.hostPlatform.isLinux [
              alsa-lib
            ];

          dontUseCmakeConfigure = true;

          mesonFlags = [
            (pkgs.lib.mesonBool "cli" true)
            (pkgs.lib.mesonOption "profile" profile)
          ];

          postPatch = ''
            chmod +x build-aux/*.py
            patchShebangs build-aux
          '';

          env = pkgs.lib.optionalAttrs pkgs.stdenv.cc.isClang {
            NIX_CFLAGS_COMPILE = "-Wno-error=incompatible-function-pointer-types";
          };

          meta = with pkgs.lib; {
            homepage = "https://github.com/flxzt/rnote";
            description = "Simple drawing application to create handwritten notes";
            license = licenses.gpl3Plus;

            maintainers = with maintainers; [
              dotlambda
              gepbird
              yrd
            ];

            platforms = platforms.unix;
          };
        };
    in
    {
      packages.${system} = {
        default = mkRnote { profile = "default"; };

        debug = mkRnote { profile = "devel"; };
      };

      defaultPackage.${system} = self.packages.${system}.default;
    };
}
