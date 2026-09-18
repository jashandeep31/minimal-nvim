return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- {
  -- 	"sainnhe/gruvbox-material",
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	config = function()
  -- 		-- Optionally configure and load the colorscheme
  -- 		-- directly inside the plugin declaration.
  -- 		vim.g.gruvbox_material_enable_italic = true
  -- 		vim.cmd.colorscheme("gruvbox-material")
  -- 		-- hard
  -- 		vim.g.gruvbox_material_background = "hard"
  -- 	end,
  -- }
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "storm",     -- Choices: "storm", "moon", "night", "day"
  --     transparent = false, -- Enable transparent background
  --     terminal_colors = true,
  --   },
  --   config = function(_, opts)
  --     require("tokyonight").setup(opts)
  --     vim.cmd("colorscheme tokyonight")
  --   end,
  -- },
  --
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
  -- {
  --   "EdenEast/nightfox.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("nightfox").setup({
  --       palettes = {
  --         nightfox = {
  --           bg1 = "#000000",
  --         },
  --       },
  --     })
  --
  --     vim.cmd("colorscheme nightfox")
  --   end,
  -- },
}
