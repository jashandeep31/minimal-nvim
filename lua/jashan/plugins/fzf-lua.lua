return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	keys = {
		{
			"<leader>,",
			function()
				require("fzf-lua").buffers({
					previewer = false,
					sort_lastused = true,
					current_buf = false,
				})
			end,
			desc = "Search Open Buffers",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files (fzf-lua)",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Live Grep (fzf-lua)",
		},
		{
			"<leader>b",
			function()
				require("fzf-lua").blines({ previewer = false })
			end,
			desc = "Search in Current Buffer",
		},
		{
			"<leader>fe",
			function()
				require("fzf-lua").files({
					prompt = ".env Files> ",
					cmd = "rg --files --hidden --glob '!.git' --glob '*.env*'",
					previewer = false,
				})
			end,
			desc = "Find .env files",
		},
	},
	opts = {
		winopts = {
			preview = { default = "bat" },
		},
		fzf_opts = {
			["--layout"] = "reverse",
			["--info"] = "inline",
		},
	},
}
