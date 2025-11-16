vim.lsp.config("stylua", {
	cmd = { "stylua", "--lsp" },
	filetypes = { "lua" },
	root_markers = { ".stylua.toml", "stylua.toml", ".editorconfig" },
})
