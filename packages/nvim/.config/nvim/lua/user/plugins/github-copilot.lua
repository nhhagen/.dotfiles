return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_filetypes = {
        ["TelescopePrompt"] = false,
      }
       -- Set to true to assume that copilot is already mapped
      vim.g.copilot_assume_mapped = true
      -- Set workspace folders
      vim.g.copilot_workspace_folders = "~/repos"
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {},
  }
}
