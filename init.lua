vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.tabstop = 2
vim.g.mapleader = " "
vim.o.signcolumn = "yes"


vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" }
})


vim.cmd("colorscheme rose-pine-moon")
vim.cmd(":hi statusline guibg=NONE")

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"basedpyright"
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

require("oil").setup()
vim.keymap.set("n", "<leader>e", ":Oil<CR>")


