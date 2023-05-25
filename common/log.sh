function log() {
    GREEN='\033[0;32m'
    RESET='\033[0m'

    echo "${GREEN}[INFO]${RESET}(${PROCNAME} ${LINENO[0]}:${FUNCNAME[1]}) $@"
}

