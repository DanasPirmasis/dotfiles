return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- Setup harpoon
		harpoon:setup()

		-- Basic keybindings
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle harpoon menu" })

		-- Navigate to specific files
		vim.keymap.set("n", "<C-1>", function()
			harpoon:list():select(1)
		end, { desc = "Go to harpoon file 1" })
		vim.keymap.set("n", "<C-2>", function()
			harpoon:list():select(2)
		end, { desc = "Go to harpoon file 2" })
		vim.keymap.set("n", "<C-3>", function()
			harpoon:list():select(3)
		end, { desc = "Go to harpoon file 3" })
		vim.keymap.set("n", "<C-4>", function()
			harpoon:list():select(4)
		end, { desc = "Go to harpoon file 4" })

		-- Navigate through list
		vim.keymap.set("n", "<S-Tab>", function()
			harpoon:list():prev()
		end, { desc = "Previous harpoon file" })
		vim.keymap.set("n", "<Tab>", function()
			harpoon:list():next()
		end, { desc = "Next harpoon file" })
	end,
}
