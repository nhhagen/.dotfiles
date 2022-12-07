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
  use('editorconfig/editorconfig-vim')
  use('roman/golden-ratio')
  -- use('sheerun/vim-polyglot')
  use('sjl/vitality.vim')
  use('tmux-plugins/vim-tmux')
  use('tpope/vim-commentary')
  use('tpope/vim-dispatch')
  use('tpope/vim-fugitive')
  use('tpope/vim-surround')
  use('wbthomason/packer.nvim')

  -- use {
  --   'yamatsum/nvim-nonicons',
  --   requires = {'kyazdani42/nvim-web-devicons'},
  --   config = function()
  --     require('nvim-nonicons').setup {}
  --   end
  -- }

  use({
    'airblade/vim-gitgutter',
    config = function()
      require('plugins.gitgutter')
    end,
  })

  use({
    'RRethy/nvim-base16',
    config = function()
      require('plugins.base16')
    end,
  })

  use({
    'kannokanno/previm',
    config = function()
       vim.g.previm_open_cmd = "open -a 'Google Chrome'"
    end,
  })

  use({
    'vim-airline/vim-airline',
    requires = {
      { 'vim-airline/vim-airline-themes' },
    },
    config = function()
      require('plugins.airline')
    end,
  })

  use({
    'nathanaelkane/vim-indent-guides',
    config = function()
      require('plugins.vimindentguides')
    end,
  })

  use({
    'Raimondi/delimitMate',
    config = function()
      require('plugins.delimate')
    end,
  })

  use({
    'dense-analysis/ale',
    config = function()
      require('plugins.ale')
    end,
  })

  use({
    'plasticboy/vim-markdown',
    requires = {
      { 'godlygeek/tabular' },
    },
    config = function()
      require('plugins.markdown')
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'RRethy/nvim-base16' },
      { 'nvim-lua/plenary.nvim' },
      -- { 'yamatsum/nvim-nonicons' },
      -- { 'kyazdani42/nvim-web-devicons' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function()
      require('plugins.telescope')
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('plugins.treesitter')
    end,
  })

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
