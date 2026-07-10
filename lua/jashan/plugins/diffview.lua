return {
  "sindrets/diffview.nvim",
  event = "BufReadPre",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>ld", "<cmd>DiffviewFileHistory --base=LOCAL %<CR>", desc = "Diff File History vs Local" },
    { "<leader>gd", "<cmd>DiffviewOpen<CR>",          desc = "Diff View (Global)" },
    { "<leader>lx", "<cmd>DiffviewClose<CR>",         desc = "Close Diff View" },
  },
}
