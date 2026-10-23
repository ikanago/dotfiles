{ pkgs, ... }:
{
  home.packages = [ pkgs.eza ];

  # Humans only: `ls` flags AI agents use (e.g. `ls -1t`) differ in eza.
  my.human.aliases = {
    l = "eza";
    ls = "eza";
    la = "eza -a";
    ll = "eza -lab --time-style=long-iso";
    tree = "eza -al --tree --git-ignore -I '.git'";
  };
}
