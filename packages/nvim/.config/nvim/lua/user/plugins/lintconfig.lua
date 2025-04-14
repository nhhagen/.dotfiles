local lint = require('lint')

lint.linters_by_ft = {
  docker = { "hadolint" },
  go = { "golangcilint" },
  json = { "jsonlint" },
  markdown = { "vale" },
  proto = { "buf" },
  terraform = { "tflint" },
  yaml = { "yamllint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>l",
  function()
    lint.try_lint()
  end,
  { desc = "Trigger linting for current file" }
)
