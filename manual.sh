





##################  Try 1


export HOME=/home/ubbe
export ME=ubbe
docker run --rm -it --name telegram \
       --hostname=$(hostname) -u $(id -u):$(id -g) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$ME/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${HOME}/.config/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       local-build/telegram:4.5.3.buster3     


##################  Try 2

DOMAIN_CODE=t91
CONTAINER_NAME="TelegramT91"
DOCKER_IMAGE_TAG="local/busterslim/dtelegram:4.5.3.5"
##"/home/ubbe/.t91/.config/.TelegramDesktop"

docker run --rm -it --name $CONTAINER_NAME \
       --hostname=$(hostname) \
       -u $(id -u):$(id -g) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$(whoami)/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v "${HOME}/.$DOMAIN_CODE/.config/.TelegramDesktop":"/home/user/.local/share/TelegramDesktop/" \
        $DOCKER_IMAGE_TAG
        
        



       