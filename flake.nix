{
  description = "A development environment for Hugo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo # Hugo static site generator
            git # Version control system
            nodejs # Node.js for Hugo themes that require it
            yarn # Yarn package manager for JavaScript dependencies
          ];

          shellHook = ''
            echo "Welcome to your Hugo development environment."
            echo "Use 'hugo server' to start the Hugo live server."
          '';
        };
      }
    );
}
