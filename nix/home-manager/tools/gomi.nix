{ pkgs, ... }:
{
  home.packages = [ pkgs.gomi ];

  # gomi accepts rm's flags and moves files to the trash.
  # Restore with `gomi -b`.
  my.human.aliases.rm = "gomi";
  my.ai.aliases.rm = "gomi";
}
