local M = {}

function M.setup()
	local dap = require("dap")

	dap.adapters.lldb = {
		type = "executable",
		command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
		name = "lldb",
	}

	dap.configurations.c = {
		{
			name = "Launch Target",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
		},
	}

	dap.configurations.cpp = dap.configurations.c
	-- You can add Rust here later too!
	-- dap.configurations.rust = dap.configurations.c
end

return M
