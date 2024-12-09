send_files() {
  # more options will be added here
  local OPTIONS=("Send Files (More options will be added in the future)")

  select_choice "${OPTIONS[@]}"

  case "$?" in
  0)
    read -p "Enter the destination username: " username

    ip=""
    while [[ ! $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; do
      read -p "Enter the destination ip: " ip
    done

    dir=""
    while [[ ! -d $dir ]]; do
      read -p "Folder: " dir
    done

    scp -rv "$dir" "$username@$ip:/home/$username/"

    if [[ $? -ne 0 ]]; then
      print_msg "error" "Unexpected error when trying to copy files to $ip"
    fi

    echo "Files successfully transfered"
    ;;
  esac
}
