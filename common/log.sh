GREEN='\e[33m'
RED='\e[31m;'
RESET='\e[m'

function info() {
    echo -e "${GREEN}[INFO]${RESET}(${PROCNAME} ${LINENO[0]}:${FUNCNAME[1]}) $@"
}

function error() {
    echo -e "${RED}[ERROR]${RESET}(${PROCNAME} ${LINENO[0]}:${FUNCNAME[1]}) $@"
}

