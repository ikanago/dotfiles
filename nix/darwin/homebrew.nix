# Only things that are not available (or not usable) from nixpkgs.
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    taps = [
      "laishulu/homebrew"
    ];
    brews = [
      # Input source switcher used by nvim (auto-input-switch.lua)
      "laishulu/homebrew/macism"
    ];
    casks = [
      "alt-tab"
      "bitwarden"
      "clipy"
      "ghostty"
      "obsidian"
      "raycast"
      "yubico-authenticator"
    ];
  };
}
