# $@: Options array
# last option: Selected option
show_menu() {
  clear # Clear screen to avoid duplicates

  local options=("$@")
  local selected=${options[${#options[@]} - 1]}

  for ((i = 0; i < ${#options[@]} - 1; i++)); do
    if [[ $i -eq $selected ]]; then
      echo "[x] ${options[$i]}"
    else
      echo "[ ] ${options[$i]}"
    fi
  done
}

# $@: Options array
select_choice() {
  local selected=0

  local arr=("$@")
  show_menu "${arr[@]}" $selected

  while true; do
    read -rsn1 input # Reads a key (do not expect 'Enter')

    case $input in
    # Up
    w)
      if [ $selected -ge 1 ]; then
        ((selected--))
      fi
      ;;
    # Down
    s)
      if [ $selected -lt $((${#arr[@]} - 1)) ]; then
        ((selected++))
      fi
      ;;
    # 'Enter'
    "")
      return $selected
      ;;
    esac

    show_menu "${arr[@]}" $selected
  done
}

export -f select_choice
