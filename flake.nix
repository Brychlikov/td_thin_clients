{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      systems,
    }:
    flake-utils.lib.eachSystem (import systems) (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = flake-utils.lib.flattenTree { inherit (pkgs) hello; };

        devShells.default = with pkgs; pkgs.mkShell {
          buildInputs = [
            ansible
            vlc
            nmap
            ffmpeg
          ];
        };
      }
    );
}
