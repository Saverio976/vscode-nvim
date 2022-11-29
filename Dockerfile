FROM debian:stable-slim
RUN apt-get update &&  \
    apt-get install -y \
        clang          \
        curl           \
        git            \
        nodejs &&      \
    apt-get clean &&   \
    rm -rf /var/lib/apt/
ARG NVIM_VERSION=0.8.1
RUN curl -Lo nvim.deb \
        "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb" && \
    apt-get install ./nvim.deb && \
    rm -f nvim.deb
RUN curl -Lo code-minimap.deb \
        "https://github.com/wfxr/code-minimap/releases/download/v0.6.4/code-minimap-musl_0.6.4_amd64.deb" && \
    apt-get install ./code-minimap.deb && \
    rm -f code-minimap.deb
RUN useradd -m -s "$SHELL" nvimuser
USER nvimuser
WORKDIR /home/nvimuser
COPY --chown=nvimuser:nvimuser .config /home/nvimuser/.config/
RUN nvim --headless \
        -c 'autocmd User PackerComplete quitall' \
        -c 'PackerCompile | PackerSync'
CMD nvim; bash
