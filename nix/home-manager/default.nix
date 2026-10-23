{ lib, host, ... }:
let
  # Every *.nix under tools/ is imported automatically.
  # Adding or removing a tool is just adding or removing a file.
  tools = lib.mapAttrsToList (name: _: ./tools + "/${name}") (
    lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) (
      builtins.readDir ./tools
    )
  );
in
{
  imports = [
    ./options.nix
    ./shell.nix
    ./files.nix
  ]
  ++ tools;

  home.username = host.user;
  home.homeDirectory = "/Users/${host.user}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
