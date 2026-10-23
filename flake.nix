{
  description = "ikanago's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      system = "aarch64-darwin";
      mkHost =
        hostModule:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            hostModule
            ./nix/darwin
            home-manager.darwinModules.home-manager
          ];
        };
    in
    {
      darwinConfigurations = {
        personal = mkHost ./nix/hosts/personal.nix;
        work = mkHost ./nix/hosts/work.nix;
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
