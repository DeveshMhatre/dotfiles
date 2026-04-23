vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local treesitter = require("nvim-treesitter")

treesitter.install({ "c", "cpp", "go", "javascript", "lua", "ruby", "rust", "typescript" })

treesitter.setup({
	defaults = {
		preview = {
			treesitter = false,
		},
	},
})
