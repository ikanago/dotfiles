{
  pkgs,
  ...
}:
{
  my.host = {
    profile = "work";
    user = "nagaoka.yuta";
    email = "nagaoka.yuta@moneyforward.co.jp";
  };

  nix.settings.ssl-cert-file = "/etc/nix/ca-bundle-with-cloudflare.crt";

  homebrew.taps = [
    {
      name = "atlassian/acli";
      trusted = true;
    }
  ];
  homebrew.brews = [
    "atlassian/acli/acli"
    "displayplacer"
    "grep" # GNU grep as ggrep, egrep, fgrep
  ];
  # nix-darwin's services.karabiner-elements targets pre-15.x layout (missing LaunchAgents).
  environment.systemPackages = [
    pkgs.karabiner-elements
    pkgs.meetingbar
  ];
}
