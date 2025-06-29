return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = {
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope-file-browser.nvim'
	},
	config = function()
	require('telescope').setup({
		extensions = {
			file_browser = {
			theme = "ivy",
			hijack_netrw = true,
			},
    },
  })
  require('telescope').load_extension('file_browser')
  end,
}
