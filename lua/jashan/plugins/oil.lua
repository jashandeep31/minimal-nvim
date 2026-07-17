return {
  "stevearc/oil.nvim",
  lazy = false,
  cmd = {
    "Oil",
    "OilExplorer",
  },
  keys = {
    {
      "<leader>ee",
      function()
        require("oil").toggle_float()
      end,
      desc = "Toggle Explorer",
    },
    {
      "<leader>ef",
      function()
        local current_file = vim.fn.expand("%:p")

        if current_file == "" then
          require("oil").open_float()
          return
        end

        require("oil").open_float(current_file)
      end,
      desc = "Reveal Current File",
    },
    {
      "<leader>e",
      function()
        require("oil").open_float()
      end,
      desc = "Focus Explorer",
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    vim.api.nvim_create_user_command("OilExplorer", function(opts)
      local path = opts.args ~= "" and opts.args or nil
      require("oil").open_float(path)
    end, {
      bar = true,
      complete = "dir",
      force = true,
      nargs = "?",
      desc = "Open Oil Explorer",
    })
  end,
}
