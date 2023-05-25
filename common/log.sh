function info() {
    GREEN='\033[0;32m'
    RESET='\033[0m'

    echo -e "${GREEN}[INFO]${RESET}(${PROCNAME} ${LINENO[0]}:${FUNCNAME[1]}) $@"
}

