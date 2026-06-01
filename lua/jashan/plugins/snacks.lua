return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = false },
		dashboard = { enabled = false },
		explorer = {
			enabled = false,
		},
		indent = { enabled = false },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		bufdelete = {},
		lazygit = {},
		terminal = {},
		scratch = {},
	},
	keys = {
		{
			"<leader>gc",
			function()
				Snacks.picker.git_log_file({
					confirm = function(picker, item)
						picker:close()
						if not item or not item.commit then
							return
						end
						local file = item.file or vim.api.nvim_buf_get_name(0)
						if file == "" then
							return
						end
						vim.schedule(function()
							vim.cmd("DiffviewOpen " .. item.commit .. "^! -- " .. vim.fn.fnameescape(file))
						end)
					end,
				})
			end,
			desc = "Pick Commit Diff (File)",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>tx",
			function()
				Snacks.bufdelete()
			end,
			desc = "Close buffer (Snacks)",
		},
		{
			"<leader>u",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			[[<c-\>]],
			function()
				Snacks.terminal(nil, { win = { border = "rounded", position = "float" } })
			end,
			mode = { "n", "t" },
			desc = "Toggle Floating Terminal",
		},
	},
}
