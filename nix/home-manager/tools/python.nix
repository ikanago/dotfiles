{ pkgs, ... }:
{
  # Python versions and packages are managed by uv.
  # pip and poetry are denied for Claude Code (see claude.nix).
  home.packages = [ pkgs.uv ];
}
