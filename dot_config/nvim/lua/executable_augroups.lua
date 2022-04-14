local api = vim.api

-- autocommands
local autocmds = {
		terminal = {
			{ "BufEnter,TermOpen", "term://* startinsert" };
			{ "TermOpen", "*", "setlocal nonumber norelativenumber signcolumn=no" };
		};
		interface = {
			{ "BufNewFile,BufRead", "*", "if &syntax == '' | set syntax=sh | endif"	};
			{ "TextYankPost", "*", [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}]] };
		};
		saving = {
			-- check if the file was updated somewhere else
			{ "WinEnter,BufWinEnter,FocusGained", "*", "checktime" };
		};
		quickfix = {
			{ "QuickFixCmdPost", "[^l]*", "cwindow" };
			{ "QuickFixCmdPost", "l*",		"lwindow" };
			{ "VimEnter",					"*",		"cwindow" };
		};

    save_shada = {
        {"VimLeave", "*", "wshada!"};
    };
    resize_windows_proportionally = {
        { "VimResized", "*", ":wincmd =" };
    };
    toggle_search_highlighting = {
        { "InsertEnter", "*", "setlocal nohlsearch" };
    };
    -- ansi_esc_log = {
    --     { "BufEnter", "*.log", ":AnsiEsc" };
    -- };
}

--- This function is taken from https://github.com/norcalli/nvim_utils
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

nvim_create_augroups(autocmds)

