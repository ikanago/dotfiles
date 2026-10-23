{ pkgs, ... }:
{
  home.packages = [ pkgs.ripgrep ];

  my.human.aliases.rg = "rg --hidden -g '!.git'";

  my.human.init = ''
    # Interactive full-text search
    function ff() {
        RG_DEFAULT_COMMAND="rg -i -l --hidden --follow --glob '!.git/*'"
        fzf -m --ansi --phony --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" --preview "rg -i --context 2 --pretty {q} {}"
    }
  '';
}
