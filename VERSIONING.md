
### Old Local build



```shell
docker build -t "local-build/telegram:4.5.3.1" .

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
       local-build/telegram:4.5.1     
       
```

COMMENT :
Working only one time. Container missing.showing gui error


###  My Local Build for Buster Slim   SubVersion as 4:
Previous  Commit  (`git log --oneline -1`) : 53a09bf (HEAD -> main, origin/main, origin/HEAD) Braved Stable version 0.0.2

```shell
docker build -t "local/busterslim/telegram:4.5.3.4" .

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
       local/busterslim/telegram:4.5.3.4     
       
```

COMMENT :
Working only one time. Container missing.showing gui error


