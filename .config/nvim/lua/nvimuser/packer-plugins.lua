-- package manager
-- https://github.com/wbthomason/packer.nvim

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'lewis6991/impatient.nvim' }
  use { 'nathom/filetype.nvim' }

  -- lua/nvimuser/theme.lua
  use { 'Mofiqul/vscode.nvim' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'akinsho/bufferline.nvim' }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  use { 'wfxr/minimap.vim' }
  use {
    'kevinhwang91/nvim-ufo',
    requires = {
      'kevinhwang91/promise-async',
    },
  }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'tveskag/nvim-blame-line' }

  -- lua/nvimuser/terminal.lua
  use { 'voldikss/vim-floaterm' }

  -- lua/nvimuser/lsp.lua
  use { 'neovim/nvim-lspconfig' }
  use { 'onsails/lspkind-nvim' }
  use { 'folke/trouble.nvim' }
  use { 'j-hui/fidget.nvim' }
  use { 'kosayoda/nvim-lightbulb' }

  -- lua/nvimuser/autocompletion.lua
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'lukas-reineke/cmp-rg',
      'hrsh7th/cmp-path',
      'lukas-reineke/cmp-under-comparator',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
    },
  }
  use {
    'tzachar/cmp-tabnine',
    after = "nvim-cmp",
    run = './install.sh',
    requires = {
      'hrsh7th/nvim-cmp'
    }
  }
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      'rafamadriz/friendly-snippets',
    },
  }
  -- use { '' } -- auto pairs
  use { 'folke/which-key.nvim' }
  use {
    'RishabhRD/nvim-cheat.sh',
    requires = {
      'RishabhRD/popfix'
    },
  }
  use { 'gelguy/wilder.nvim' }

  -- code comments (lua/nvimuser/commands.lua)
  use { 'numToStr/Comment.nvim' }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'Darazaki/indent-o-matic' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
