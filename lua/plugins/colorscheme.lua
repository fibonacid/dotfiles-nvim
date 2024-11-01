return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme rose-pine]])
			-- make sure background is transparent
			vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- },
}
