routine_review() {
  local OPTIONS=("Basic System Info" "Check Cron Jobs" "Clean Logs File")

  select_choice "${OPTIONS[@]}"

  case "$?" in
  0)
    available_mem=$(free -m | awk '{print $7}' | xargs)
    total_mem=$(free -m | awk 'NR==2 {print $2}')
    echo -e "Available Memory: $available_mem - $((available_mem * 100 / total_mem))%\n"

    top -bn1 | grep "Cpu(s)"
    echo -e "\n"

    df -h
    echo -e "\n"

    echo "Uptime: $(uptime)"
    ;;
  1)
    crontab -l
    ;;
  2)
    cat /dev/null >$LOGS_FILE
    echo "Logs at $LOGS_FILE cleaned"
    ;;
  esac
}
