require ("mason-nvim-dap").setup({
    ensure_installed = {"delve", "go-debug-adaper"},
    handlers = {}, -- sets up dap in the predefined manner
    automatic_installation = true,
})
