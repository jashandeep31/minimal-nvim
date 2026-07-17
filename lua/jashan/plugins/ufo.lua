return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		config = function()
			-- UFO supplies folds from LSP, falling back to indentation when needed.
			vim.opt.foldcolumn = "auto:2"
			vim.opt.fillchars:append({ foldinner = "│" })
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true
			vim.opt.viewoptions = { "folds", "cursor", "curdir", "slash", "unix" }

			require("ufo").setup({
				provider_selector = function()
					return { "lsp", "indent" }
				end,
			})

			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end, { desc = "Peek fold or show hover" })

			-- Views are saved per file, which also keeps fold layouts separate per project.
			local view_group = vim.api.nvim_create_augroup("PersistentFolds", { clear = true })
			local function is_file_buffer(bufnr)
				return vim.bo[bufnr].buftype == "" and vim.api.nvim_buf_get_name(bufnr) ~= ""
			end

			vim.api.nvim_create_autocmd("BufWinLeave", {
				group = view_group,
				callback = function(args)
					if is_file_buffer(args.buf) then
						vim.api.nvim_buf_call(args.buf, function()
							vim.cmd("silent! mkview!")
						end)
					end
				end,
			})

			vim.api.nvim_create_autocmd("BufWinEnter", {
				group = view_group,
				callback = function(args)
					if is_file_buffer(args.buf) then
						vim.schedule(function()
							if vim.api.nvim_buf_is_valid(args.buf) then
								vim.api.nvim_buf_call(args.buf, function()
									vim.cmd("silent! loadview")
								end)
							end
						end)
					end
				end,
			})
		end,
	},
}
