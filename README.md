# vscode-nvim

try to have a vscode-like with neovim config

![current-nvim](/assets/current-nvim.png)

# Features

- right click show some lsp actions

- minimap

- autocompletion (with lsp (+ tabnine))

- tab resizable with mouse (neovim default)

- ctrl+click show lsp reference

- command palette with ctrl+p

# Install

```bash
# Completions requirements
## for python completion:
npm install -g pyright
## for javascript/typescript/tsx/jsx completion:
npm install -g typescript typescript-language-server
## for c/c++ completion:
apt install clangd
pacman -S clang
## for bash
npm install -g bash-language-server
# Minimap requirements
# -> https://github.com/wfxr/code-minimap/releases
## for debian and derivates
curl -Lo code-minimap.deb 'https://github.com/wfxr/code-minimap/releases/download/v0.6.4/code-minimap-musl_0.6.4_amd64.deb'
apt install ./code-minimap.deb
## for arch using aur
[yay|paru] -S code-minimap
## for arch with binary
curl -Lo code-minimap.tar.gz 'https://github.com/wfxr/code-minimap/releases/download/v0.6.4/code-minimap-v0.6.4-aarch64-unknown-linux-gnu.tar.gz'
tar xf code-minimap.tar.gz
mv code-minimap-v0.6.4-aarch64-unknown-linux-gnu/code-minimap /usr/local/bin/code-minimap
# tabnine:
apt install unzip curl
pacman -S unzip curl
# ripgrep
## https://github.com/BurntSushi/ripgrep#installation
# make
apt install make
pacman -S make
```

- After that, you can move the `./.config/nvim` to your `$HOME/.config/nvim`

# Remainder of some commands

- test it without affect current settings

```bash
# docker build . -t saverio976/vscode-nvim:latest
docker run -it --rm saverio976/vscode-nvim
```

# Links

- https://hub.docker.com/r/saverio976/vscode-nvim

- https://git.kreog.com/Saverio976/vscode-nvim

# Plugins

- wbthomason/packer.nvim

- lewis6991/impatient.nvim

- nathom/filetype.nvim

- Mofiqul/vscode.nvim

- nvim-lualine/lualine.nvim

- nvim-lualine/lualine.nvim

- nvim-tree/nvim-tree.lua
    - nvim-tree/nvim-web-devicons

- wfxr/minimap.vim

- kevinhwang91/nvim-ufo
    - kevinhwang91/promise-async

- norcalli/nvim-colorizer.lua

- lukas-reineke/indent-blankline.nvim

- lewis6991/gitsigns.nvim

- p00f/nvim-ts-rainbow

- f-person/git-blame.nvim

- nvim-treesitter/nvim-treesitter

- folke/noice.nvim
    - MunifTanjim/nui.nvim

- voldikss/vim-floaterm

- neovim/nvim-lspconfig

- onsails/lspkind-nvim

- folke/trouble.nvim

- j-hui/fidget.nvim

- kosayoda/nvim-lightbulb

- rmagatti/goto-preview

- glepnir/lspsaga.nvim

- hrsh7th/nvim-cmp
    - hrsh7th/cmp-nvim-lsp
    - hrsh7th/cmp-nvim-lsp-signature-help
    - lukas-reineke/cmp-rg
    - hrsh7th/cmp-path
    - hrsh7th/cmp-path
    - lukas-reineke/cmp-under-comparator
    - saadparwaiz1/cmp_luasnip
    - hrsh7th/cmp-buffer
    - hrsh7th/cmp-cmdline
    - tzachar/cmp-tabnine

- L3MON4D3/LuaSnip
    - rafamadriz/friendly-snippets

- windwp/nvim-autopairs

- folke/which-key.nvim

- RishabhRD/nvim-cheat.sh
    - RishabhRD/popfix

- numToStr/Comment.nvim

- nvim-telescope/telescope.nvim
    - nvim-telescope/telescope-fzf-native.nvim
    - nvim-lua/plenary.nvim
    - LinArcX/telescope-command-palette.nvim
