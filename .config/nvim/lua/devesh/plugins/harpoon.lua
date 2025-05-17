return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({})

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>qa", function()
			harpoon:list():add()
		end, { desc = "Add buffer to Harpoon Quick Menu" })

		keymap.set("n", "<leader>qt", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Toggle Harpoon Quick Menu" })

		keymap.set("n", "<leader>qs", function()
			harpoon:list():select(vim.v.count)
		end, { desc = "Select the nth Harpoon Quick Menu item" })

		keymap.set("n", "<leader>qp", function()
			harpoon:list():prev()
		end, { desc = "Select the previous Harpoon Quick Menu item" })

		keymap.set("n", "<leader>qn", function()
			harpoon:list():next()
		end, { desc = "Select the next Harpoon Quick Menu item" })

		keymap.set("n", "<leader>qc", function()
			harpoon:list():clear()
		end, { desc = "Remove all items from Harpoon Quick Menu" })

		keymap.set("n", "<leader>qd", function()
			harpoon:list():remove_at(vim.v.count)
			for i = vim.v.count, harpoon:list():length() - 1 do
				local next_item = harpoon:list():get(i + 1)
				harpoon:list():replace_at(i, next_item)
			end
		end, { desc = "Remove the nth Harpoon Quick Menu item" })
	end,
}
