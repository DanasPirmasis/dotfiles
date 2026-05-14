return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		-- on_highlights = function(hl, c)
		-- 	local bg_darker = "#1f2335" -- or any hex color you prefer
		-- 	hl.NvimTreeNormal = { bg = bg_darker }
		-- 	hl.NvimTreeNormalNC = { bg = bg_darker }
		-- end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd([[colorscheme tokyonight]])
	end,
}
