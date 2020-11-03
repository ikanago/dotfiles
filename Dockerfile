FROM ubuntu:18.04

RUN apt update \
    && apt install -y software-properties-common \
    && apt-add-repository --y --update ppa:ansible/ansible \
    && apt install -y git ansible vim

RUN git clone https://github.com/ikanago/dotfiles.git \
    && cd dotfiles \
    # && git branch -r \
    # && git fetch origin ansible-packages \
    # && git checkout ansible-packages
