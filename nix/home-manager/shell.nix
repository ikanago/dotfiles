{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my;
  renderEnv = env: lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: ''export ${k}="${v}"'') env);
  renderAliases =
    aliases:
    lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "alias ${k}=${lib.escapeShellArg v}") aliases);
  renderShell =
    s:
    lib.concatStringsSep "\n\n" (
      lib.filter (x: x != "") [
        (renderEnv s.env)
        (renderAliases s.aliases)
        s.init
      ]
    )
    + "\n";
in
{
  my.env = {
    XDG_CACHE_HOME = "$HOME/.cache";
  };
  my.path = [
    "$HOME/.local/bin"
    "$HOME/.ghcup/bin"
    "$HOME/google-cloud-sdk/bin"
    "$HOME/.devcontainers/bin"
  ];

  my.human = {
    env = {
      EDITOR = "nvim";
      PAGER = "less";
      # Do not clear the screen after quitting a man page
      MANPAGER = "less -X";
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = "10";
    };
    aliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      cs = "agent";
      # Show paths splitted with newline.
      path = ''printf '%b\n' "''${PATH//:/\\n}"'';
    };
    init = ''
      export GPG_TTY=$(tty)

      # mkdir and cd simultaneously
      function mkcd() {
          if [[ -d $1 ]]; then
              echo "$1 already exists"
              cd $1
          else
              mkdir -p $1 && cd $1
          fi
      }
    '';
  };

  # Never block on an editor or a pager.
  my.ai.env = {
    EDITOR = "true";
    VISUAL = "true";
    GIT_EDITOR = "true";
    PAGER = "cat";
    GIT_PAGER = "cat";
    MANPAGER = "cat";
  };

  xdg.configFile."zsh/env.zsh".text = ''
    ${renderEnv cfg.env}

    typeset -gU path
    path=(${lib.concatMapStringsSep " " (p: ''"${p}"(N-/)'') cfg.path} $path)
    # Homebrew comes after Nix.
    path+=("/opt/homebrew/bin"(N-/) "/opt/homebrew/sbin"(N-/))
  '';
  xdg.configFile."zsh/human.zsh".text = renderShell cfg.human;
  xdg.configFile."zsh/ai.zsh".text = renderShell cfg.ai;

  home.packages = [ pkgs.zsh-completions ];

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";

    envExtra = ''
      source "$HOME/.config/zsh/env.zsh"

      # A human is at the terminal only when stdin/stdout are TTYs and
      # no AI agent marker is set. $TERM is inherited, so it is not usable.
      is_human() {
          [[ -t 0 && -t 1 ]] || return 1
          [[ -z "''${CLAUDECODE}''${CURSOR_AGENT}''${GEMINI_CLI}''${CODEX_SANDBOX}" ]]
      }

      if ! is_human; then
          source "$HOME/.config/zsh/ai.zsh"
      fi
    '';

    completionInit = ''
      zstyle ':completion:*' auto-description 'specify: %d'
      zstyle ':completion:*' completer _expand _complete _correct _approximate
      zstyle ':completion:*' format 'Completing %d'
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' menu select=2
      zstyle ':completion:*' list-colors '''
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list ''' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
      zstyle ':completion:*' menu select=long
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' use-compctl false
      zstyle ':completion:*' verbose true
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
      zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

      autoload -Uz compinit
      local zcompdump="''${XDG_CACHE_HOME}/zsh/zcompdump-''${ZSH_VERSION}"
      mkdir -p "''${zcompdump:h}"
      if [[ -f "''${zcompdump}.zwc" && "''${zcompdump}.zwc" -nt "''${zcompdump}" ]]; then
        compinit -C -d "''${zcompdump}"
      else
        compinit -d "''${zcompdump}"
        zcompile -Uz "''${zcompdump}"
      fi
    '';

    initContent = lib.mkMerge [
      (lib.mkOrder 0 ''
        [[ -n "''${ZSH_ZPROF:-}" ]] && zmodload zsh/zprof
      '')
      (lib.mkOrder 100 ''
        [ -f "$HOME/.envrc" ] && source "$HOME/.envrc"

        # Everything below is for humans only.
        is_human || return 0
      '')
      ''
        # After `bindkey -e`, which would drop key bindings defined earlier.
        source "$HOME/.config/zsh/human.zsh"

        autoload -Uz colors
        colors
      ''
      (lib.mkOrder 10000 ''
        # `if` keeps $? at 0; with `&&` pure shows the first prompt as failed.
        if [[ -n "''${ZSH_ZPROF:-}" ]]; then zprof; fi
      '')
    ];

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      share = true;
    };

    autosuggestion.enable = true;

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";
      }
    ];
  };
}
