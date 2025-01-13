return {
	"vuki656/package-info.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		local pkginfo = require("package-info")
		pkginfo.setup()

		local keymap = vim.keymap -- for conciseness

		local opts = { silent = true, noremap = true }

		-- Show dependency versions
		opts.desc = "Show dependency versions"
		keymap.set({ "n" }, "<leader>ns", pkginfo.show, opts)

		-- Hide dependency versions
		opts.desc = "Hide dependency versions"
		keymap.set({ "n" }, "<leader>nc", pkginfo.hide, opts)

		-- Toggle dependency versions
		opts.desc = "Toggle dependency versions"
		keymap.set({ "n" }, "<leader>nt", pkginfo.toggle, opts)

		-- Update dependency on the line
		opts.desc = "Update dependency on the line"
		keymap.set({ "n" }, "<leader>nu", pkginfo.update, opts)

		-- Delete dependency on the line
		opts.desc = "Delete dependency on the line"
		keymap.set({ "n" }, "<leader>nd", pkginfo.delete, opts)

		-- Install a new dependency
		opts.desc = "Install a new dependency"
		keymap.set({ "n" }, "<leader>ni", pkginfo.install, opts)

		-- Install a different dependency version
		opts.desc = "Install a different dependency version"
		keymap.set({ "n" }, "<leader>np", pkginfo.change_version, opts)
	end,
}
