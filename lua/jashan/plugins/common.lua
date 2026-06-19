return {
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "tpope/vim-abolish",
    event = "VeryLazy",
    config = function()
      -- Optional: custom mappings (more discoverable)
      vim.keymap.set("n", "<leader>cs", "crs", { remap = true, desc = "snake_case" })
      vim.keymap.set("n", "<leader>cc", "crc", { remap = true, desc = "camelCase" })
      vim.keymap.set("n", "<leader>cp", "crp", { remap = true, desc = "PascalCase" })
      vim.keymap.set("n", "<leader>ck", "crk", { remap = true, desc = "kebab-case" })
      vim.keymap.set("n", "<leader>cu", "cru", { remap = true, desc = "UPPER_CASE" })
    end,
  },

  {
    "laytan/cloak.nvim",
    event = { "BufReadPre .env*", "BufNewFile .env*" },
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        patterns = {
          {
            file_pattern = ".env*",
            cloak_pattern = "=.+",
          },
        },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ce", "<cmd>CloakEnable<cr>", { desc = "Cloak Enable" })
      vim.keymap.set("n", "<leader>cd", "<cmd>CloakDisable<cr>", { desc = "Cloak Disable" })
      vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<cr>", { desc = "Cloak Toggle" })
      vim.keymap.set("n", "<leader>cp", "<cmd>CloakPreviewLine<cr>", { desc = "Cloak Preview Line" })

      -- Auto-enable cloak when leaving or entering a .env file
      local cloak_group = vim.api.nvim_create_augroup("CloakAutoEnable", { clear = true })
      vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "BufEnter" }, {
        group = cloak_group,
        pattern = ".env*",
        callback = function()
          pcall(vim.cmd, "CloakEnable")
        end,
      })
    end,
  },
  -- {
  -- 	"Exafunction/windsurf.vim",
  -- 	event = "InsertEnter",
  -- 	config = function()
  -- 		-- Change '<C-g>' here to any keycode you like.
  -- 		vim.keymap.set("i", "<C-g>", function()
  -- 			return vim.fn["codeium#Accept"]()
  -- 		end, { expr = true, silent = true })
  -- 		vim.keymap.set("i", "<Tab>", function()
  -- 			return vim.fn["codeium#Accept"]()
  -- 		end, { expr = true, silent = true })
  -- 		vim.keymap.set("i", "<Tab>", function()
  -- 			return vim.fn["codeium#Accept"]()
  -- 		end, { expr = true, silent = true })
  -- 		vim.keymap.set("i", "<C-;>", function()
  -- 			return vim.fn["codeium#CycleCompletions"](1)
  -- 		end, { expr = true, silent = true })
  -- 		vim.keymap.set("i", "<C-,>", function()
  -- 			return vim.fn["codeium#CycleCompletions"](-1)
  -- 		end, { expr = true, silent = true })
  -- 		vim.keymap.set("i", "<C-x>", function()
  -- 			return vim.fn["codeium#Clear"]()
  -- 		end, { expr = true, silent = true })
  -- 	end,
  -- },
  {
    -- mini.ai
    {
      "nvim-mini/mini.ai",
      event = "VeryLazy",
      opts = {
        n_lines = 500,
      },
    },

    -- mini.surround
    {
      "nvim-mini/mini.surround",
      event = "VeryLazy",
      opts = {},
    },
  },
}
