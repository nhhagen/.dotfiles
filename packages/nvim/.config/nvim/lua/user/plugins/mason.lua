return {
  "williamboman/mason.nvim",
  config = function()
    -- import mason
    local mason = require("mason")

    -- enable mason and configure icons
    mason.setup()
  end,
}
