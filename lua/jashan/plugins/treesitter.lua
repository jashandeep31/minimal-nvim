return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local filetypes = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"javascript",
			"typescript",
			"tsx",
			"css",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"json",
			"prisma",
			"yaml",
		}
		require("nvim-treesitter").install(filetypes)
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf = args.buf
				local filetype = args.match
				local lang = vim.treesitter.language.get_lang(filetype)
				if lang and vim.treesitter.language.add(lang) then
					vim.treesitter.start(buf, lang)
				end
			end,
		})
	end,
}
