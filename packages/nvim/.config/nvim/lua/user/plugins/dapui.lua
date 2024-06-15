require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set("n", "<leader>dt", function() dapui.toggle() end, { desc = "Debug: Toggle UI", noremap = true, silent = true })
vim.keymap.set("n", "<leader>dr", function() dapui.open({reset = true}) end, { desc = "Debug: Reset UI", noremap = true, silent = true})
vim.keymap.set("n", "<leader>de", function() dapui.eval() end, { desc = "Debug: Evaluate expression", noremap = true, silent = true})
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle breakpoint", noremap = true, silent = true})
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debug: Continue", noremap = true, silent = true})
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Debug: Step over", noremap = true, silent = true})
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Debug: Step into", noremap = true, silent = true})
vim.keymap.set("n", "<leader>du", function() dap.step_out() end, { desc = "Debug: Step out", noremap = true, silent = true})
