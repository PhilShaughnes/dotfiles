-- bootstrap
-- if package.loaded["lazy"] then return {} end
--
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "--single-branch",
--     "https://github.com/folke/lazy.nvim.git",
--     lazypath,
--   })
-- end
-- vim.opt.runtimepath:prepend(lazypath)
--
-- -- initalize lazy and load plugins
-- require("lazy").setup("plugs", {
-- 	defaults = {
-- 		lazy = false, -- should plugins be lazy-loaded?
-- 	},
-- 	dev = {
-- 		-- directory where you store your local plugin projects
-- 		-- path = vim.fn.stdpath("config") .. "/lua/my",
-- 		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
-- 		-- patterns = {"philshaughnes"},
-- 	},
-- 	install = {
-- 		-- try to load one of these colorschemes when starting an installation during startup
-- 		colorscheme = { "doom-one" },
-- 	},
-- 	-- these are probably all defaults
-- 	ui = {
-- 		custom_keys = {
-- 			-- you can define custom key maps here.
-- 			-- To disable one of the defaults, set it to false
--
-- 			-- open lazygit log
-- 			["<localleader>l"] = function(plugin)
-- 				require("lazy.util").open_cmd({ "lazygit", "log" }, {
-- 					cwd = plugin.dir,
-- 					terminal = true,
-- 					close_on_exit = true,
-- 					enter = true,
-- 				})
-- 			end,
--
-- 			-- open a terminal for the plugin dir
-- 			["<localleader>t"] = function(plugin)
-- 				require("lazy.util").open_cmd({ vim.go.shell }, {
-- 					cwd = plugin.dir,
-- 					terminal = true,
-- 					close_on_exit = true,
-- 					enter = true,
-- 				})
-- 			end,
-- 		},
-- 	},
-- 	diff = {
-- 		-- diff command <d> can be one of:
-- 		-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
-- 		--   so you can have a different command for diff <d>
-- 		-- * git: will run git diff and open a buffer with filetype git
-- 		-- * terminal_git: will open a pseudo terminal with git diff
-- 		-- * diffview.nvim: will open Diffview to show the diff
-- 		cmd = "git",
-- 	},
-- 	performance = {
-- 		rtp = {
-- 			---@type string[] list any plugins you want to disable here
-- 			disabled_plugins = {
-- 				"gzip",
-- 				"matchit",
-- 				"matchparen",
-- 				"netrwPlugin",
-- 				"tarPlugin",
-- 				"tohtml",
-- 				-- "tutor",
-- 				"zipPlugin",
-- 			},
-- 		},
-- 	},
-- })
return {}
