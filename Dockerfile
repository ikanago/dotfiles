FROM ubuntu:18.04

RUN apt update \
    && apt install git ansible vim \
    && git clone https://github.com/ikanago/dotfiles.git \

WORKDIR ./dotfiles

RUN git branch -r \
    && git fetch origin ansible-packages \
    && git checkout ansible-packages
