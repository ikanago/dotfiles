host := if `whoami` == "nagaoka.yuta" { "work" } else { "personal" }

# Apply the configuration
switch:
    sudo darwin-rebuild switch --flake .#{{host}}

# Build without applying
build:
    nix build .#darwinConfigurations.{{host}}.system

# First run, before darwin-rebuild is on PATH
bootstrap:
    sudo -H nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake .#{{host}}

# Update flake.lock and Homebrew casks
update:
    nix flake update
    brew upgrade --cask

fmt:
    nix fmt -- flake.nix nix
