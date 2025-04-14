-- require("mason").setup()
vim.lsp.set_log_level("off")

require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local keymap = vim.keymap -- for conciseness
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- set keybinds
  bufopts.desc = "Show LSP references"
  keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", bufopts) -- show definition, references

  bufopts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- go to declaration

  bufopts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts) -- show lsp definitions

  bufopts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts) -- show lsp implementations

  bufopts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", bufopts) -- show lsp type definitions

  bufopts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts) -- see available code actions, in visual mode will apply to selection

  bufopts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts) -- smart rename

  bufopts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", bufopts) -- show  diagnostics for file

  bufopts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts) -- show diagnostics for line

  bufopts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts) -- jump to previous diagnostic in buffer

  bufopts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts) -- jump to next diagnostic in buffer

  bufopts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- show documentation for what is under cursor

  bufopts.desc = "Restart LSP"
  keymap.set("n", "<leader>rs", ":LspRestart<CR>", bufopts) -- mapping to restart lsp if necessary
  -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup{
      capabilities = capabilities,
      on_attach = on_attach,
      flags = lsp_flags,
    }
  end,

  ["lua_ls"] = function()
    require("lspconfig")["lua_ls"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = lsp_flags,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }
  end,

  ["pyright"] = function()
    require("lspconfig")["pyright"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = lsp_flags,
      on_new_config = function(config, root_dir)
        local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
        if string.len(env) > 0 then
          config.settings.python.pythonPath = env .. '/bin/python'
        end
      end
    }
  end
}

mason_lspconfig.setup({
  ensure_installed = {
    "buf_ls",
    "dockerls",
    "gopls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "terraformls",
    "ts_ls",
    "yamlls",
  },
  automatic_installation = true,
  handlers = handlers,
})

