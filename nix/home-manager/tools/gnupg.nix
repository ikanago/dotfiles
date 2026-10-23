{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnupg
    pinentry_mac
  ];
}
