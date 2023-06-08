FROM ubuntu:latest

RUN apt update \
    && apt install -y curl \
    && /bin/sh -c $(curl -fsSL "https://raw.githubusercontent.com/ikanago/dotfiles/main/install.sh")

