{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils, ...}:
  flake-utils.lib.eachDefaultSystem (
    system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
    in rec {
      packages.default = pkgs.stdenv.mkDerivation {
        name = "freestanding-pass";
        src = ./.;
        makeFlags = [ "prefix=$(out)" ];
        postPatch = ''
          # We've placed a UUID comment for patching stuff into each source file
          substituteInPlace src/* \
            --replace "#ff3a228e-39fc-4c4e-9aa5-09e144da397a" "export PATH=\"''${out}/bin:${lib.makeBinPath ([
            pkgs.coreutils
            pkgs.pass
            pkgs.gnupg
          ])}\""
        '';
      };
      apps.default = { type = "app"; program = "${packages.default}/bin/freestanding-pass"; };
    }
  );
}
