
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
docker run --name telegram \
       --hostname=$(hostname) -u $(id -u):$(id -g) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$ME/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${HOME}/.config/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       -t local/busterslim/telegram:4.5.3.4     
       
```

COMMENT :
Container created successfully


###  My Local Build for Buster Slim   SubVersion as 5:
Previous  Commit  (`git log --oneline -1`) : buster 00c2b0435dbd517e76ac85fa90b1441e605e82ee

```shell
docker build  -f /home/ubbe/CodeBase/DockerGit/DailyLifeApps/telegram/dtelegram-t9/variant/debian-buster/Dockerfile -t "local/buster/telegram:4.5.3.5" .

export HOME=/home/ubbe
export ME=ubbe
docker run --name telegram5 \
       --hostname=$(hostname) -u $(id -u):$(id -g) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$ME/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${HOME}/.config/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       -t local/buster/telegram:4.5.3.5     
       
```

COMMENT :
Container created successfully

