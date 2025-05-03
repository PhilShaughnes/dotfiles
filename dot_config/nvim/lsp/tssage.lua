-- == Configuration for TypeScript/JavaScript files ==
return {
	name = "tssage",
	cmd = { 'sage', 'ls', '--cmd', 'typescript-language-server --stdio' },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	-- settings = { ... }
	init_options = { hostInfo = "neovim" },
}
