# $@: Options array
# last option: Selected option
show_menu() {
  clear # Limpiar la pantalla para evitar duplicados

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
  # Inicializa el índice de la opción seleccionada
  local selected=0

  local arr=("$@")
  show_menu "${arr[@]}" $selected

  # Lógica para manejar las teclas presionadas
  while true; do
    read -rsn1 input # Lee una tecla (sin esperar ENTER)

    case $input in
    # Arriba: Decrementar la opción seleccionada
    w)
      if [ $selected -ge 1 ]; then
        ((selected--))
      fi
      ;;
    # Abajo: Incrementar la opción seleccionada
    s)
      if [ $selected -lt $((${#arr[@]} - 1)) ]; then
        ((selected++))
      fi
      ;;
    # Enter: Ejecutar la opción seleccionada
    "")
      return $selected
      ;;
    esac

    show_menu "${arr[@]}" $selected
  done
}

export -f select_choice
