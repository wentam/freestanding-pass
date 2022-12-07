{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils, ...}:
  flake-utils.lib.eachDefaultSystem (
    system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      packages.default = pkgs.stdenv.mkDerivation {
        name = "freestanding-pass";
        src = ./.;
        makeFlags = [ "prefix=$(out)" ];
        postPatch = ''
          substituteInPlace freestanding-gpg \
            --replace "gpg" "${pkgs.gnupg}/bin/gpg"
        '';
      };
      apps.default = { type = "app"; program = "${packages.default}/bin/freestanding-pass"; };
    }
  );
}