return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "abcdefghijklmnopqrstuvwxyz",
		modes = {
			char = {
				enabled = true,
				jump_labels = true,
				keys = { "f", "F", "t", "T", ";", "," },
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash Jump",
		},
	},
}
