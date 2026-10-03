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

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		if pcall(vim.treesitter.get_parser, 0) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end,
})
