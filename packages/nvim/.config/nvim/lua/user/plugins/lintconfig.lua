return {
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    dependencies = { "mason.nvim" },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        docker = { "hadolint" },
        go = { "golangcilint" },
        json = { "jsonlint" },
        lua = { "selene" },
        markdown = { "vale" },
        proto = { "buf" },
        terraform = { "tflint" },
        yaml = { "yamllint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l",
        function()
          lint.try_lint()
        end, { desc = "Trigger linting for current file" }
      )
    end
  },

  {
    "rshkarin/mason-nvim-lint",
    dependencies = { "nvim-lint" },
    config = function()
      require("mason-nvim-lint").setup()
    end
  }
}
