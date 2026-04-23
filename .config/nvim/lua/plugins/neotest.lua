vim.pack.add({
	{ src = "https://github.com/nvim-neotest/neotest" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/nvim-neotest/neotest-plenary" },
	{ src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	-- adapters
	{ src = "https://github.com/fredrikaverpil/neotest-golang" },
	{ src = "https://github.com/marilari88/neotest-vitest" },
	{ src = "https://github.com/nvim-neotest/neotest-jest" },
	{ src = "https://github.com/nvim-neotest/neotest-jest" },
	{ src = "https://github.com/olimorris/neotest-rspec" },
	{
		src = "https://github.com/mrcjkb/rustaceanvim",
		version = vim.version.range("^9"),
	},
})

-- build step for neotest-golang
vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()

local neotest = require("neotest")
local go_config = {
	runner = "gotestsum",
}

neotest.setup({
	adapters = {
		require("neotest-rspec"),
		require("neotest-jest")({
			jestCommand = "npm test --",
			env = { CI = true },
			cwd = function()
				return vim.fn.getcwd()
			end,
		}),
		require("neotest-vitest"),
		require("rustaceanvim.neotest"),
		require("neotest-golang")(go_config),

		require("neotest-plenary"),
	},
	status = { virtual_text = true },
	output = { open_on_run = true },
	summary = {
		mappings = {
			attach = "a",
			clear_marked = "M",
			clear_target = "T",
			debug = "d",
			debug_marked = "D",
			expand = { "<CR>", "l" },
			expand_all = "L",
			jumpto = "i",
			marked = "m",
			next_failed = "J",
			output = "o",
			prev_failed = "K",
			run = "r",
			run_marked = "R",
			short = "p",
			stop = "u",
			target = "t",
		},
	},
})

local keymap = vim.keymap

keymap.set("n", "<leader>rtn", function()
	neotest.run.run()
end, { desc = "Run Nearest Test" })

keymap.set("n", "<leader>rtf", function()
	neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run File Test" })

keymap.set("n", "<leader>rts", function()
	neotest.summary.toggle()
end, { desc = "Toggle Test Summary" })

keymap.set("n", "<leader>rto", function()
	neotest.output.open({ enter = true, auto_close = true })
end, { desc = "Show Test Output" })

keymap.set("n", "<leader>rtS", function()
	neotest.run.stop()
end, { desc = "Stop Test" })

-- Navigation
keymap.set("n", "[rt", function()
	neotest.jump.prev({ status = "failed" })
end, { desc = "Go to previous failed test" })

keymap.set("n", "]rt", function()
	neotest.jump.next({ status = "failed" })
end, { desc = "Go to next failed test" })
