local h = require('helpers')
local ollama_base = os.getenv('OLLAMA_API_BASE')
local gp_providers = {
	openai = {
		endpoint = "https://api.openai.com/v1/chat/completions",
		secret = os.getenv("OPENAI_API_KEY"),
	},

	copilot = {
		endpoint = "https://api.githubcopilot.com/chat/completions",
		secret = {
			"bash",
			"-c",
			"cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
		},
	},

	ollama = {
		endpoint = ollama_base .. "/v1/chat/completions",
	},

	googleai = {
		endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
		secret = os.getenv("GG_GEMINI_API_KEY"),
	},

	openrouter = {
		endpoint = "https://openrouter.ai/api/v1/chat/completions",
		secret = os.getenv("OPENROUTER_API_KEY"),
	},

	mistral = {
		-- https://api.mistral.ai/v1/agents/completions
		-- https://api.mistral.ai/v1/fim/completions
		endpoint = "https://api.mistral.ai/v1/chat/completions",
		secret = os.getenv("MISTRAL_API_KEY"),
	},
}
local M = {
	{
		"robitx/gp.nvim",
		config = function()
			local conf = {
				-- For customization, refer to Install > Configuration in the Documentation/Readme
			}
			require("gp").setup(conf)

			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
		end,
	},
	{
		'pixqc/mana.nvim',
		main = 'mana',
		cmd = 'Mana',
		init = function()
			vim.keymap.set('n', '\\', ':Mana toggle<CR>', { desc = 'mana toggle' })
			vim.keymap.set('n', '<leader>ms', ':Mana switch<CR>', { desc = 'mana switch' })
			vim.keymap.set('v', '<leader>mq', ':Mana paste<CR>', { desc = 'mana paste' })
			vim.keymap.set('n', '<leader>mc', ':Mana clear<CR>', { desc = 'mana clear' })
		end,
		opts = {
			default_model = 'deepseekv3',
			models = {
				sonnet = {
					endpoint = 'openrouter',
					name = 'anthropic/claude-3.5-sonnet:beta',
					system_prompt = '',
					temperature = 0.7,
					top_p = 0.9,
				},
				deepseekv3 = {
					endpoint = 'openrouter',
					name = 'deepseek/deepseek-chat',
					system_prompt = '',
					temperature = 0.7,
					top_p = 0.9,
				},
				gemini_flash_thinking = {
					endpoint = 'aistudio',
					name = 'gemini-2.0-flash-thinking-exp',
					system_prompt = '',
					temperature = 0.7,
					top_p = 0.9,
				},
			},
			envs = {
				aistudio = 'GOOGLE_AISTUDIO_API_KEY',
				openrouter = 'OPENROUTER_API_KEY',
			},
		},
	},
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	config = true,
	-- 	opt = {
	-- 		strategies = {
	-- 			chat = {
	-- 				adapter = "copilot",
	-- 			},
	-- 			inline = {
	-- 				adapter = "copilot",
	-- 			},
	-- 			cmd = {
	-- 				adapter = "copilot",
	-- 			}
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	cmd = { "CodeCompanionChat", "CodeCompanionActions" },
	-- 	init = function()
	-- 		h.nmap('<leader>lma', function()
	-- 			require('fzf-lua').register_ui_select()
	-- 			vim.cmd([[:CodeCompanionActions]])
	-- 		end, { desc = 'CodeCompanion actions' })
	-- 		h.nmap('<leader>lmc', ":CodeCompanionChat Toggle<CR>", { desc = 'toggle CodeCompanion' })
	-- 		h.vmap('<leader>lmc', ":CodeCompanion", { desc = 'CodeCompanion' })
	-- 	end,
	-- },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },                -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken",                       -- Only on MacOS or Linux
		init = function()
			-- require('fzf-lua').register_ui_select()
			-- h.nmap('<leader>lm', ":CopilotChatToggle<CR>", { desc = 'yank github link' })
			h.vmap('<leader>lmr', ":CopilotChatReview<CR>", { desc = 'copilot review' })
			h.vmap('<leader>lme', ":CopilotChatExplain<CR>", { desc = 'copilot explain' })
			h.vmap('<leader>lmo', ":CopilotChatOptimize<CR>", { desc = 'copilot optimize' })
		end,
		opts = {
			sticky = {
				'#files',
			},
		},
		cmd = {
			"CopilotChatToggle",
			"CopilotChatOpen",
			"CopilotChatPrompts",
			"CopilotChatAgents",
			"CopilotChatReview",
			"CopilotChatExplain",
			"CopilotChatOptimize",
		}
	},
}

return M
