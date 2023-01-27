
export DOCKER_HOST=unix:///var/run/docker.sock





# docker-telegram

A Docker image that start a fresh telegram client.

[![Circle CI](https://circleci.com/gh/xorilog/docker-telegram.svg?style=shield)](https://circleci.com/gh/xorilog/docker-telegram)
[![Image Layers](https://images.microbadger.com/badges/image/xorilog/telegram.svg)](https://microbadger.com/images/xorilog/telegram)

## Usage

To spawn a new instance of Telegram:

### Linux


To Local build to validate

```shell
docker build -t "local-build/telegram:${version}" .
```
To MY Local build to validate


```shell
docker build --build-arg USER=$USER  --build-arg http_proxy="" --build-arg https_proxy=""  -t local-build/telegram:latest .
```




To run

```shell
docker run --rm -it --name telegram \
       --hostname=$(hostname) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$(whoami)/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v <Your_storage_dir>/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       xorilog/telegram
```

my command to run

```shell
docker run --rm -it --name telegram \
       --hostname=$(hostname) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$(whoami)/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v ~/Containers/dtelegram/home/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       local-build/telegram
       
       
       
       
       
       
docker run --rm -it --name telegram \
       --hostname=$(hostname) -u $(id -u):$(id -g) \
       -e DISPLAY=unix$DISPLAY \
       -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v "/home/$(whoami)/.Xauthority:/home/user/.Xauthority" \
       -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${HOME}/.config/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       xorilog/telegram:4.5.3
       

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
       xorilog/telegram:4.5.3       
       
```



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
       local-build/telegram:4.5.3.1     
       
```

### Mac Os

> Requires xquartz (`brew cask install xquartz` then reboot your computer & check in preferences>Security : Authenticate & Allow connections checkboxes)

```bash
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
docker run --rm -it --name telegram \
       -e DISPLAY=$(xhost + $(hostname) > /dev/null; echo $IP):0 \
       -v /etc/localtime:/etc/localtime:ro \
       -v <Your_storage_dir>/.TelegramDesktop:/home/user/.local/share/TelegramDesktop/ \
       xorilog/telegram
```

## systemd

### Adding the service

```bash
sudo curl -o /etc/systemd/system/telegram@.service "https://raw.githubusercontent.com/xorilog/docker-telegram/master/telegram%40.service"
sudo systemctl daemon-reload
```

### Adding custom parameters

* Add a file: `/etc/systemd/system/telegram@.service.d/proxy.conf` and replace the `<value>` with your parameters

```bash
[Service]
Environment="http_proxy=http://<proxy_name>:<proxy_port>"
Environment="https_proxy=http://<proxy_name>:<proxy_port>"
Environment="no_proxy=localhost,.lxd"
Environment=DNS=<DNS_IP>
```

* reload systemd `sudo systemctl daemon-reload`
* restart your service `sudo systemctl restart telegram@<your_username>.service`

### Activating for a user

```bash
sudo systemctl enable telegram@<your_username>.service
sudo systemctl start telegram@<your_username>.service
```




### Addon for fix



```bash
if test -z "${XDG_RUNTIME_DIR}"; then export 
XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
if ! test -d "${XDG_RUNTIME_DIR}"; then mkdir 
"${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"
```




## Issues

* You have to log out Telegram to close the docker container.
* You have to create your storage directory before start using `mkdir <Your_storage_dir>` as the one created by docker is owned by root user.

## FAQ

### Docker image registry

Images are available in the following registries:

* [Docker](https://hub.docker.com/r/xorilog/telegram): `xorilog/telegram`
* [GitHub Packages](https://github.com/xorilog/docker-telegram/packages/26101): `docker.pkg.github.com/xorilog/docker-telegram/telegram`
* [GitHub Container Registry](https://github.com/users/xorilog/packages/container/package/telegram): `ghcr.io/xorilog/telegram`

### Docker <1.8

Before Docker 1.8 you need to replace `--device /dev/snd` by `-v /dev/snd:/dev/snd --privileged`.

### QXcbConnection: Could not connect to display unix:0

>This is old but keeping it for older users

```shell
xhost +
setenforce 0 (optional, if `xhost +` is not enough: put SELinux in permissive mode)
```

Do not forget to remove it after start or usage (`xhost -`, setenforce 1).

The previous command is to be run on a linux machine. But, Mac users I have a special surprise for you. You can also do fun hacks with X11. Details are described [here](https://github.com/docker/docker/issues/8710).
[This may be more convenient to read](https://gist.github.com/netgusto/931085fc3673b69dd15a1763784307c5)

Thanks to [Telegram](https://telegram.org/) for their great app !
