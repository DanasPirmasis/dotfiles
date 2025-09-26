return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, timeout_ms = 10000 })
			end,
			mode = { "n", "v" },
			desc = "Code Format",
		},
	},
	opts = {
		formatters = {
			prettier = {
				require_cwd = true,
				config_command = "--config",
				config_path = ".prettier.config.js",
			},
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = false,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "golines", "gofmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
		},
		notify_on_error = true,
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
