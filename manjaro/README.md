# Set up Manjaro
## Install packages
Update mirrors for faster download
```bash
sudo pacman-mirrors --geoip
```

Update the existing packages
```bash
sudo pacman -Syu --disable-download-timeout
```

Install packages
```bash
sudo pacman -S --needed --noconfirm - < manjaro/pacman.txt
```

## Set up dotfiles
```bash
curl -sL https://raw.githubusercontent.com/ikanago/dotfiles/main/install.sh | bash
```

## Set up Japanese input
Launch `fcitx5-configtool` and add `mozc` to the input method
```bash
fcitx5-configtool
```
