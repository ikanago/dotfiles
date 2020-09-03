# dotfiles

## Before use
1. Install `git`, `gvm`, `go`, `ghq`. [Install latest version of git](https://git-scm.com/download/linux)  
2. Configure personal information.
```
$ git config --global user.name "ikanago"
$ git config --global user.email "<username>@users.noreply.github.com"
$ git config --global core.editor vim
```
You can get the email address [here](https://github.com/settings/emails).  
3. Generate ssh key to establish connection with GitHub. [Connecting to GitHub with SSH](https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh). You may need to add some lines of configuration to `~/.ssh/config`. See [here](https://gist.github.com/ikanago/cbbaffbef12b86f6cbb60886b30d4ac0)  
4. Run `ghq get -p git@github.com:ikanago/dotfiles.git` to clone this repository.  

## How to use
### Create link
Create link to dotfiles in home directory(this will be executed in `init.sh`).
```
$ sh deploy.sh
```
Or you have `make`, run `make deploy`.

## Install tools
Enumerate installation of tools below(in ubuntu).

### Utilities
```
$ sudo apt install bison build-essential jq tree zsh
```

### Starship
Reference: https://starship.rs/
```
$ curl -fsSL https://starship.rs/install.sh | bash
```

### Cargo
Reference: https://doc.rust-lang.org/cargo/getting-started/installation.html  
```
$ curl https://sh.rustup.rs -sSf | sh
```

### Utilities made with Rust
```
$ cargo install bat exa fd-find procs ripgrep hyperfine tokei
```

### Node
Install version manager for Node.js.
Reference: https://github.com/tj/n
```
$ curl -L https://git.io/n-install | bash
```
And install `yarn`.
```
$ npm install -g yarn
```

### GVM
Reference: https://qiita.com/makoto1007/items/9400d232f5673b34abda  
`gvm` is a Go package manager.
Run this line.
```
$ bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
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

### ghq
Reference: https://github.com/x-motemen/ghq
```
$ go get github.com/x-motemen/ghq
```

### fzf
Reference: https://github.com/junegunn/fzf
```
$ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$ ~/.fzf/install
```

### pyenv
Reference: https://github.com/pyenv/pyenv#basic-github-checkout
```
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv
$ pyenv install 3.8
$ pyenv global 3.8
```

### zinit
Reference: https://github.com/zdharma/zinit  
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```

### Neovim
Reference: https://github.com/neovim/neovim/wiki/Installing-Neovim
```
$ curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
$ chmod u+x nvim.appimage
$ ./nvim.appimage
```
And install package manager.
```
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/.cache/dein
```

### Docker
Reference: https://docs.docker.com/engine/install/  

### Docker compose
Reference: http://docs.docker.jp/compose/install.html#linux-compose
