FROM ubuntu

RUN apt update \
    && apt install -y software-properties-common \
    && apt-add-repository --y --update ppa:ansible/ansible \
    && apt install -y git ansible vim

COPY . .
