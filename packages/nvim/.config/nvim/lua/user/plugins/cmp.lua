return {
  "hrsh7th/nvim-cmp",
  dependencies = {
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
    local lspkind = require("lspkind")
    local cmp = require "cmp"

    -- lspkind.init({ mode = "symbol_text", preset="default" })

    cmp.setup {
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { "i", "c" }
        ),
        ["<M-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          { "i", "c" }
        ),

        ["<c-space>"] = cmp.mapping {
          i = cmp.mapping.complete(),
          c = function(
            _ --[[fallback]]
          )
            if cmp.visible() then
              if not cmp.confirm { select = true } then
                return
              end
            else
              cmp.complete()
            end
          end,
        },

        -- ["<tab>"] = false,
        ["<tab>"] = cmp.config.disable,

        -- ["<tab>"] = cmp.mapping {
        --   i = cmp.config.disable,
        --   c = function(fallback)
        --     fallback()
        --   end,
        -- },

        -- Testing
        ["<C-q>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },

        -- If you want tab completion :'(
        --  First you have to just promise to read `:help ins-completion`.
        --
        -- ["<Tab>"] = function(fallback)
        --   if cmp.visible() then
        --     cmp.select_next_item()
        --   else
        --     fallback()
        --   end
        -- end,
        -- ["<S-Tab>"] = function(fallback)
        --   if cmp.visible() then
        --     cmp.select_prev_item()
        --   else
        --     fallback()
        --   end
        -- end,
      },

      -- Youtube:
      --    the order of your sources matter (by default). That gives them priority
      --    you can configure:
      --        keyword_length
      --        priority
      --        max_item_count
      --        (more?)
      sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        -- { name = "copilot" },
      }, {
          { name = "path" },
          { name = "buffer", keyword_length = 5 },
        }, {
          { name = "gh_issues" },
        }),

      sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,

          -- copied from cmp-under, but I don't think I need the plugin for this.
          -- I might add some more of my own.
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find "^_+"
            local _, entry2_under = entry2.completion_item.label:find "^_+"
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,

          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      view = {
        entries = "custom",
        docs = {
          auto_open = true
        }
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
            gh_issues = "[issues]",
            tn = "[TabNine]",
          },
        }),
      },

      experimental = {
        ghost_text = true,
      },
    }

    -- cmp.setup.cmdline("/", {
    --   completion = {
    --     -- Might allow this later, but I don't like it right now really.
    --     -- Although, perhaps if it just triggers w/ @ then we could.
    --     --
    --     -- I will have to come back to this.
    --     autocomplete = false,
    --   },
    --   sources = cmp.config.sources({
    --     { name = "nvim_lsp_document_symbol" },
    --   }, {
    --     -- { name = "buffer", keyword_length = 5 },
    --   }),
    -- })

    -- cmp.setup.cmdline(":", {
    --   completion = {
    --     autocomplete = false,
    --   },
    --
    --   sources = cmp.config.sources({
    --     {
    --       name = "path",
    --     },
    --   }, {
    --     {
    --       name = "cmdline",
    --       max_item_count = 20,
    --       keyword_length = 4,
    --     },
    --   }),
    -- })

    --[[
      " Setup buffer configuration (nvim-lua source only enables in Lua filetype).
      "
      " ON YOUTUBE I SAID: This only _adds_ sources for a filetype, not removes the global ones.
      "
      " BUT I WAS WRONG! This will override the global setup. Sorry for any confusion.
      autocmd FileType lua lua require'cmp'.setup.buffer {
      \   sources = {
      \     { name = 'nvim_lua' },
      \     { name = 'buffer' },
      \   },
      \ }
      --]]

    -- Add vim-dadbod-completion in sql files
    _ = vim.cmd [[
        augroup DadbodSql
        au!
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
        augroup END
        ]]

    _ = vim.cmd [[
        augroup CmpZsh
        au!
        autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
        augroup END
        ]]

    --[[
      " Disable cmp for a buffer
      autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
      --]]

    -- Youtube: customizing appearance
    --
    -- nvim-cmp highlight groups.
    -- local Group = require("colorbuddy.group").Group
    -- local g = require("colorbuddy.group").groups
    -- local s = require("colorbuddy.style").styles
    --
    -- Group.new("CmpItemAbbr", g.Comment)
    -- Group.new("CmpItemAbbrDeprecated", g.Error)
    -- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
    -- Group.new("CmpItemKind", g.Special)
    -- Group.new("CmpItemMenu", g.NonText)
  end
}
