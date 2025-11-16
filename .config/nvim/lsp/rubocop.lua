vim.lsp.config("rubocop", {
	cmd = { "rubocop", "--lsp" },
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
})
