return {
	{
		"mason-org/mason.nvim",
		opts = {
			PATH = "prepend",
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"gopls",
				"ts_ls",
				"html",
				"cssls",
				"dockerls",
				"yamlls",
				"tailwindcss",
				"svelte",
				"pyright",
				"graphql",
				"prismals",
				"sqls",
				"emmet_ls",
				"eslint",
			},
			automatic_enable = false,
		},
	},
}
