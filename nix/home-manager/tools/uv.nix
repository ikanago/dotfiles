# Python versions and packages are managed by uv.
# pip and poetry are denied for Claude Code (see claude.nix).
{ pkgs, ... }:
{
  home.packages = [ pkgs.uv ];

  # Keep the cache next to go-build so the Claude Code sandbox can write it (see claude.nix).
  my.env.UV_CACHE_DIR = "$HOME/Library/Caches/uv";
}
