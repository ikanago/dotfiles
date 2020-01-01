# dotfiles

## How to use
### init
Automatically install binaries(unverified).
`sh etc/init.sh`

### Create link
Create link to dotfiles in home directory(this will be executed in `init.sh`).
`sh deploy.sh`

## Manual installation
Enumerate installation of binaries below(in ubuntu). Remember that run `sudo apt update` and `sudo apt-get update` occationally.

### Cargo
Reference: https://doc.rust-lang.org/cargo/getting-started/installation.html  
`cargo` is a Rust packege manager.  
Just run this.
```
$ curl https://sh.rustup.rs -sSf | sh
```
Select installation option `1) Proceed with installation`.
`~/.cargo/env` is already written in `.zshrc` as a environment variable.

### GVM
Reference: https://qiita.com/makoto1007/items/9400d232f5673b34abda  
`gvm` is a Go package manager.
Run this line.
```$ bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/bin
scripts/gvm-installer)
```
You may be warned that `Could not find bison` or `Could not find gcc`. If so, install them:
```
$ sudo apt install -y bison gcc
```
After `gvm` installation, let's install Go. First, find latest available version of Go.
```
$ gvm listall
```
Then install Go.
```
$ gvm install go1.x.x -B
```
Finally, make available installed Go.
```
$ gvm use go1.x.x --default
```
You can check `$GOPATH` and `$GOROOT` something like this.
```
$ echo $GOPATH
/home/user/.gvm/pkgsets/go1.x.x/global
$ echo $GOROOT
/home/user/.gvm/gos/go1.x.x
```

### Zsh
Reference: https://github.com/zdharma/zplugin  
Install zsh and its plugin manager `zplugin`.
```
$ sudo apt install zsh
```
Then run this line to install `zplugin`.
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
```
After installation, change login shell.
```
$ chsh
Password: 
Changing the login shell for user
Enter the new value, or press ENTER for the default
        Login Shell [/bin/zsh]: /usr/bin/zsh
```

### Neovim
Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/  
Just download `nvim.appimage` and run it.
```
$ curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
$ chmod u+x nvim.appimage
$ ./nvim.appimage
```
Configuration file is automatically deployed on home directory through `deploy.sh`.

### Docker
Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/  
Install packages to allow `apt` to use a repository over HTTPS.
```
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```
Add Docker's official GPG key.
```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Verify that you now have the key.
```
$ sudo apt-key fingerprint 0EBFCD88
    
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```
Set up `stable` repository.
```
$ sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
```
Update the `apt` package index.
```
$ sudo apt-get update
```
And install the latest version of Docker Engine.
```
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```
