local g = vim.g

local ensure_install_langs = { "ruby", "bash", "c", "cmake", "comment", "css",
	"dockerfile", "eex", "elixir", "erlang", "glimmer", "go", "graphql",
	"heex", "html", "hurl", "java", "javascript", "jsdoc", "json", "lua",
	"make", "python", "regex", "scss", "markdown", "vimdoc",
	"typescript", "tsx", "vim", "vue", "toml", "yaml", "hcl",
	"markdown_inline", "cue" }

local ts_textobjects = {
	select = {
		enable = true,

		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		keymaps = {
			-- You can use the capture groups defined in textobjects.scm
			["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
			["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
			["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
			["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

			["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
			["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

			["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
			["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

			["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
			["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

			["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
			["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

			["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
			["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

			["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
			["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
		},
	},
}

local incremental = {
	enable = true,
	keymaps = {
		init_selection = "<C-t>",
		node_incremental = "<C-t>",
		scope_incremental = "<C-t>",
		node_decremental = "<bs>",
	},
}

local playground = {
	enable = true,
	disable = {},
	updatetime = 25,        -- Debounced time for highlighting nodes in the playground from source code
	persist_queries = false, -- Whether the query persists across vim sessions
	keybindings = {
		toggle_query_editor = 'o',
		toggle_hl_groups = 'i',
		toggle_injected_languages = 't',
		toggle_anonymous_nodes = 'a',
		toggle_language_display = 'I',
		focus_language = 'f',
		unfocus_language = 'F',
		update = 'R',
		goto_node = '<cr>',
		show_help = '?',
	},
}


local M = {
	-- { 'RRethy/nvim-treesitter-endwise' },
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		lazy = true,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = true,
		dependencies = {
			-- 'RRethy/nvim-treesitter-endwise',
			'nvim-treesitter/nvim-treesitter-textobjects'
		},
		config = function()
			vim.treesitter.language.register('make', 'just')

			g.markdown_fenced_languages = {
				'bash=sh', 'js=javascript', 'json', 'ruby', 'lua',
				'html', 'css', 'sql', 'java', 'go'
			}
			require 'nvim-treesitter.configs'.setup {
				-- one of "all", "maintained" (parsers with maintainers), or a list of languages
				ensure_installed = ensure_install_langs,
				ignore_install = { "rust" },
				highlight = {
					enable = true,   -- false will disable the whole extension
					additional_vim_regex_highlighting = { "markdown" },
					disable = { "rust" }, -- list of language that will be disabled
				},
				-- endwise = { enable = true },
				incremental_selection = incremental,
				textobjects = ts_textobjects,
				indent = { enable = true },
				playground = playground,
			}

			-- cmd 'set foldmethod=expr'
			-- cmd 'set foldexpr=nvim_treesitter#foldexpr()'
			-- vim.wo.foldmethod = expr
			-- vim.wo.foldexpr = some function
		end
	},
}

return M
