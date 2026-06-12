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
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
			-- hard
			vim.g.gruvbox_material_background = "hard"
		end,
	},
	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	name = "ayu",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("ayu").setup({
	-- 			mirage = false, -- false = dark, true = mirage variant
	-- 			terminal = true,
	-- 			overrides = {},
	-- 		})
	-- 		require("ayu").colorscheme()
	-- 	end,
	-- },
}
