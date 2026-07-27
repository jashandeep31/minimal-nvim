return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo", "ConformFormat" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			css = { "prettier" },
			scss = { "prettier" },
			less = { "prettier" },
			dockerfile = { "dockerfmt" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			python = { "isort", "black" },
			prisma = { "prismals" },
			go = { "goimports", "gofumpt" },
			sql = { "sql_formatter" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 2000,
			lsp_format = "fallback",
		},
	},
}
