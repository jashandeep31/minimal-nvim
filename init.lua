-- Requiring  config files
require("jashan.config.keymaps")
require("jashan.config.lazy")

vim.cmd.syntax("enable")
vim.cmd.filetype({ "plugin", "indent", "on" })

vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Common indentation defaults for all new buffers.
-- Language-specific ftplugins can still override these locally.
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- using the system clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
