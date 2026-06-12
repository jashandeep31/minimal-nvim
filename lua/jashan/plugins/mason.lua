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
				"tailwindcss",
				"svelte",
				"pyright",
				"graphql",
				"prismals",
				"emmet_ls",
				"eslint",
			},
			automatic_enable = false,
		},
	},
}
