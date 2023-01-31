#!/bin/bash

######### METHOD :  Stooped bfr deleting #4<IMG<DEL<OPS<DKR

## ./delete-images.sh
## ./terminal/DOCKER/KNOW_DOCKER/delete/delete-docker.sh
## https://github.com/joelz-jobs/workbook/blob/main/terminal/DOCKER/KNOW_DOCKER/delete/delete-docker.sh
## wget https://raw.githubusercontent.com/joelz-jobs/workbook/main/terminal/DOCKER/KNOW_DOCKER/delete/delete-docker.sh

echo "PLEASE SELECT IMAGE:"
choicesToShow=($(docker images --format "{{.Repository}}:{{.Tag}}"))
MY_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
source $MY_PATH/../general/select.sh  ## "${choices[@]}"


## Taking mychoicefromsel value for action
IMAGE_TAG_NAME=$mychoicefromsel
unset mychoicefromsel


if [ "$IMAGE_TAG_NAME" != "" ]; then
  echo "deleting containers...."
  CONTAINER_NAME_ARRAY=($( docker container ls --all | grep $IMAGE_TAG_NAME | awk ‘{print $NF}’  ))
  echo "CONTAINER_NAME_ARRAY: ${CONTAINER_NAME_ARRAY[@]}"

  ##docker container ls --all |  grep $(echo $IMAGE_TAG_NAME |  sed -e 's/:latest//') | awk '{print $1}'  | xargs -n 1 docker rm 
  echo "deleting containers... "
  docker container ls --all |  grep $(echo $IMAGE_TAG_NAME |  sed -e 's/:latest//') | awk '{print $1}'  | xargs -n 1 -I % sh -c  'docker stop % && docker rm  % '
  echo "docker container ls --all |  grep $(echo $IMAGE_TAG_NAME |  sed -e 's/:latest//') | awk '{print $1}'  | xargs -n 1 -I % sh -c  docker stop % && docker rm  % "


  docker rmi $IMAGE_TAG_NAME 
  echo "docker rmi $IMAGE_TAG_NAME "


  ## METdeHOD : USING IMAGE ID
  #docker container ls --all | grep <IMAGE_ID> | awk '{print $1}' | xargs docker rm 
  #docker container ls --all | grep 390985b45759 | awk '{print $1}' | xargs docker rm 

  for CONTAINER_NAME in "${CONTAINER_NAME_ARRAY[@]}"; do
    # Validate the number entered
    $MY_PATH/delete-variables.sh $CONTAINER_NAME
    echo "$MY_PATH/delete-variables.sh $CONTAINER_NAME"

  done
fi

unset CONTAINER_NAME_ARRAY
unset CONTAINER_NAME

echo "--done--"