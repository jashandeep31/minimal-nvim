return {
	{
		name = "jashan-lsp",
		dir = vim.fn.stdpath("config"),
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_blink, blink = pcall(require, "blink.cmp")

			if has_blink then
				capabilities = blink.get_lsp_capabilities(capabilities)
			end

			vim.lsp.config("*", { capabilities = capabilities })

			local servers = {
				lua_ls = {
					cmd = { "lua-language-server" },
					filetypes = { "lua" },
					root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								checkThirdParty = false,
								library = { vim.env.VIMRUNTIME },
							},
							telemetry = { enable = false },
						},
					},
				},
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_markers = { "go.work", "go.mod", ".git" },
					settings = {
						gopls = {
							staticcheck = true,
							gofumpt = true,
							usePlaceholders = true,
						},
					},
				},
				ts_ls = {
					cmd = { "typescript-language-server", "--stdio" },
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
					root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
					},
				},
				html = {
					cmd = { "vscode-html-language-server", "--stdio" },
					filetypes = { "html" },
					root_markers = { "package.json", ".git" },
				},
				cssls = {
					cmd = { "vscode-css-language-server", "--stdio" },
					filetypes = { "css", "scss", "less" },
					root_markers = { "package.json", ".git" },
				},
				dockerls = {
					cmd = { "docker-langserver", "--stdio" },
					filetypes = { "dockerfile" },
					root_markers = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml", ".git" },
				},
				tailwindcss = {
					cmd = { "tailwindcss-language-server", "--stdio" },
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"svelte",
					},
					root_markers = {
						"tailwind.config.js",
						"tailwind.config.cjs",
						"tailwind.config.mjs",
						"tailwind.config.ts",
						"postcss.config.js",
						"package.json",
						".git",
					},
				},
				svelte = {
					cmd = { "svelteserver", "--stdio" },
					filetypes = { "svelte" },
					root_markers = { "package.json", ".git" },
				},
				pyright = {
					cmd = { "pyright-langserver", "--stdio" },
					filetypes = { "python" },
					root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
				},
				graphql = {
					cmd = { "graphql-lsp", "server", "-m", "stream" },
					filetypes = { "graphql", "typescriptreact", "javascriptreact" },
					root_markers = { ".graphqlrc", ".graphqlrc.json", "graphql.config.js", "package.json", ".git" },
				},
				prismals = {
					cmd = { "prisma-language-server", "--stdio" },
					filetypes = { "prisma" },
					root_markers = { "schema.prisma", "package.json", ".git" },
				},
				sqls = {
					cmd = { "sqls", },
					filetypes = { "sql", },
					root_markers = { "config.yml", ".sqls.yml", ".sqls.yaml", ".git" },
				},
				emmet_ls = {
					cmd = { "emmet-ls", "--stdio" },
					filetypes = {
						"html",
						"css",
						"scss",
						"javascriptreact",
						"typescriptreact",
						"svelte",
					},
					root_markers = { "package.json", ".git" },
				},
				eslint = {
					cmd = { "vscode-eslint-language-server", "--stdio" },
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"svelte",
					},
					root_markers = {
						"eslint.config.js",
						".eslintrc",
						".eslintrc.js",
						".eslintrc.json",
						"package.json",
						".git",
					},
					settings = {
						eslint = {
							format = {
								enable = true,
							},
						},
					},
				},
			}

			local enabled_servers = {}

			for name, config in pairs(servers) do
				if vim.fn.executable(config.cmd[1]) == 1 then
					vim.lsp.config(name, config)
					table.insert(enabled_servers, name)
				end
			end

			vim.lsp.enable(enabled_servers)

			vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
				config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
				return vim.lsp.handlers.hover(err, result, ctx, config)
			end

			vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
				config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
				return vim.lsp.handlers.signature_help(err, result, ctx, config)
			end

			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = true,
				float = {
					border = "rounded",
					source = "if_many",
				},
				underline = true,
				virtual_text = {
					spacing = 2,
					source = "if_many",
					prefix = "E",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "E",
						[vim.diagnostic.severity.WARN] = "W",
						[vim.diagnostic.severity.INFO] = "I",
						[vim.diagnostic.severity.HINT] = "H",
					},
				},
			})

			local function smart_jump_new_tab(method)
				return function()
					local params = vim.lsp.util.make_position_params(0, "utf-8")
					vim.lsp.buf_request(0, method, params, function(err, result)
						if err then
							vim.notify("LSP error: " .. err.message)
							return
						end

						if not result or vim.tbl_isempty(result) then
							vim.notify("No result")
							return
						end

						local locations = vim.islist(result) and result or { result }

						if #locations == 1 then
							vim.lsp.util.show_document(locations[1], "utf-8", { focus = true })
						else
							vim.cmd("tabnew")
							vim.lsp.util.set_qflist(vim.lsp.util.locations_to_items(locations))
							vim.cmd("copen")
						end
					end)
				end
			end

			local function jump_diagnostic(opts)
				return function()
					vim.diagnostic.jump(opts)
					vim.schedule(function()
						vim.diagnostic.open_float({
							border = "rounded",
							focus = false,
							scope = "line",
							source = "if_many",
						})
					end)
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("jashan_lsp", { clear = true }),
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "sqls" then
						local ok, sqls = pcall(require, "sqls")
						if ok then
							sqls.on_attach(client, bufnr)
						end
					end

					local function map(lhs, rhs, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, lhs, rhs, {
							buffer = bufnr,
							desc = desc,
							silent = true,
						})
					end

					map("gd", function()
						require("telescope.builtin").lsp_definitions()
					end, "LSP: Definitions")
					map("gr", function()
						require("telescope.builtin").lsp_references()
					end, "LSP: References")

					map("gD", smart_jump_new_tab("textDocument/declaration"), "LSP: Declaration")
					map("gi", smart_jump_new_tab("textDocument/implementation"), "LSP: Implementation")

					map("K", vim.lsp.buf.hover, "LSP: Hover")
					map("<C-k>", vim.lsp.buf.signature_help, "LSP: Signature Help", { "n", "i" })
					map("<leader>cr", vim.lsp.buf.rename, "LSP: Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action", { "n", "v" })

					map("]d", jump_diagnostic({ count = 1 }), "Next Diagnostic")

					map("[d", jump_diagnostic({ count = -1 }), "Prev Diagnostic")

					map(
						"]e",
						jump_diagnostic({
							count = 1,
							severity = vim.diagnostic.severity.ERROR,
						}),
						"Next Error"
					)

					map(
						"[e",
						jump_diagnostic({
							count = -1,
							severity = vim.diagnostic.severity.ERROR,
						}),
						"Prev Error"
					)

					map(
						"]w",
						jump_diagnostic({
							count = 1,
							severity = vim.diagnostic.severity.WARN,
						}),
						"Next Warning"
					)

					map(
						"[w",
						jump_diagnostic({
							count = -1,
							severity = vim.diagnostic.severity.WARN,
						}),
						"Prev Warning"
					)
				end,
			})
		end,
	},
}
