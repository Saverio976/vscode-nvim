FROM node:slim
RUN apt-get update &&  \
    apt-get install -y \
        clang          \
        curl           \
        unzip          \
        make           \
        git &&         \
    apt-get clean &&   \
    rm -rf /var/lib/apt/
ARG NVIM_VERSION=0.8.1
RUN curl -Lo nvim.deb                                                                   \
        "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb" && \
    apt-get install ./nvim.deb &&                                                       \
    rm -f nvim.deb
RUN curl -Lo code-minimap.deb                                                                                \
        "https://github.com/wfxr/code-minimap/releases/download/v0.6.4/code-minimap-musl_0.6.4_amd64.deb" && \
    apt-get install ./code-minimap.deb &&                                                                    \
    rm -f code-minimap.deb
RUN curl -Lo ripgrep.deb                                                                             \
        "https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb" && \
    apt-get install ./ripgrep.deb &&                                                                 \
    rm -f ripgrep.deb
RUN apt-get clean &&      \
    rm -rf /var/lib/apt/
RUN useradd -m -s "$SHELL" nvimuser
RUN npm install -g pyright typescript typescript-language-server && \
    npm cache clean --force
USER nvimuser
WORKDIR /home/nvimuser
COPY --chown=nvimuser:nvimuser .config /home/nvimuser/.config/
RUN nvim --headless                              \
        -c 'autocmd User PackerComplete quitall' \
        -c 'PackerCompile | PackerSync' &&       \
    nvim --headless                              \
        -c 'TSUpdate | quitall' &&               \
    nvim --headless                              \
        -c 'quitall'
CMD nvim; bash
