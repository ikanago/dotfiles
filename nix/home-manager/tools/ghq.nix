{ pkgs, ... }:
{
  home.packages = [ pkgs.ghq ];

  my.human.init = ''
    # Fuzzy search in repositories
    # ghq list does not follow symlinks, so list directory symlinks under
    # the ghq root ourselves. repo layout is host/owner/repo => maxdepth 3.
    function search_ghq() {
        local target_dir=$(
            {
                ghq list -p
                find "$(ghq root)" -maxdepth 3 -type l 2>/dev/null | while read -r link; do
                    [ -d "$link" ] && echo "$link"
                done
            } | sort -u | fzf --query="$LBUFFER"
        )
        if [ -n "$target_dir" ]; then
            BUFFER="cd ''${target_dir}"
            zle accept-line
        fi
        zle reset-prompt
    }
    zle -N search_ghq
    bindkey "^g" search_ghq
  '';
}
