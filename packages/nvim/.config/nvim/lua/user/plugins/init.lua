return {
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "L3MON4D3/LuaSnip" },
  { "MunifTanjim/nui.nvim" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-path" },
  { "mfussenegger/nvim-dap" },
  { "nvim-lua/plenary.nvim" },
  { "onsails/lspkind-nvim" },
  { "rcarriga/nvim-notify" },
  { "saadparwaiz1/cmp_luasnip" },
  { "sjl/vitality.vim" },
  { "stevearc/dressing.nvim" },
  { "tmux-plugins/vim-tmux" },
  { "tpope/vim-commentary" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  {
    "kannokanno/previm",
    config = function()
       vim.g.previm_open_cmd = 'open -a "Google Chrome"'
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
