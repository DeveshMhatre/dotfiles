return {
	{ "rcarriga/nvim-dap-ui", enabled = false },
	{
		"MironPascalCaseFan/debugmaster.nvim",
		dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind" },
		config = function()
			local dm = require("debugmaster")
			vim.keymap.set({ "n", "v" }, "<leader>m", dm.mode.toggle, { nowait = true }, { desc = "Toggle debug mode" })

			dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code

			require("devesh.plugins.dap_configs.c").setup()
		end,
	},
}
