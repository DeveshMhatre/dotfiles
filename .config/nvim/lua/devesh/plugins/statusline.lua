return {
	'beauwilliams/statusline.lua',
	dependencies = {
		'nvim-lua/lsp-status.nvim',
	},
	config = function()
		require('statusline').setup({
			match_colorscheme = true,
			tabline = false,
			lsp_diagnostics = true,
			ale_diagnostics = false, -- Enable ALE diagnostics (Default: false)
		})
	end,
}