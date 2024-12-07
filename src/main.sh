#!/bin/bash

source ./data/constants.sh
source ./lib/logger.sh
source ./scripts/selector.sh

arr=("Opt 1" "Opt 2" "lakdfj")
select_choice "${arr[@]}"
echo $?
