-- Basic Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.tabstop = 2
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

-- Basic Keymaps
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>", { desc = "Save and reload config" })
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Tabs and Splits
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>c", ":hsplit<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>sc", ":close<CR>", { desc = "Close vertical split" })

-- Plugins
vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/jvgrootveld/telescope-zoxide" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- Testing
	{ src = "https://github.com/nvim-neotest/neotest" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/thenbe/neotest-playwright" }
})


-- Theming
vim.cmd("colorscheme rose-pine-moon")
vim.cmd(":hi statusline guibg=NONE")

-- Tree Sitter
require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "python", "javascript", "jsdoc", "typescript", "json", "yaml", "go", "rust", "arduino" },
}

-- Language Servers
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"eslint",
	"jsonls",
	"ruff",
	"basedpyright",
	"bashls",
	"yamlls",
	"rust_analyzer",
	"gopls",
	"arduino_language_server",
	"clangd",
	"tailwindcss",
})

--
-- Auto Complete
-- Works best with completeopt=noselect.
-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.cmd [[set completeopt+=menuone,noselect,popup]]

-- Conform
require("conform").setup({
	log_level = vim.log.levels.DEBUG,
	formatters_by_ft = {
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
				{ buffer = args.buf, desc = "Go to implementation" })
		end

		if client:supports_method('textDocument/definition') then
			-- Create a keymap for vim.lsp.buf.definition ...
			vim.keymap.set("n", "gd", vim.lsp.buf.definition,
				{ buffer = args.buf, desc = "Go to definition" })
		end

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		vim.notify('LSP client attached: ' .. client.name, vim.log.levels.INFO)

		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
		    and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = args.buf,
				callback = function()
					-- vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end
	end,
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format current buffer" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics for line" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "List available code actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })


-- Lua LS Configuration
vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
			    path ~= vim.fn.stdpath('config')
			    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
				}
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = {
				--   vim.api.nvim_get_runtime_file('', true),
				-- }
			}
		})
	end,
	settings = {
		Lua = {}
	}
})

-- Use the `:LspTypescriptSourceAction` command to see "whole file" ("source") code-actions such as:
vim.lsp.config('ts_ls', {
	on_attach = function(client, bufnr)
		if client.name == "ts_ls" then
			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format file" })
			vim.keymap.set("n", "<leader>li", ":LspTypescriptSourceAction<CR>",
				{ buffer = bufnr, desc = "Source action" })
		end
	end,
})

local git_utils = require"git_utils"
local git_status = git_utils.new_git_status()

-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
	git_status = git_utils.new_git_status()
	orig_refresh(...)
end

-- Oil
require("oil").setup({
	view_options = {
		show_hidden = true,
		is_hidden_file = function(name, bufnr)
			local dir = require("oil").get_current_dir(bufnr)
			local is_dotfile = vim.startswith(name, ".") and name ~= ".."
			-- if no local directory (e.g. for ssh connections), just hide dotfiles
			if not dir then
				return is_dotfile
			end
			-- dotfiles are considered hidden unless tracked
			if is_dotfile then
				return not git_status[dir].tracked[name]
			else
				-- Check if file is gitignored
				return git_status[dir].ignored[name]
			end
		end,
	},
	columns = {
		"icon",
	},
	keymaps = {
		["<C-v>"] = { "actions.select", opts = { vertical = true } }
	}
})

vim.keymap.set("n", "<leader>ee", ":Oil <CR>", { desc = "Explore files" })
vim.keymap.set("n", "<leader>ef", ":Oil --float<CR>", { desc = "Explore in float" })

-- Telescope
require("telescope").setup()

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find by file name" })
vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Find by string" })
vim.keymap.set("n", "<leader>fg", ":Telescope git_status<CR>", { desc = "Find git status files" })
vim.keymap.set("n", "<leader>D", ":Telescope diagnostics<CR>", { desc = "Find errors in buffer" })

require("telescope").load_extension('zoxide')
vim.keymap.set("n", "<leader>fz", ":Telescope zoxide list<CR>", { desc = "Open zoxide list" })

-- LazyGit
vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>")

-- Neotest
local neotest = require('neotest')
neotest.setup({
	adapters = {
		require('neotest-playwright').adapter({
			options = {
				persist_project_selection = true,
				enable_dynamic_test_discovery = true,
			},
		}),
	},
})

vim.keymap.set("n", "<leader>ttr", function() neotest.run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>ttf", function() neotest.run.run(vim.fn.expand("%")) end,
	{ desc = "Run tests in current file" })
vim.keymap.set("n", "<leader>tts", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>tto", function() neotest.output.open({ enter = true }) end,
	{ desc = "Open test output" })
