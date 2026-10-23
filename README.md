# dotfiles

[![CI](https://github.com/ikanago/dotfiles/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/ikanago/dotfiles/actions/workflows/ci.yml)

macOS dotfiles managed by Nix (nix-darwin + home-manager).
See [AGENTS.md](./AGENTS.md) for the layout and conventions.

Hosts are selected by user name: `nagaoka.yuta` → `work`, otherwise `personal`.

## Bootstrap

Run in a regular terminal (Ghostty, Terminal.app). `sudo` needs a TTY to ask for the password.

### One-liner
```bash
curl -sL https://raw.githubusercontent.com/ikanago/dotfiles/main/install.sh | bash
```
It installs Nix, clones this repository to `~/ghq/github.com/ikanago/dotfiles`, backs up `/etc` files and runs the first switch.

### Manually
1. Install Nix with the official installer.
   ```bash
   curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon
   ```
   Open a new terminal afterwards.
2. Clone this repository. The path is fixed (`my.host.dotfilesDir`) because config files are symlinked into it.
   ```bash
   git clone https://github.com/ikanago/dotfiles ~/ghq/github.com/ikanago/dotfiles
   cd ~/ghq/github.com/ikanago/dotfiles
   ```
3. Move away the files the Nix installer wrote. nix-darwin refuses to overwrite them.
   ```bash
   sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
   sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
   sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
   ```
   If the switch stops with `Unexpected files in /etc`, move the listed files the same way.
4. Run the first switch. `just` is not installed yet, so run it through `nix run`.
   ```bash
   nix --extra-experimental-features "nix-command flakes" run nixpkgs#just -- bootstrap
   ```
5. Open a new terminal. From now on, `just` and `darwin-rebuild` are on PATH.

### Notes
- Existing files in the way (`~/.zshrc`, `~/.config/nvim`, ...) are renamed to `*.before-nix`. Delete them once everything works.
- Homebrew runs with `cleanup = "zap"`: formulae, casks and taps not listed in `nix/darwin/homebrew.nix` are removed on every switch.
- If Homebrew stops with `Refusing to load ... from untrusted tap`, uninstall that package by hand first (`brew trust <tap>` then `brew uninstall`).

## Usage
```bash
just switch   # apply
just build    # build without applying (no sudo)
just update   # update flake.lock
just fmt      # format Nix files
```

Rollback: `sudo darwin-rebuild --rollback`
