-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- initalize lazy and load plugins
require("lazy").setup("plugins", {
	defaults = {
		lazy = false, -- should plugins be lazy-loaded?
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	performance = {
		rtp = {
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				"gzip",
				"matchit",
				-- "matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				-- "tutor",
				"zipPlugin",
			},
		},
	},
})
