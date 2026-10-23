{ ... }:
let
  files = "rg --files --hidden --follow --glob '!.git/*' --glob '!thirdparty/*'";
in
{
  # Key bindings (Ctrl-T, Ctrl-R, ...) are loaded only in human shells.
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = files;
    defaultOptions = [
      "--reverse"
      "--inline-info"
    ];
    fileWidget.command = files;
    fileWidget.options = [ "--preview 'bat --color=always --style=header,grid --line-range :100 {}'" ];
  };

  my.human.env = {
    FZF_TMUX = "1";
    FZF_TMUX_OPTS = "-p 80%";
  };
}
