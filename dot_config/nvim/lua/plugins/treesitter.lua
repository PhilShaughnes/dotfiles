local g = vim.g

local ensure_install_langs = { "ruby", "bash", "c", "cmake", "comment", "css",
	"dockerfile", "eex", "elixir", "erlang", "glimmer", "go", "graphql",
	"heex", "html", "hurl", "java", "javascript", "jsdoc", "json", "lua",
	"make", "python", "regex", "scss", "markdown", "vimdoc",
	"typescript", "tsx", "vim", "vue", "toml", "yaml", "hcl",
	"markdown_inline", "cue" }


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
		'nvim-treesitter/nvim-treesitter',
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			-- 'RRethy/nvim-treesitter-endwise',
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
