vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

vim.lsp.enable({
	"clangd",
	"cssls",
	"gopls",
	"lua_ls",
	"nixd",
	"rubocop",
	"ruby_lsp",
	"rust_analyzer",
	"stylua",
	"vtsls",
})
