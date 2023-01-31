#!/bin/bash
###################     pass by arg<FILE<DELETE<OPS<DOCKER

# ## delete variables

# echo "CONTAINER NAME:"
# docker container ls --all --format "{{.Names}}"

# echo -e "\n"
# read -p 'Enter  container namree (eg: dbrave-spring ): ' APP_NAME
# ##### find image id

APP_NAME=$1
echo "APPLICATION NAME: $APP_NAME"

if [ "$APP_NAME" != "" ]; then

   rm -rf $HOME/.local/bin/$APP_NAME
   rm -rf  $HOME/.local/share/applications/$APP_NAME.desktop

   rm -rf ~/.local/share/applications/$APP_NAME.desktop
   rm -rf  ~/.local/bin/$APP_NAME

   rm -rf /home/ubbe/.local/share/applications/$APP_NAME.desktop
   rm -rf  /home/ubbe/.local/bin/$APP_NAME
else
   echo "APP_NAME is empty"
fi

## old build
#rm -rf $HOME/.local/share/applications/dBrave.desktop 
#rm -rf $HOME/.local/bin/dbrave
