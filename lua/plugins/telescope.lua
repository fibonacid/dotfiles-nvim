return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"xiyaowong/telescope-emoji.nvim",
		"jvgrootveld/telescope-zoxide",
		"nvim-tree/nvim-tree.lua",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
			-- (other Telescope configuration...)
			extensions = {
				zoxide = {
					prompt_title = "[ Walking on the shoulders of TJ ]",
					mappings = {
						default = {
							after_action = function(selection)
								vim.notify("Directory changed to " .. selection.path)
								require("nvim-tree.api").tree.reload()
							end,
						},
						-- ["<C-s>"] = {
						-- 	before_action = function(selection)
						-- 		print("before C-s")
						-- 	end,
						-- 	action = function(selection)
						-- 		vim.cmd.edit(selection.path)
						-- 	end,
						-- },
						-- Opens the selected entry in a new split
						-- ["<C-q>"] = { action = z_utils.create_basic_command("split") },
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("lazygit")
		telescope.load_extension("emoji")
		telescope.load_extension("yaml_schema")
		telescope.load_extension("zoxide")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })

		keymap.set("n", "<leader>fgf", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find git files" })
		keymap.set("n", "<leader>fgc", "<cmd>Telescope git_commits<cr>", { desc = "Fuzzy find git commits" })
		keymap.set("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>", { desc = "Fuzzy find git branches" })
		keymap.set("n", "<leader>fgs", "<cmd>Telescope git_status<cr>", { desc = "Fuzzy find git status" })
		keymap.set(
			"n",
			"<leader>fgb",
			"<cmd>Telescope git_bcommits<cr>",
			{ desc = "Fuzzy find git commits for buffer" }
		)
		keymap.set("n", "<leader>fz", "<cmd>Telescope zoxide list<cr>", { desc = "Fuzzy find zoxide locations" })
	end,
}
