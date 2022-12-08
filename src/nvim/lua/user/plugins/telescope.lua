local telescope = require("telescope")
local actions = require("telescope.actions")
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
      previewer = false,
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
          -- even more opts
      }
    }
  }
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("live_grep_args")

-- vim.keymap.set("n", "<C-f>", [[<cmd>lua require("telescope.builtin").find_files()<CR>]])
vim.keymap.set("n", "<leader>f", [[<cmd>lua require("telescope.builtin").find_files()<CR>]])
vim.keymap.set("n", "<leader>F", [[<cmd>lua require("telescope.builtin").find_files({ no_ignore = true, prompt_title = "All Files" })<CR>]]) -- luacheck: no max line length
vim.keymap.set("n", "<leader>b", [[<cmd>lua require("telescope.builtin").buffers()<CR>]])
vim.keymap.set("n", "<leader>g", [[<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>]])
vim.keymap.set("n", "<leader>h", [[<cmd>lua require("telescope.builtin").oldfiles()<CR>]])
vim.keymap.set("n", "<leader>s", [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]])
