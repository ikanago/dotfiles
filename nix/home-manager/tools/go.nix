{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gopls
    golangci-lint
    gotests
    impl
    gomodifytags
    iferr
  ];

  my.env.GOPATH = "$HOME/go";
  my.path = [ "$HOME/go/bin" ];
}
