vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.tabstop = 2
vim.g.mapleader = " "


vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")

vim.pack.add({
				{ src = "https://github.com/rose-pine/neovim" }
})

vim.cmd("colorscheme rose-pine-moon")
vim.cmd(":hi statusline guibg=NONE")

