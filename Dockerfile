FROM debian:stable-slim

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install curl git clang nodejs -y && \
    apt-get autoremove -y && \
    apt-get clean -y
ARG NVIM_VERSION=0.8.1
RUN curl -Lo /tmp/nvim.deb \
    "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb"
RUN apt-get install /tmp/nvim.deb
RUN adduser \
        --system \
        --shell /bin/bash \
        --gecos 'User of vscode-nvim' \
        --group \
        --disabled-password \
        --home /home/nvimuser \
        nvimuser
COPY --chown=nvimuser:nvimuser ./.config /home/nvimuser/.config
COPY ./post-install-nvim.sh /tmp/post-install-nvim
WORKDIR /home/nvimuser
USER nvimuser
CMD echo "start install" && bash /tmp/post-install-nvim && nvim
