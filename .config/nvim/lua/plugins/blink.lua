vim.pack.add({
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1" },
})

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-k>"] = { "select_prev" },
		["<C-j>"] = { "select_next" },
		["<C-u>"] = { "scroll_documentation_up" },
		["<C-d>"] = { "scroll_documentation_down" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "select_and_accept", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	enabled = function()
		local disabled_filetypes = { "NvimTree", "DressingInput" }
		return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
	end,
})
