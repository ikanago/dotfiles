{ pkgs, link, ... }:
{
  home.packages = [ pkgs.neovim ];

  xdg.configFile."nvim".source = link "nvim";

  my.human.aliases.e = "nvim";
}
