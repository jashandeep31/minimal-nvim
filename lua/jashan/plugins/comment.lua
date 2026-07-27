return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	keys = {
		{ "gcc", mode = "n", desc = "Toggle comment line" },
		{ "gc", mode = { "n", "v" }, desc = "Toggle comment" },
		{ "gbc", mode = "n", desc = "Toggle block comment" },
		{ "gb", mode = { "n", "v" }, desc = "Toggle block comment" },
		{ "<leader>gcc", "gcc", mode = "n", remap = true, desc = "Toggle comment line" },
	},
	config = function()
		-- Set up nvim-ts-context-commentstring
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		local ts_pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

		-- Set up Comment.nvim
		require("Comment").setup({
			pre_hook = function(ctx)
				local filename = vim.fn.expand("%:t")

				if filename:match("^%.env") then
					return vim.bo.commentstring
				end

				local ok, commentstring = pcall(ts_pre_hook, ctx)

				if ok and commentstring then
					return commentstring
				end

				return vim.bo.commentstring
			end,
		})
	end,
}
