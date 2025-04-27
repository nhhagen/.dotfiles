return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require('gitsigns')
    gitsigns.setup()

    vim.keymap.set("n", "<leader>gp", function() gitsigns.preview_hunk() end, { desc = "Git: Preview hunk", silent = true })
    vim.keymap.set("n", "<leader>gb", function() gitsigns.toggle_current_line_blame() end, { desc = "Git: Toggle current line blame", silent = true })
  end
}
