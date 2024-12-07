#!/bin/bash

source ./data/constants.sh
source ./lib/logger.sh
source ./scripts/selector.sh
source ./scripts/yes_or_no.sh

MENU_OPTIONS=("Check Logs" "Send Files" "Routine Review" "Quit")

while true; do
  select_choice "${MENU_OPTIONS[@]}"

  case "$?" in
  0)
    echo "Checking logs..."
    ;;
  1)
    echo "Sending files..."
    ;;
  2)
    echo "Doing routine review..."
    ;;
  3)
    echo "Good bye!!"
    exit 0
    ;;
  esac

  ask_yes_or_no "Do you want to continue?"
  if [[ $? -eq 0 ]]; then
    break
  fi
done
