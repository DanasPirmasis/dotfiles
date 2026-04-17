return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local nts = require("nvim-treesitter")

			nts.setup({})

			-- nts.install({
			-- 	"bash",
			-- 	"c",
			-- 	"css",
			-- 	"diff",
			-- 	"dockerfile",
			-- 	"gitignore",
			-- 	"go",
			-- 	"gomod",
			-- 	"gosum",
			-- 	"gowork",
			-- 	"html",
			-- 	"javascript",
			-- 	"json",
			-- 	"lua",
			-- 	"markdown",
			-- 	"markdown_inline",
			-- 	"query",
			-- 	"regex",
			-- 	"rust",
			-- 	"tsx",
			-- 	"typescript",
			-- 	"vim",
			-- 	"vimdoc",
			-- 	"yaml",
			-- })

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@parameter.inner"] = "v",
						["@function.outer"] = "v",
						["@conditional.outer"] = "V",
						["@loop.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			local selects = {
				["af"] = { "@function.outer", "around a function" },
				["if"] = { "@function.inner", "inner part of a function" },
				["ac"] = { "@class.outer", "around a class" },
				["ic"] = { "@class.inner", "inner part of a class" },
				["ai"] = { "@conditional.outer", "around an if statement" },
				["ii"] = { "@conditional.inner", "inner part of an if statement" },
				["al"] = { "@loop.outer", "around a loop" },
				["il"] = { "@loop.inner", "inner part of a loop" },
				["ap"] = { "@parameter.outer", "around parameter" },
				["ip"] = { "@parameter.inner", "inside a parameter" },
			}
			for lhs, spec in pairs(selects) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(spec[1], "textobjects")
				end, { desc = spec[2] })
			end

			local next_starts = {
				["]f"] = { "@function.outer", "Next function" },
				["]c"] = { "@class.outer", "Next class" },
				["]p"] = { "@parameter.inner", "Next parameter" },
			}
			for lhs, spec in pairs(next_starts) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					move.goto_next_start(spec[1], "textobjects")
				end, { desc = spec[2] })
			end

			local prev_starts = {
				["[f"] = { "@function.outer", "Previous function" },
				["[c"] = { "@class.outer", "Previous class" },
				["[p"] = { "@parameter.inner", "Previous parameter" },
			}
			for lhs, spec in pairs(prev_starts) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					move.goto_previous_start(spec[1], "textobjects")
				end, { desc = spec[2] })
			end
		end,
	},
}
