ask_yes_or_no() {
  echo -e "\n"

  answer=""
  while [[ ! $answer =~ ^(y|n)$ ]]; do
    read -p "$1 (y/n): " answer
  done

  if [[ $answer == "y" ]]; then
    return 1
  else
    return 0
  fi
}
