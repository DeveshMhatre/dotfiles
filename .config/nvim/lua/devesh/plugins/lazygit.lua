return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>hG",
			"<cmd>LazyGit<cr>",
			desc = "Open Lazy Git",
		},
	},
}
