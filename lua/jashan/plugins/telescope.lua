return {
 'nvim-telescope/telescope.nvim',
   dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
      { '<leader><leader>', function() require('telescope.builtin').find_files() end, desc = 'Find Files (Alt)' },

    }
}
