return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			python = { "isort", "black" },
			prisma = { "prismals" },
			go = { "goimports", "gofumpt" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 2000,
			lsp_format = "fallback",
		},
	},
}
