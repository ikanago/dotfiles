# CLI tools that need no configuration, aliases or environment variables.
# Give a tool its own file under tools/ once it needs any of them.
{ pkgs, ... }:
let
  # Expose a single GNU command without shadowing the BSD userland.
  only =
    name: pkg: bin:
    pkgs.runCommand name { } ''
      mkdir -p $out/bin
      ln -s ${pkg}/bin/${bin} $out/bin/${name}
    '';
in
{
  home.packages = with pkgs; [
    # Commands AI agents use often
    ast-grep
    duckdb
    fd
    hyperfine
    jq
    scc
    shellcheck
    shfmt
    yq-go
    (only "timeout" coreutils "timeout")
    (only "gsed" gnused "sed")

    # General
    bat
    cmake
    exiftool
    hexyl
    htop
    imagemagick
    just
    mosh
    tokei
    yubikey-manager

    # Infrastructure
    argocd
    cloudflared
    kubectl
    kubernetes-helm
    k9s
    postgresql

    ollama
  ];
}
