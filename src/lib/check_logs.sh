check_logs() {
  local OPTIONS=("Show Errors" "Show Warnings" "Show All Logs" "Basic Search")

  select_choice "${OPTIONS[@]}"

  case "$?" in
  0)
    regex="^\[.*[0-9]{2}\]\[ERROR\]:"
    ;;
  1)
    regex="^\[.*[0-9]{2}\]\[WARNING\]:"
    ;;
  2)
    regex="."
    ;;
  3)
    read -rp "write a search: (regex or plain text): " regex
    ;;
  esac

  grep -E $regex $LOGS_FILE
  matches=$(grep -cE $regex $LOGS_FILE)
  echo "$matches lines matched"
}
