{ pkgs, ... }:
{
  # Toolchains are managed by rustup itself.
  home.packages = with pkgs; [
    rustup
    sqlx-cli
  ];

  # Binaries installed by `cargo install`
  my.path = [ "$HOME/.cargo/bin" ];

  my.human.aliases = {
    c = "cargo";
    cb = "cargo build";
    cf = "cargo fmt";
    ct = "cargo test";
    cr = "cargo run";
    cli = "cargo clippy --all-features";
    co = "cargo outdated";
  };
}
