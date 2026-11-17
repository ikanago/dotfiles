# Work-only env: TLS trust for corporate proxy (same bundle as nix.settings.ssl-cert-file on work) and PATH.
{ host, lib, ... }:
lib.mkIf (host.profile == "work") {
  my.path = [ "$HOME/ghq/github.com/moneyforward/arcturus/bin" ];
}
