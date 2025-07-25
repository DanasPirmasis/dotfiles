-- resize neovim split when terminal is resized
vim.api.nvim_command("autocmd VimResized * wincmd =")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, silent = true, desc = "LSP: " .. desc })
		end

		map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("gi", vim.lsp.buf.implementation, "Goto implementation")
		-- map("gi", "<cmd>Telescope lsp_implementations<CR>", "Goto Declaration")
		map("gd", "<cmd>Telescope lsp_definitions<CR>", "Go to definitions")

		local wk = require("which-key")
		wk.add({
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
			{ "<leader>cA", vim.lsp.buf.range_code_action, desc = "Range Code Actions" },
			{ "<leader>cf", vim.lsp.buf.format, desc = "Format" },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename all references" },
			{ "<leader>Wa", vim.lsp.buf.add_workspace_folder, desc = "Workspace Add Folder" },
			{ "<leader>Wr", vim.lsp.buf.remove_workspace_folder, desc = "Workspace Remove Folder" },
			{
				"<leader>Wl",
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				desc = "Workspace List Folders",
			},
		})

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
