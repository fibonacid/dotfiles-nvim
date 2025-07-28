-- Basic Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.tabstop = 2
vim.g.mapleader = " "
vim.o.signcolumn = "yes"

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

-- Plugins
vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" }
})

-- Theming
vim.cmd("colorscheme rose-pine-moon")
vim.cmd(":hi statusline guibg=NONE")

-- Language Servers
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"basedpyright"
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics for line" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "List available code actions" })

-- Oil
require("oil").setup()
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Explore files" })

-- Telescope
require("telescope").setup()
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find by file name" })
vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Find by string" })
vim.keymap.set("n", "<leader>D", ":Telescope diagnostics<CR>", { desc = "Find errors in buffer" })

-- LazyGit
vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>")
