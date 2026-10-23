{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];

  my.human.aliases.t = "tmux";
}
