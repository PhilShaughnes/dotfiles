local g = vim.g

local M = {
	{ "nvim-treesitter/playground",    cmd = "TSPlaygroundToggle" },
	{ 'RRethy/nvim-treesitter-endwise' },
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = true,
		dependencies = {
			'RRethy/nvim-treesitter-endwise',
		},
		config = function()
			vim.treesitter.language.register('make', 'just')

			g.markdown_fenced_languages = {
				'bash=sh', 'js=javascript', 'json', 'ruby', 'lua',
				'html', 'css', 'sql', 'java', 'graphql', 'go'
			}
			require 'nvim-treesitter.configs'.setup {
				-- one of "all", "maintained" (parsers with maintainers), or a list of languages
				ensure_installed = { "ruby", "bash", "c", "cmake", "comment", "css",
					"dockerfile", "eex", "elixir", "erlang", "glimmer", "go", "graphql",
					"heex", "html", "hurl", "java", "javascript", "jsdoc", "json", "lua",
					"make", "python", "regex", "scss", "markdown", "help",
					"typescript", "tsx", "vim", "vue", "toml", "yaml", "hcl",
					"markdown_inline", "gotmpl", "just", "cue" },
				ignore_install = { "rust" },
				highlight = {
					enable = true,   -- false will disable the whole extension
					additional_vim_regex_highlighting = { "markdown" },
					disable = { "rust" }, -- list of language that will be disabled
				},
				endwise = { enable = true },
				-- incremental_selection = {
				--   enable = true,
				--   keymaps = {
				--     init_selection = "gnn",
				--     node_incremental = "grn",
				--     scope_incremental = "grc",
				--     node_decremental = "grm",
				--   },
				-- },
				-- indent = { enable = true },
				playground = {
					enable = true,
					disable = {},
					updatetime = 25,    -- Debounced time for highlighting nodes in the playground from source code
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
			}

			-- cmd 'set foldmethod=expr'
			-- cmd 'set foldexpr=nvim_treesitter#foldexpr()'
			-- vim.wo.foldmethod = expr
			-- vim.wo.foldexpr = some function
		end
	},
}

return M
