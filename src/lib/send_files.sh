send_files() {
  # more options will be added here
  local OPTIONS=("Send Files (More options will be added in the future)")

  select_choice "${OPTIONS[@]}"

  case "$?" in
  0)
    echo "hello world"
    ;;
  esac
}
