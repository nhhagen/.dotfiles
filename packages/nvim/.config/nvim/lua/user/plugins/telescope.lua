return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "RRethy/nvim-base16" },
    { "nvim-lua/plenary.nvim" },
    -- { "yamatsum/nvim-nonicons" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "nvim-treesitter/nvim-treesitter" }
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")
    -- local icons = require("nvim-nonicons")

    -- vim.cmd([[
    --   highlight link TelescopePromptTitle PMenuSel
    --   highlight link TelescopePreviewTitle PMenuSel
    --   highlight link TelescopePromptNormal NormalFloat
    --   highlight link TelescopePromptBorder FloatBorder
    --   highlight link TelescopeNormal CursorLine
    --   highlight link TelescopeBorder CursorLineBg
    -- ]])

    telescope.setup({
      defaults = {
        path_display = { truncate = 1 },
        -- prompt_prefix = "  " .. icons.get("telescope") .. "  ",
        prompt_prefix = " ❯ ",
        selection_caret = " ❯ ",
        entry_prefix = "   ",
        layout_config = {
          prompt_position = "top",
          -- layout_strategy = 'flex',
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
        file_ignore_patterns = { ".git/" },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          previewer = false,
          layout_config = {
            width = 80,
          },
        },
        oldfiles = {
          prompt_title = "History",
        },
        lsp_references = {
          previewer = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          themes.get_dropdown {
            -- even more opts
          }
        }
      }
    })


    -- vim.keymap.set("n", "<C-f>", function telescope.builtin.find_files() end)
    vim.keymap.set("n", "<leader>f", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
    vim.keymap.set("n", "<leader>F", function() require("telescope.builtin").find_files({ no_ignore = true, prompt_title = "All Files" }) end, { desc = "Find all files" }) -- luacheck: no max line length
    vim.keymap.set("n", "<leader>b", function() require("telescope.builtin").buffers() end, { desc = "Find buffer" })
    vim.keymap.set("n", "<leader>g", function() require("telescope").extensions.live_grep_args.live_grep_args() end, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>h", function() require("telescope.builtin").oldfiles() end, { desc = "Find in history" })
    vim.keymap.set("n", "<leader>s", function() require("telescope.builtin").lsp_document_symbols() end, { desc = "Find symbols" })
  end,
}
