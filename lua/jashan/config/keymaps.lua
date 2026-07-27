-- Keep the leader values here as well as in lazy.lua so this file is safe to
-- load on its own. These must be set before any mappings are created.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

local function opts(description, extra)

	local options = {
		desc = description,
		silent = true,
		noremap = true,
	}

	if extra then
		for key, value in pairs(extra) do
			options[key] = value
		end
	end

	return options
end

local function reload_workspace()
	-- :checktime refreshes files changed by commands such as `go mod tidy`, but
	-- does not overwrite a buffer containing unsaved changes.
	vim.cmd("silent! checktime")

	local clients = vim.lsp.get_clients()
	local client_names = {}

	for _, client in ipairs(clients) do
		client_names[client.name] = true
		client:stop(true)
	end
	vim.diagnostic.reset(nil)

	-- Native Neovim LSP enables clients through FileType/BufEnter autocmds.
	-- Toggling the clients makes gopls reread go.mod/go.sum and rebuild its
	-- module cache instead of continuing with stale metadata.
	if vim.lsp.enable then
		for name in pairs(client_names) do
			vim.lsp.enable(name, false)
		end
		for name in pairs(client_names) do
			vim.lsp.enable(name, true)
		end
	end

	-- Re-run the attach autocmd for the current buffer. This is harmless when
	-- no LSP is configured for the filetype.
	vim.api.nvim_exec_autocmds("BufEnter", { buffer = 0, modeline = false })
	vim.notify("Buffers and LSP workspace reloaded", vim.log.levels.INFO)
end

-- Insert mode and quit helpers.
map("i", "jk", "<Esc>", opts("Exit insert mode"))
map("n", "qq", "<cmd>q!<CR>", opts("Quit window"))

-- Insert a blank line while staying in normal mode.
map("n", "oo", "o<Esc>", opts("Insert line below"))
map("n", "OO", "O<Esc>j", opts("Insert line above"))

-- Search and path helpers.
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", opts("Clear search highlights"))
map("n", "<leader>fp", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, opts("Copy current file path"))

-- Move lines and selections.
map("n", "<A-j>", "<cmd>m .+1<CR>==", opts("Move line down"))
map("n", "<A-k>", "<cmd>m .-2<CR>==", opts("Move line up"))
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts("Move selection down"))
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts("Move selection up"))

-- Buffer and window navigation.
map("n", "H", "<cmd>bprevious<CR>", opts("Previous buffer"))
map("n", "L", "<cmd>bnext<CR>", opts("Next buffer"))
map("n", "<C-h>", "<C-w><C-h>", opts("Focus left window"))
map("n", "<C-j>", "<C-w><C-j>", opts("Focus lower window"))
map("n", "<C-k>", "<C-w><C-k>", opts("Focus upper window"))
map("n", "<C-l>", "<C-w><C-l>", opts("Focus right window"))
map("n", "<leader>sh", "<cmd>split<CR>", opts("Split horizontally"))
map("n", "<leader>sv", "<cmd>vsplit<CR>", opts("Split vertically"))

-- Bufferline actions.
map("n", "<leader>tn", "<cmd>BufferLineCycleNext<CR>", opts("Next tab"))
map("n", "<leader>tN", "<cmd>BufferLineCyclePrev<CR>", opts("Previous tab"))
map("n", "<leader>tp", "<cmd>BufferLinePick<CR>", opts("Pick tab"))
map("n", "<leader>tc", "<cmd>BufferLinePickClose<CR>", opts("Pick tab to close"))
map("n", "<leader>to", "<cmd>BufferLineCloseOthers<CR>", opts("Close other tabs"))
map("n", "<leader>tl", "<cmd>BufferLineCloseLeft<CR>", opts("Close tabs to the left"))
map("n", "<leader>tr", "<cmd>BufferLineCloseRight<CR>", opts("Close tabs to the right"))

-- Reload files changed outside Neovim and restart LSP clients. In Go
-- projects this is the action to use after changing go.mod/go.sum and
-- running `go mod tidy`.
map("n", "<leader>rr", reload_workspace, opts("Reload buffers and restart LSP"))

return {
	reload_workspace = reload_workspace,
}
