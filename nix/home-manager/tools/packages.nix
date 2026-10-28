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
    argocd
    ast-grep
    awscli2
    bat
    cloudflared
    cmake
    deno
    duckdb
    exiftool
    fd
    gnupg
    hexyl
    htop
    hyperfine
    imagemagick
    jq
    just
    k9s
    kubectl
    kubernetes-helm
    kustomize
    nodejs_26
    pinentry_mac
    pnpm
    procs
    scc
    shellcheck
    shfmt
    tokei
    # Python versions and packages are managed by uv.
    # pip and poetry are denied for Claude Code (see claude.nix).
    uv
    yq-go
    yubikey-manager
    (only "gsed" gnused "sed")
    (only "timeout" coreutils "timeout")
  ];
}
