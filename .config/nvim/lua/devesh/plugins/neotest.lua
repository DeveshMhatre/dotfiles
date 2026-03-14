return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Adapters
		"olimorris/neotest-rspec",
		"haydenmeade/neotest-jest",
		"marilari88/neotest-vitest",

		"nvim-neotest/neotest-plenary",
	},
	config = function()
		local neotest = require("neotest")

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
	end,
}
