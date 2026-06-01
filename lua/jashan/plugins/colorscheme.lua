return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
	{
		"Shatur/neovim-ayu",
		name = "ayu",
		priority = 1000,
		config = function()
			require("ayu").setup({
				mirage = false, -- false = dark, true = mirage variant
				terminal = true,
				overrides = {},
			})
			require("ayu").colorscheme()
		end,
	},
}
