vim.pack.add({
	{ src = "https://github.com/nvim-lua/lsp-status.nvim" },
	{ src = "https://github.com/beauwilliams/statusline.lua" },
})

require("statusline").setup({
	match_colorscheme = true,
	tabline = false,
	lsp_diagnostics = true,
	ale_diagnostics = false, -- Enable ALE diagnostics (Default: false)
})
