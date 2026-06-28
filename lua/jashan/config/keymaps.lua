-- leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

-- jk to escape
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "qq", "<cmd>q!<CR>", { desc = "Quit window" })

-- oo: insert line below, stay in normal mode
keymap.set("n", "oo", "o<Esc>", { noremap = true, silent = true })
-- OO: insert line above, stay in normal mode
keymap.set("n", "OO", "O<Esc>j", { noremap = true, silent = true })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>fp", function()
  vim.fn.setreg("+", vim.fn.expand("%:."))
  vim.notify("Copied file path")
end, { desc = "Copy current file path" })

-- Move lines up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Buffer navigation with Shift + h/l
vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Next buffer" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Split the current buffer into another window
keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split current buffer horizontally" })
keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split current buffer vertically" })

-- Buffer/tab actions (bufferline)
keymap.set("n", "<leader>tn", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer tab" })
keymap.set("n", "<leader>tN", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer tab" })
keymap.set("n", "<leader>tp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer tab" })
keymap.set("n", "<leader>tc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer tab to close" })
keymap.set("n", "<leader>to", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffer tabs" })
keymap.set("n", "<leader>tl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffer tabs to the left" })
keymap.set("n", "<leader>tr", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffer tabs to the right" })

-- local function reload_config()
-- 	local current_file = vim.api.nvim_buf_get_name(0)
--
-- 	if vim.lsp.document_color then
-- 		pcall(vim.lsp.document_color.enable, false)
-- 	end
--
-- 	for _, client in ipairs(vim.lsp.get_clients()) do
-- 		client:stop(true)
-- 	end
--
-- 	for module_name in pairs(package.loaded) do
-- 		if module_name:match("^jashan") then
-- 			package.loaded[module_name] = nil
-- 		end
-- 	end
--
-- 	local config_file = vim.env.MYVIMRC or (vim.fn.stdpath("config") .. "/init.lua")
-- 	pcall(require, "jashan.config.keymaps")
--
-- 	local lazy_reloader_ok, lazy_reloader = pcall(require, "lazy.manage.reloader")
-- 	if lazy_reloader_ok then
-- 		lazy_reloader.reload({
-- 			{ file = config_file, what = "changed" },
-- 		})
-- 	end
--
-- 	if current_file ~= "" and vim.api.nvim_buf_get_name(0) == current_file then
-- 		pcall(vim.cmd, "edit!")
-- 	end
--
-- 	vim.schedule(function()
-- 		pcall(vim.cmd, "LspStart")
-- 		vim.notify("Neovim config reloaded", vim.log.levels.INFO)
-- 	end)
-- end

-- use jk to exit insert mode
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("bufdo e!")
end, {
  desc = "Reload all buffers from disk",
})
