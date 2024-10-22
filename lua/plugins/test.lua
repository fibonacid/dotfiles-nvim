return {
	{ "nvim-neotest/neotest-plenary" },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"marilari88/neotest-vitest",
			"nvim-telescope/telescope.nvim",
			"thenbe/neotest-playwright",
		},
		config = function()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ttr",
				"<cmd>lua require('neotest').run.run()<cr>",
				{ desc = "Run Test" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ttf",
				"<cmd>lua require('neotest').run.run({ vim.fn.expand('%') })<cr>",
				{ desc = "Run All Tests" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>tts",
				"<cmd>lua require('neotest').summary.toggle()<cr>",
				{ desc = "Toggle Test Summary" }
			)
			require("neotest").setup({
				adapters = {
					require("neotest-vitest")({
						-- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
						filter_dir = function(name)
							return name ~= "node_modules"
						end,
					}),
					require("neotest-playwright").adapter({
						options = {
							persist_project_selection = true,
							enable_dynamic_test_discovery = true,
						},
					}),
				},
			})
		end,
	},
}
