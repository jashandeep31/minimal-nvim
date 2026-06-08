return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{
			"<leader>,",
			function()
				require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
					previewer = false,
					sort_lastused = true,
					ignore_current_buffer = true,
				}))
			end,
			desc = "Search Open Buffers",
		},
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find Files (Alt)",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Live Grep",
		},
		{
			"<leader>b",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			desc = "Search in Current Buffer",
		},
		{
			"<leader>fe",
			function()
				require("telescope.builtin").find_files({
					prompt_title = ".env Files",
					previewer = false,
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"-g",
						"!.git",
						"-g",
						"*.env*",
					},
				})
			end,
			desc = "Find .env files",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git/",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
