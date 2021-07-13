# dotfiles

![Ansible CI](https://github.com/ikanago/dotfiles/workflows/Ansible%20CI/badge.svg?branch=master)

## Requirements
### Ubuntu
```
 sudo apt update \
    && sudo apt install -y software-properties-common \
    && sudo apt-add-repository -y --update ppa:ansible/ansible \
    && sudo apt install -y ansible git
```

### macOS
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
xcode-select --install
brew update && brew install caskroom/cask/brew-cask ansible git
```

And configure git.
```
git config --global user.name "ikanago" \
    && git config --global user.email ikanago@ikanago.dev
```
Generate ssh key to establish connection with GitHub. [Connecting to GitHub with SSH](https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh). You may need to add some lines of configuration to `~/.ssh/config`. See [here](https://gist.github.com/ikanago/cbbaffbef12b86f6cbb60886b30d4ac0)  

To use HTTPS for authentication, set up credential helper(now macOS only).
```
git config --global credential.helper osxkeychain
```
See [here](https://docs.github.com/en/github/using-git/caching-your-github-credentials-in-git) for details.
Generate Personal Access Token with `repo` and `workflow` permission.

## Run Playbook
```
git clone https://github.com/ikanago/dotfiles.git
cd dotfiles
ansible-playbook main.yml -K
ansible-playbook main.yml --tags dotfiles # dotfiles only
```
