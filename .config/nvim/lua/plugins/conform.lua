return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt", lsp_format = "fallback" },
			go = { "goimports", "golines", "gofmt" },
			javascript = { "prettier", stop_after_first = true },
			typescript = { "prettier" },
		},
	},
}
