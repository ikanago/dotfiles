# dotfiles

![Ansible CI](https://github.com/ikanago/dotfiles/workflows/Ansible%20CI/badge.svg?branch=master)

## Requirements
### Ubuntu
```
$ sudo apt update \
    && sudo apt install -y software-properties-common \
    && sudo apt-add-repository -y --update ppa:ansible/ansible \
    && sudo apt install -y ansible git
```

### macOS
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ xcode-select --install
$ brew update && brew install caskroom/cask/brew-cask ansible git
```

And configure git.
```
$ git config --global user.name "ikanago" \
    && git config --global user.email ikanago@ikanago.dev \
```
Generate ssh key to establish connection with GitHub. [Connecting to GitHub with SSH](https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh). You may need to add some lines of configuration to `~/.ssh/config`. See [here](https://gist.github.com/ikanago/cbbaffbef12b86f6cbb60886b30d4ac0)  

## Install Ansible plugin
```
$ ansible-galaxy collection install community.general
```

## Run Playbook
```
$ git clone git@github.com:ikanago/dotfiles.git && cd dotfiles
$ ansible-playbook main.yml -K
```

### Utilities made with Rust
I could not installed them via Ansible because of linker error at GitHub Actions🤔.  
It should takes forever.
```
$ cargo install bat exa fd-find procs ripgrep hyperfine tokei hexyl
```
