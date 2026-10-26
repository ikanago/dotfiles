{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.host;
in
{
  imports = [ ./homebrew.nix ];

  options.my.host = {
    profile = lib.mkOption {
      type = lib.types.enum [ "personal" "work" ];
      description = "Host profile for host-specific home-manager configuration.";
    };
    user = lib.mkOption { type = lib.types.str; };
    email = lib.mkOption { type = lib.types.str; };
    dotfilesDir = lib.mkOption {
      type = lib.types.str;
      default = "/Users/${cfg.user}/ghq/github.com/ikanago/dotfiles";
      description = "Absolute path of this repository. Targets of mkOutOfStoreSymlink.";
    };
  };

  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ cfg.user ];
    };
    nixpkgs.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowUnfree = true;

    system.primaryUser = cfg.user;
    system.stateVersion = 6;
    users.users.${cfg.user}.home = "/Users/${cfg.user}";

    # Provides /etc/zshenv that puts Nix profiles on PATH.
    # Completion and prompt are configured by home-manager.
    programs.zsh = {
      enable = true;
      enableCompletion = false;
      enableBashCompletion = false;
      promptInit = "";
    };

    security.pam.services.sudo_local.touchIdAuth = true;

    fonts.packages = with pkgs.nerd-fonts; [
      _0xproto
      monaspace
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "before-nix";
      extraSpecialArgs = {
        host = cfg;
      };
      users.${cfg.user} = import ../home-manager;
    };
  };
}
