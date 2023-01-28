# Gathering of binary
##FROM ubuntu:14.04-slim as downloader
#FROM Alpine:latest as downloader
FROM ubuntu:14.04 as downloader


ARG telegram_version=""
ARG http_proxy=""
ARG https_proxy=""



RUN apt-get update && apt-get install -y \
    apt-utils \
    software-properties-common \
    wget \
    xz-utils \
    curl \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Telegram Version 4.5.3
RUN env \
      http_proxy=$http_proxy \
      https_proxy=$https_proxy \
      wget https://updates.tdesktop.com/tlinux/tsetup."${telegram_version:-$(curl \
        -sXGET \
        --head https://telegram.org/dl/desktop/linux \
        | grep location \
        | cut -d '/' -f 5 \
        |cut -d '.' -f 2-4 \
      )}".tar.xz \
      -O /tmp/telegram.tar.xz \
    && cd /tmp/ \
    && tar xvfJ /tmp/telegram.tar.xz \
    && mv /tmp/Telegram/Telegram /usr/bin/Telegram \
    && rm -rf /tmp/{telegram.tar.xz,Telegram}




















# Base docker image
FROM ubuntu:14.04
LABEL maintainer "Christophe Boucharlat <christophe.boucharlat@gmail.com>"
LABEL org.opencontainers.image.source https://github.com/xorilog/docker-telegram

# Make a user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \
	&& usermod -a -G audio,video user

ARG http_proxy=""
ARG https_proxy=""

RUN apt-get update && apt-get install -y build-essential
RUN apt-get --purge remove -y nvidia*
ADD ./Downloads/nvidia_installers /tmp/nvidia                             > Get the install files you used to install CUDA and the NVIDIA drivers on your host
RUN /tmp/nvidia/NVIDIA-Linux-x86_64-331.62.run -s -N --no-kernel-module   > Install the driver.
RUN rm -rf /tmp/selfgz7                                                   > For some reason the driver installer left temp files when used during a docker build (i don't have any explanation why) and the CUDA installer will fail if there still there so we delete them.
RUN /tmp/nvidia/cuda-linux64-rel-6.0.37-18176142.run -noprompt            > CUDA driver installer.
RUN /tmp/nvidia/cuda-samples-linux-6.0.37-18176142.run -noprompt -cudaprefix=/usr/local/cuda-6.0   > CUDA samples comment if you don't want them.
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64         > Add CUDA library into your PATH
RUN touch /etc/ld.so.conf.d/cuda.conf                                     > Update the ld.so.conf.d directory
RUN rm -rf /temp/*  > Delete installer files.



# Install required deps
RUN apt-get update && apt-get install -y \
    apt-utils \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    libpulse0 \
    gconf2 \
    libdrm2 \
    libgtk-3-0 \
    libice6 \
    libsm6 \
    libegl1-mesa-dev \
    libgl1-mesa-glx \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=downloader --chown=user /usr/bin/Telegram /home/user/Telegram

WORKDIR $HOME
USER user

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

# Autorun Telegram
CMD ["/home/user/Telegram"]
