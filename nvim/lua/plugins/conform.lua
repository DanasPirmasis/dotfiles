return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = false, timeout_ms = 10000, quiet = false, lsp_fallback = "never" })
			end,
			mode = { "n", "v" },
			desc = "Code Format",
		},
	},
	opts = {
		formatters = {
			prettier = {
				require_cwd = false,
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
			css = { "prettier" },
		},
		notify_on_error = true,
		log_level = vim.log.levels.DEBUG,
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
