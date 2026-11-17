{
  pkgs,
  host,
  link,
  ...
}:
let
  profileConfig = if host.profile == "work" then "git/config.work" else "git/config.personal";
in
{
  # git itself is installed via Homebrew (nix/darwin/homebrew.nix).
  home.packages = [ pkgs.gh ];

  xdg.configFile = {
    "git/config".source = link profileConfig;
    "git/config.common".source = link "git/config.common";
    "git/ignore".source = link "git/ignore";
  };

  programs.delta = {
    enable = true;
    # Delta options are applied via the wrapped binary; git config is linked from config/git/.
    enableGitIntegration = false;
    options = {
      side-by-side = true;
      line-numbers = true;
      navigate = true;
    };
  };

  my.human.aliases = {
    g = "git";
    ga = "git add";
    gap = "git add -p";
    gc = "git commit";
    gp = "git push";
    gpl = "git pull";
    gl = "git log --graph --color=always --date=iso --pretty=format:'%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]'";
    gs = "git status";
    gd = "git diff";
    gb = "git branch";
    gswc = "git switch -c";
    gswt = "fzf-switch-worktree";
  };

  my.human.init = ''
    # git switch with worktree awareness (cd to existing worktree when branch is checked out elsewhere)
    gsw() {
        [[ $# -eq 0 ]] && { fzf-switch-branch; return; }
        [[ "$1" == -* ]] && { git switch "$@"; return; }
        local b="$1" t p
        t=$(git rev-parse --show-toplevel)
        p=$(git worktree list --porcelain | awk -v b="$b" '/^worktree /{w=$2} /^branch /{br=$2; sub(/^refs\/heads\//,"",br); if(br==b)p=w} END{print p}')
        [[ -n $p && $p != $t ]] && cd "$p" || git switch "$@"
    }

    function fzf-switch-branch() {
        local branch=$(
            git branch -a | \
                grep -v 'HEAD' | \
                cut -c 3- | \
                fzf --exit-0 --info=hidden --no-multi --prompt="CHECKOUT BRANCH > " --preview-window=right:60% \
                    --preview="echo {} | xargs git log --graph --color=always --date=iso --pretty=format:'%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]'"
        )
        if [ -n "''${branch}" ]; then
            # In sed regex, ^/ matches characters other than '/'.
            git switch $(echo "''${branch}" | sed 's#remotes/[^/]*/##')
        fi
    }

    function fzf-switch-worktree() {
        local selected_path
        # Preview shows the diff between the worktree's branch and its default branch
        # (origin/HEAD, falling back to origin/main), computed inside each worktree ({1} = path).
        selected_path=$(git worktree list | fzf --height 40% --reverse --header "Select a Worktree" \
            --preview 'default=$(git -C {1} rev-parse --abbrev-ref origin/HEAD 2>/dev/null || echo origin/main); git -C {1} diff --color=always "''${default}...HEAD"' \
            --preview-window 'right,60%' | awk '{print $1}')

        if [ -n "$selected_path" ]; then
            cd "$selected_path" || return
        fi
    }
  '';
}
