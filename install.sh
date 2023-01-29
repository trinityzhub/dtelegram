#!/bin/bash

##
## Telegram Installation Script
##


##  /home/ubbe/CodeBase/DockerGit/DailyLifeApps/telegram/dtelegram-t9/install.sh







##docker images --format "{{.Repository}}:{{.Tag}}" | grep "telegram"

## 
choicesToShow=($( { docker images --format "{{.Repository}}:{{.Tag}}" | grep "telegram"  ; echo "CREATE_IMAGE" ;  } ))
source ./lib/select.sh 
DOCKER_IMAGE_TAG=$mychoicefromsel
unset mychoicefromsel

if [ "$DOCKER_IMAGE_TAG" == "CREATE_IMAGE" ]; then

    echo -e "\n"
    read -p 'Enter  DEV_ID (eg: trinity0091 ): ' DEV_ID

    if [ "$DEV_ID" = "" ]; then
    DEV_ID="local/busterslim"
    fi


    echo -e "\n"
    read -p 'Enter  DEV_VERSION (eg: 5 ): ' DEV_VERSION

    if [ "$DEV_VERSION" = "" ]; then
    DEV_VERSION="7"
    fi

   DOCKER_IMAGE_TAG=$DEV_ID/dtelegram:4.5.3.$DEV_VERSION
fi


echo "DOCKER_IMAGE_TAG: "$DOCKER_IMAGE_TAG

# echo -e "\n"
# read -p 'Enter  DEV_LOC (eg: /home/ubbe/CodeBase/DockerGit/DailyLifeApps/telegram/dtelegram-t9/ ): ' DEV_LOC

# if [ "$DEV_LOC" = "" ]; then
#    DEV_LOC="/home/ubbe/CodeBase/DockerGit/DailyLifeApps/telegram/dtelegram-t9/"
# fi






echo -e "\n"
read -p '1 - intermediate removed & 2- not removing & 3 - skip: ' choice_intermediate_req

if [ $choice_intermediate_req == 1 ] || [ $choice_intermediate_req == 2  ] ; then

    echo "PLEASE SELECT Dockerfile:"
    choicesToShow=($( ls | grep "Dockerfile" ))
    source ./lib/select.sh 
    DOCKER_FILE=$mychoicefromsel
    unset mychoicefromsel

fi



if [ $choice_intermediate_req == 1 ]
then
    echo -e "\nBuilding container image without intermediate (unwanted) ..."
    docker build  \
        -f $DOCKER_FILE \
        --rm -t $DOCKER_IMAGE_TAG .

elif [ $choice_intermediate_req == 2 ]
then
    echo -e "\nBuilding container image with intermediate (fast) ..."
    docker build  \
        -f $DOCKER_FILE \
        -t $DOCKER_IMAGE_TAG .
else
   echo "None of the condition met for choice_intermediate_req"
fi


echo -e "\n"
read -p 'Enter  DOMAIN_CODE (eg: h3 ): ' DOMAIN_CODE

if [ "$DOMAIN_CODE" = "" ]; then
   DOMAIN_CODE="h3"
fi

SHORT_NAME=$(echo 'telegram-'$DOMAIN_CODE | sed -e 's/-/ /g' -e 's/\b\(.\)/\u\1/g' |tr -d ' ')
CONTAINER_NAME=$(echo 'telegram-'$DOMAIN_CODE | sed -e 's/-/ /g' -e 's/\b\(.\)/\u\1/g' |tr -d ' ')
mkdir -p ${HOME}/.$DOMAIN_CODE/.config/.TelegramDesktop


docker run --name $CONTAINER_NAME \
       --hostname=$(hostname) -u $(id -u):$(id -g) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$(whoami)/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${HOME}/.config/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       -t $DOCKER_IMAGE_TAG


echo -e "\n"
read -p 'Would you like to add a shortcut to Gnome Launcher? (Y/n): ' GL

if [ "$GL" = "Y" ] || [ "$GL" = "y" ] || [ "$GL" = "" ]; then
   echo -e "\nInstalling Gnome launcher shortcut...\n"
  
   if [ ! -d "$HOME/.local/share/icons/hicolor/512x512/apps" ]; then
      mkdir -p $HOME/.local/share/icons/hicolor/512x512/apps
   fi

   if [ ! -d "$HOME/.local/share/applications" ]; then
      mkdir -p $HOME/.local/share/applications
   fi
   
   if [ ! -d "$HOME/.local/bin" ]; then
      mkdir -p $HOME/.local/bin
   fi

   cp logo-400.png $HOME/.local/share/icons/hicolor/512x512/apps/
   sed 's|HOME|'$HOME'|g; s|SHORTNAME|'$SHORT_NAME'|g; s|APPNAME|'$CONTAINER_NAME'|g'  Telegram.desktop.skel > $CONTAINER_NAME.desktop
   mv $CONTAINER_NAME.desktop $HOME/.local/share/applications/


   sed 's|APPNAME|'$CONTAINER_NAME'|g'   dTelegram.skel > $CONTAINER_NAME
   mv $CONTAINER_NAME $HOME/.local/bin/

   



   echo -e "\n"
   read -p 'Would you like to change PERMISSION (do you have sudo access)? (Y/n): ' PERMISSION_INPUT

   if [ "$PERMISSION_INPUT" = "Y" ] || [ "$PERMISSION_INPUT" = "y" ] ; then

      sudo chown $USER:docker $HOME/.local/share/applications/$CONTAINER_NAME.desktop
      sudo chmod +x   $HOME/.local/share/applications/$CONTAINER_NAME.desktop

      sudo chown $USER:docker $HOME/.local/bin/$CONTAINER_NAME
      sudo chmod +x   $HOME/.local/bin/$CONTAINER_NAME
   else
      chmod +x   $HOME/.local/share/applications/$CONTAINER_NAME.desktop
      chmod +x   $HOME/.local/bin/$CONTAINER_NAME
   fi



   
elif [ "$GL" = "N" ] || [ "$GL" = "n" ]; then 
   echo -e "\nSkipping installation of Gnome launcher shortcut...\n"
else
   echo -e "\nUnrecognized input, skipping installation of Gnome launcher shortcut...\n"
fi

echo -e "\nDone... exiting...\n"