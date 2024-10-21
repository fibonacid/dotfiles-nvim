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
		},
		config = function()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>twr",
				"<cmd>lua require('neotest').run.run()<cr>",
				{ desc = "Run Watch" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>twf",
				"<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'vitest --watch' })<cr>",
				{ desc = "Run Watch File" }
			)
			require("neotest").setup({
				adapters = {
					require("neotest-vitest")({
						-- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
						filter_dir = function(name)
							return name ~= "node_modules"
						end,
					}),
				},
			})
		end,
	},
}
