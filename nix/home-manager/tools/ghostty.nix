# Ghostty.app itself is a Homebrew cask (see nix/darwin/homebrew.nix).
{ link, ... }:
{
  xdg.configFile."ghostty".source = link "ghostty";
}
