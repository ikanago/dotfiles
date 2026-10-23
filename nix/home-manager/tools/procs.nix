{ pkgs, ... }:
{
  home.packages = [ pkgs.procs ];

  my.human.aliases.ps = "procs";
}
