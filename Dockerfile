FROM debian:11-slim
RUN apt-get update &&  \
    apt-get install -y \
        clang          \
        curl           \
        git            \
        nodejs &&      \
    apt-get clean &&   \
    rm -rf /var/lib/apt/
ARG NVIM_VERSION=0.8.1
RUN curl -Lo nvim.deb                                                                 \
        https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && \
    apt-get install ./nvim.deb &&                                                     \
    rm -f nvim.deb
RUN useradd -m -s "$SHELL" nvimuser
USER nvimuser
WORKDIR /home/nvimuser
COPY --chown=nvimuser:nvimuser .config /home/nvimuser/.config/
RUN nvim --headless                              \
        -c 'autocmd User PackerComplete quitall' \
        -c 'PackerCompile | PackerSync'
CMD ["nvim"]
