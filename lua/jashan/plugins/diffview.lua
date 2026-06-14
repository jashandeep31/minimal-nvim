return {
	"sindrets/diffview.nvim",
	event = "BufReadPre",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		{ "<leader>ld", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff File History" },
		{ "<leader>lD", "<cmd>DiffviewOpen<CR>", desc = "Diff View (Global)" },
		{ "<leader>lx", "<cmd>DiffviewClose<CR>", desc = "Close Diff View" },
	},
}
