{
  config,
  lib,
  host,
  ...
}:
let
  # Symlink to the file in this repository (not the Nix store), so edits take
  # effect without switching and apps can write to it (e.g. lazy-lock.json).
  link = path: config.lib.file.mkOutOfStoreSymlink "${host.dotfilesDir}/config/${path}";
in
{
  _module.args.link = link;

  # Static files rarely changed: copied through the Nix store.
  home.file = {
    ".vimrc".source = ../../config/vimrc;
    ".gdbinit".source = ../../config/gdbinit;
    ".bashrc".source = ../../config/bashrc;
  }
  // lib.concatMapAttrs (name: src: {
    ".claude/skills/${name}".source = src;
    ".agents/skills/${name}".source = src;
  }) config.my.skills;
}
