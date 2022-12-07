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
          substituteInPlace src/freestanding-gpg \
            --replace "gpg" "${pkgs.gnupg}/bin/gpg"
          substituteInPlace src/freestanding-pass \
            --replace "pass \$@" "${pkgs.pass}/bin/pass \$@"
        '';
      };
      apps.default = { type = "app"; program = "${packages.default}/bin/freestanding-pass"; };
    }
  );
}
