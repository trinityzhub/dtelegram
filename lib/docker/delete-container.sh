#!/bin/bash

######### METHOD :  conatiner stop<CONT<DEL<OPS<DOCKER

## ./delete-container.sh
## ./terminal/DOCKER/KNOW_DOCKER/delete/delete-docker.sh
## https://github.com/joelz-jobs/workbook/blob/main/terminal/DOCKER/KNOW_DOCKER/delete/delete-docker.sh
## wget https://raw.githubusercontent.com/joelz-jobs/workbook/main/terminal/DOCKER/KNOW_DOCKER/delete/delete-docker.sh

# CURRENT_SCRIPT_DIR=$0
# CURRENT_TERMINAL_DIR=$(pwd)


# echo "CURRENT_SCRIPT_DIR: "$CURRENT_SCRIPT_DIR
# echo "CURRENT_TERMINAL_DIR: "$CURRENT_TERMINAL_DIR
# echo "MY_PATH: "$MY_PATH

echo "PLEASE SELECT CONTAINER:"
choicesToShow=($(docker container ls --all --format "{{.Names}}"))

MY_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
source $MY_PATH/../general/select.sh  ## "${choices[@]}"


## Taking mychoicefromsel value for action
CONTAINER_NAME=$mychoicefromsel
unset mychoicefromsel

if [ "$CONTAINER_NAME" != "" ]; then
  docker stop $CONTAINER_NAME 
  docker rm $CONTAINER_NAME 
  echo "docker rm $CONTAINER_NAME"
  echo "$MY_PATH/delete-variables.sh $CONTAINER_NAME"
  $MY_PATH/delete-variables.sh $CONTAINER_NAME

fi

unset CONTAINER_NAME

echo "--done--"