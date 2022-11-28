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
COPY ./.config /home/nvimuser/.config
RUN mkdir -p /home/nvimuser/.local
RUN chown -R nvimuser:nvimuser /home/nvimuser
COPY ./post-install-nvim.sh /tmp/post-install-nvim
RUN chmod +x /tmp/post-install-nvim
RUN chown nvimuser:nvimuser /tmp/post-install-nvim
WORKDIR /home/nvimuser
USER nvimuser
CMD id && /tmp/post-install-nvim && echo && /bin/bash
