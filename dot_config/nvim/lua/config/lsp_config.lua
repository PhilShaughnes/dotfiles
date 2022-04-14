-- local lsp = require("lspconfig")
-- lsp.tsserver.setup({})

local USER = vim.fn.expand("$HOME")
local lsp_installer = require("nvim-lsp-installer")

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
				capabilities = capabilities,
				on_attach = function(_, _) -- client, bufnr
						require "lsp_signature".on_attach()
					end,
		}

		if server.name == "sumneko_lua" then
			opts = {
				capabilities = capabilities,
				on_attach = function(_, _) -- client, bufnr
						require "lsp_signature".on_attach()
					end,
				settings = {
					Lua = {
						diagnostics = {
							globals = {'vim', 'hs'}
						},
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";")
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								['/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'] = true,
								[USER .. '/.Hammerspoon/Spoons/EmmyLua.spoon/annotations'] = true,
							}
						}
					}
				}
			}

			vim.diagnostic.config {
				severity_sort = true,
				underline = { severity = {min = vim.diagnostic.severity.WARN} },
				virtual_text = { severity = {min = vim.diagnostic.severity.WARN} }
			}
		end

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
    server:setup(opts)
end)

-- LSP CONFIG

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--       -- disable virtual text
--       virtual_text = false,

--       -- show signs
--       signs = true,

--       -- delay update diagnostics
--       update_in_insert = false,
--       -- display_diagnostic_autocmds = { "InsertLeave" },

--     }
--   )
