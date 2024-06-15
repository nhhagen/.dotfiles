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

  use("MunifTanjim/nui.nvim")
  use("rcarriga/nvim-notify")
  use({
    "folke/noice.nvim",
    requires = {
      "rcarriga/nvim-notify",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("user.plugins.noice")
    end
  })

  -- use("roman/golden-ratio")
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
  --     "nvim-tree/nvim-web-devicons"
  --   },
  -- }

  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  })

  use({
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("user.plugins.lspconfig")
    end
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "nvim-lua/plenary.nvim",
      "L3MON4D3/LuaSnip",
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
    "lewis6991/gitsigns.nvim",
    config = function()
      require("user.plugins.gitsigns")
    end
  })

  use({
    "RRethy/nvim-base16",
    -- commit = "3c6a56016cea7b892f1d5b9b5b4388c0f71985be",
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
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("user.plugins.lualine")
    end
  })

  use({
    "kdheepak/tabline.nvim",
    requires = {
      { "hoob3rt/lualine.nvim", opt=true },
      {"nvim-tree/nvim-web-devicons", opt = true},
    },
    config = function()
      require("user.plugins.tabline")
    end
  })

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
    "nvim-tree/nvim-web-devicons",
    -- commit = "313d9e7193354c5de7cdb1724f9e2d3f442780b0",
    config = function()
      require("nvim-web-devicons")
    end
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "RRethy/nvim-base16" },
      { "nvim-lua/plenary.nvim" },
      -- { "yamatsum/nvim-nonicons" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require("user.plugins.telescope")
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("user.plugins.treesitter")
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })


  use({
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })

  use ({"JoosepAlviste/nvim-ts-context-commentstring"})

  use ({"stevearc/dressing.nvim"})

  use({ "mfussenegger/nvim-dap" })
  use({
    "jay-babu/mason-nvim-dap.nvim",
    after = "mason.nvim",
    requires = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("user.plugins.mason_nvim_dap")
    end
  })
  use({
    "theHamsta/nvim-dap-virtual-text",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  })
  use({
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    requires = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("user.plugins.dapui")
    end
  })
  use({
    "folke/neodev.nvim",
    config = function()
      require("user.plugins.neodev")
    end
  })
  use({
    "leoluz/nvim-dap-go",
    requires = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-go").setup()
    end
  })

  --- use({
  ---   "ldelossa/gh.nvim",
  ---   requires = { { "ldelossa/litee.nvim" } },
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
