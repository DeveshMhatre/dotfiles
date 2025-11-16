return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.install({ "javascript", "lua", "ruby", "rust", "typescript" })

		treesitter.setup({
			defaults = {
				preview = {
					treesitter = false,
				},
			},
		})
	end,
}
