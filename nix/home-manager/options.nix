{ lib, ... }:
let
  inherit (lib) mkOption types;
  # Values of `env` are written inside double quotes, so `$HOME` expands.
  # Do not put `"` in them.
  shellOptions = {
    aliases = mkOption {
      type = types.attrsOf types.str;
      default = { };
    };
    env = mkOption {
      type = types.attrsOf types.str;
      default = { };
    };
    init = mkOption {
      type = types.lines;
      default = "";
      description = "Raw zsh code such as functions and key bindings.";
    };
  };
in
{
  options.my = {
    # ~/.config/zsh/human.zsh: sourced only by interactive shells a human uses.
    human = shellOptions;
    # ~/.config/zsh/ai.zsh: sourced only by shells AI agents use.
    ai = shellOptions;

    # ~/.config/zsh/env.zsh: sourced by every shell, before the human/AI branch.
    env = mkOption {
      type = types.attrsOf types.str;
      default = { };
    };
    path = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Directories prepended to PATH. Missing ones are skipped.";
    };

    # Agent Skills linked into ~/.claude/skills and ~/.agents/skills.
    skills = mkOption {
      type = types.attrsOf types.path;
      default = { };
    };
  };
}
