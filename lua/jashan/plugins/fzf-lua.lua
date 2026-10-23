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
					cwd_prompt = false,
					raw_cmd = table.concat({
						"fd -t f -H -I -g '.env*'",
						"-E .git",
						"-E node_modules",
						"-E .next",
						"-E dist",
						"-E build",
						"-E vendor",
					}, " "),
					previewer = false,
					file_icons = false,
					git_icons = false,
				})
			end,
			desc = "Find .env files",
		},
	},
	opts = {
		winopts = {
			preview = {
				default = "bat",
				layout = "horizontal",
				horizontal = "right:35%",
			},
		},
		fzf_opts = {
			["--layout"] = "reverse",
			["--info"] = "inline",
			["--keep-right"] = true,
		},
	},
}
