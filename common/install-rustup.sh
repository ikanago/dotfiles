PROCNAME=${0##*/}

source ./common/log.sh

function install_rustup() {
    if [ ! $(command -v rustup) ]; then
        log "rustup is not installed yet"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
}


