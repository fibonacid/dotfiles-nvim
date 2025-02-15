return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "ColorScheme",
	config = function()
		require("lualine").setup({
			options = {
				---@usage 'rose-pine' | 'rose-pine-alt'
				theme = "rose-pine",
				disabled_filetypes = { "NvimTree", "Avante", "AvanteInput", "AvanteSelectedFiles" },
			},
		})
	end,
}
