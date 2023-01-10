local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use("gpanders/editorconfig.nvim")
  --use("editorconfig/editorconfig-vim")
  use("roman/golden-ratio")
  -- use("sheerun/vim-polyglot")
  use("sjl/vitality.vim")
  use("tmux-plugins/vim-tmux")
  use("tpope/vim-commentary")
  use("tpope/vim-dispatch")
  use("tpope/vim-fugitive")
  use("tpope/vim-surround")

  -- use {
  --   "yamatsum/nvim-nonicons",
  --   requires = {
  --     "kyazdani42/nvim-web-devicons"
  --   },
  -- }

  use({
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      require("user.plugins.lspconfig")
    end
  })

  use({
    "williamboman/mason-lspconfig.nvim",
    requires = {
      "williamboman/mason.nvim"
    },
    config = function()
      require("user.plugins.lspconfig")
    end
  })

  use({
    "williamboman/mason.nvim",
    config = function()
      require("user.plugins.mason")
    end
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "nvim-lua/plenary.nvim",
      {"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"},
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
    config = function()
      require("user.plugins.cmp")
    end
  })


  use({
    "airblade/vim-gitgutter",
    config = function()
      require("user.plugins.gitgutter")
    end,
  })

  use({
    "RRethy/nvim-base16",
    config = function()
      require("user.plugins.base16")
    end,
  })

  use({
    "kannokanno/previm",
    config = function()
       vim.g.previm_open_cmd = 'open -a "Google Chrome"'
    end,
  })

  use({
    'nvim-lualine/lualine.nvim',
    -- requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("user.plugins.lualine")
    end
  })

  use({
    'kdheepak/tabline.nvim',
    requires = {
      { 'hoob3rt/lualine.nvim', opt=true },
      -- {'kyazdani42/nvim-web-devicons', opt = true}
    },
    config = function()
      require("user.plugins.tabline")
    end
  })

  -- use({
  --   "vim-airline/vim-airline",
  --   requires = {
  --     { "vim-airline/vim-airline-themes" },
  --   },
  --   config = function()
  --     require("user.plugins.airline")
  --   end,
  -- })

  use({
    "nathanaelkane/vim-indent-guides",
    config = function()
      require("user.plugins.vimindentguides")
    end,
  })

  use({
    "Raimondi/delimitMate",
    config = function()
      require("user.plugins.delimate")
    end,
  })

  -- use({
  --   "dense-analysis/ale",
  --   config = function()
  --     require("user.plugins.ale")
  --   end,
  -- })

  use({
    "plasticboy/vim-markdown",
    requires = {
      { "godlygeek/tabular" },
    },
    config = function()
      require("user.plugins.markdown")
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "RRethy/nvim-base16" },
      { "nvim-lua/plenary.nvim" },
      -- { "yamatsum/nvim-nonicons" },
      { "kyazdani42/nvim-web-devicons" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      require("user.plugins.telescope")
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("user.plugins.treesitter")
    end,
  })

  --- use({
  ---   'ldelossa/gh.nvim',
  ---   requires = { { 'ldelossa/litee.nvim' } },
  ---   config = function()
  ---     require("user.plugins.gh")
  ---   end
  --- })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
