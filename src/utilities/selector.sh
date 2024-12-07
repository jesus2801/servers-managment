# $@: Options array
# last option: Selected option
show_menu() {
  clear # Clear screen to avoid duplicates

  local options=("$@")
  #last element is the selected option
  local selected=${options[${#options[@]} - 1]}

  # avoid the last element since it doest not belong to the options
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

    # first signal of an arrow
    if [[ $input == $'\e' ]]; then

      # Read the next two characters
      read -rsn2 key
      if [[ $key == "[A" ]]; then # up arrow
        input="w"
      elif [[ $key == "[B" ]]; then # down arrow
        input="s"
      fi
    fi

    case $input in
    # Up
    w | W)
      if [ $selected -ge 1 ]; then
        ((selected--))
      fi
      ;;
    # Down
    s | S)
      if [ $selected -lt $((${#arr[@]} - 1)) ]; then
        ((selected++))
      fi
      ;;
    # 'Enter'
    "")
      echo -e "\n"
      return $selected
      ;;
    esac

    show_menu "${arr[@]}" $selected
  done
}

export -f select_choice
