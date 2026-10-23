# AGENTS.md

macOS dotfiles managed by Nix (nix-darwin + home-manager, one flake).

## Layout
- `flake.nix`: hosts `personal` (user `ikanago`) and `work` (user `nagaoka.yuta`)
- `nix/hosts/*.nix`: per-host values (`my.host.user`, `my.host.email`)
- `nix/darwin/`: system settings and Homebrew casks/brews (`homebrew.nix`)
- `nix/home-manager/tools/*.nix`: one file per tool. Every file there is imported automatically
- `nix/home-manager/tools/packages.nix`: tools that need no configuration
- `config/`: raw config files, linked from `tools/*.nix` or `files.nix`

## Adding a tool
1. Prefer nixpkgs. Use `nix/darwin/homebrew.nix` only for GUI apps or packages missing in nixpkgs.
2. If the tool needs no aliases, env vars or config, add it to `tools/packages.nix`.
3. Otherwise create `tools/<tool>.nix` and put its package, aliases, env vars, functions and config files together.
4. Removing a tool = deleting its file.

## Shell options (`nix/home-manager/options.nix`)
Shells are split into human and AI. AI is the default; human settings are opt-in.
- `my.human.{aliases,env,init}`: only interactive shells a human uses (`~/.config/zsh/human.zsh`)
- `my.ai.{aliases,env,init}`: only AI agent shells (`~/.config/zsh/ai.zsh`)
- `my.env`, `my.path`: every shell (`~/.config/zsh/env.zsh`)
- `my.skills.<name>`: Agent Skill directory linked to `~/.claude/skills` and `~/.agents/skills`

Rules:
- Aliases that change a command's behavior (`ls` → eza, `cp -i`, ...) go to `my.human` only.
- Anything that waits for input (editors, pagers, prompts) must not reach `my.ai` or `my.env`.
- Values in `env` are written in double quotes. `$HOME` expands; do not use `"` inside.

## Config files
- Edited often or written by the app (nvim, ghostty, herdr, Claude skills): `link "<path under config/>"` (out-of-store symlink, no switch needed)
- Rarely changed: `home.file.<target>.source = ../../config/<file>;`
- Tools that have a home-manager module (git, fzf, zsh): use `programs.<tool>`

## Commands
- `just build`: build and check (no sudo)
- `just switch`: apply (needs sudo; ask the user to run it)
- `just fmt`: format Nix files
