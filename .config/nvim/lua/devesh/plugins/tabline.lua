return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				always_show_bufferline = false,
				auto_toggle_bufferline = true,
				diagnostics = "nvim_lsp",
				diagnostics_update_on_event = true,
				mode = "tabs",
				separator_style = "slope",
			},
		})
	end,
}
