_LOGS_FILE="$PWD/logs/history.logs"

if [[ ! -f "$_LOGS_FILE" ]]; then
  touch $_LOGS_FILE
fi

_make_log() {
  local DATE=$(date "+%Y-%m-%d %H:%M:%S")
  local log="[$DATE]$1\n"

  for ((i = 1; i < ${#BASH_SOURCE[@]}; i++)); do
    local absolute_path=$(realpath "$PWD/${BASH_SOURCE[$i]}")
    log+="FILE: $absolute_path:${BASH_LINENO[$((i - 1))]}\n"
  done

  echo -e "$log" >>$_LOGS_FILE
}

_print_red() {
  echo -e "\e[1;31m$1\e[0m"
}

_print_yellow() {
  echo -e "\e[1;33m$1\e[0m"
}

_print_error() {
  local msg="[ERROR]: $1"
  _print_red "$msg"
  _make_log "$msg"
  echo "More information can be found at $_LOGS_FILE"
  exit 1
}

_print_warning() {
  local msg="[WARNING]: $1"
  _print_yellow "$msg"
  _make_log "$msg"
}

print_msg() {
  case "$1" in
  "error")
    _print_error "$2"
    ;;
  "warning")
    _print_warning "$2"
    ;;
  "info")
    echo $2
    ;;
  *)
    _print_error "Bad option when trying to print a message"
    ;;
  esac
}

export -f print_msg