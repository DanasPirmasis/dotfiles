local group = vim.api.nvim_create_augroup("KittyConfig", { clear = true })

-- Remove padding on Neovim start
vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		os.execute("kitty @ set-spacing padding=0")
		os.execute("kitty @ set-font-size 11")
	end,
})

-- Reset padding on Neovim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = group,
	callback = function()
		os.execute("kitty @ set-spacing padding=25")
		os.execute("kitty @ set-font-size 10")
	end,
})
