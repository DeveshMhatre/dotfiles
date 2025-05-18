vim.api.nvim_create_user_command("ToggleFormatOnSave", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = not vim.b.disable_autoformat
		print("Format on save is now " .. (vim.b.disable_autoformat and "enabled" or "disabled"))
	else
		vim.g.disable_autoformat = not vim.g.disable_autoformat
		print("Format on save is now " .. (vim.g.disable_autoformat and "enabled" or "disabled"))
	end
end, {
	desc = "Toggle autoformat-on-save",
	bang = true,
})

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	enabled = true,
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				eruby = { "erb-formatter" },
				ruby = { "rubocop" },
			},
			format_after_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 1000, lsp_format = "fallback", async = true }
			end,
		})
	end,
}
