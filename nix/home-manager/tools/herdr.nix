{ pkgs, link, ... }:
{
  home.packages = [ pkgs.herdr ];

  xdg.configFile."herdr".source = link "herdr";
}
