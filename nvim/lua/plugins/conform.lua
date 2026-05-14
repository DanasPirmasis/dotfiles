return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	opts = {
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
	},
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
}
