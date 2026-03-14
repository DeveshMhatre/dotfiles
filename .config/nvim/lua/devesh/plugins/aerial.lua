return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			-- use LSP or Treesitter for symbols
			backends = { "lsp", "treesitter", "markdown", "man" },

			layout = {
				min_width = 35, -- Matching nvim-tree width
				default_direction = "right",
				placement = "window",
			},

			-- Keymaps for the aerial window
			keymaps = {
				["<CR>"] = "actions.jump",
				["q"] = "actions.close",
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Symbol Outline (Aerial)" })
	end,
}
