{ pkgs, ... }:
{
  my.human.init = ''
    fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
    autoload -Uz promptinit
    promptinit
    prompt pure
    PURE_CMD_MAX_EXEC_TIME=1
    zstyle :prompt:pure:path color 033
    zstyle :prompt:pure:prompt:success color 034
    zstyle :prompt:pure:git:branch color 058
  '';
}
