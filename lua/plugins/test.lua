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
			"nvim-neotest/neotest-jest",
			"nvim-neotest/neotest-python",
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

			vim.api.nvim_create_autocmd({ "FileType", "WinEnter", "WinLeave" }, {
				pattern = "neotest-summary",
				callback = function()
					vim.cmd("setlocal winhighlight=Normal:NormalFloat")
				end,
			})

			---@diagnostic disable-next-line: missing-fields
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
					require("neotest-jest")({}),
					require("neotest-python")({
						-- Extra arguments for nvim-dap configuration
						-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
						dap = { justMyCode = false },
						-- Command line arguments for runner
						-- Can also be a function to return dynamic values
						args = { "--log-level", "DEBUG" },
						-- Runner to use. Will use pytest if available by default.
						-- Can be a function to return dynamic value.
						runner = "pytest",
						-- Custom python path for the runner.
						-- Can be a string or a list of strings.
						-- Can also be a function to return dynamic value.
						-- If not provided, the path will be inferred by checking for
						-- virtual envs in the local directory and for Pipenev/Poetry configs
						python = ".venv/bin/python",
						-- Returns if a given file path is a test file.
						-- NB: This function is called a lot so don't perform any heavy tasks within it.
						-- is_test_file = function(file_path)
						--   ...
						-- end,
						-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
						-- instances for files containing a parametrize mark (default: false)
						-- pytest_discover_instances = true,
					}),
				},
			})
		end,
	},
}
