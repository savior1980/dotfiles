local M = {}

function M.setup()
	-- Bootstrap lazy.nvim
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--branch=stable",
			lazyrepo,
			lazypath,
		})
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)

	vim.opt.termguicolors = true

	-- Setup lazy.nvim
	require("lazy").setup({
		spec = {
			-- add your plugins here
			"folke/neodev.nvim",
			"folke/which-key.nvim",
			{ "folke/neoconf.nvim", cmd = "Neoconf" },
			"nvim-lualine/lualine.nvim",
			"kyazdani42/nvim-web-devicons",
			"akinsho/bufferline.nvim",
			"ryanoasis/vim-devicons",
			"shaunsingh/nord.nvim",
			"maksimr/vim-jsbeautify",
			--"ghifarit53/tokyonight-vim",
			"folke/tokyonight.nvim",
			{ "rose-pine/neovim", name = "rose-pine" },
			"EdenEast/nightfox.nvim",
			"marko-cerovac/material.nvim",
			"sbdchd/neoformat",
			{ "prettier/vim-prettier", cmd = "Yarn install" },
			"stevearc/dressing.nvim",
			"kyazdani42/nvim-tree.lua", -- Nerdtree replacement
			"sheerun/vim-polyglot",
			--"chrisbra/Colorizer",
			"vim-scripts/loremipsum", --  "SirVer/ultisnips",
			"honza/vim-snippets",
			"dkarter/bullets.vim",
			{ "godlygeek/tabular", ft = "markdown" },
			{ "plasticboy/vim-markdown", ft = "markdown" },
			"karb94/neoscroll.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			{ "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
			"lukas-reineke/indent-blankline.nvim",
			{ "echasnovski/mini.indentscope", version = "*" },
			"p00f/nvim-ts-rainbow",
			"ggandor/lightspeed.nvim",
			"ethanholz/nvim-lastplace",
			"windwp/nvim-ts-autotag", -- From Vim
			"hashrocket/vim-macdown",
			"junegunn/vim-peekaboo",
			"SidOfc/mkdx",
			"norcalli/nvim-colorizer.lua",
			"tpope/vim-unimpaired",
			{
				"folke/trouble.nvim",
				requires = "kyazdani42/nvim-web-devicons",
				config = function()
					require("trouble").setup({
						{
							position = "bottom", -- position of the list can be: bottom, top, left, right
							height = 10, -- height of the trouble list when position is top or bottom
							width = 50, -- width of the list when position is left or right
							icons = true, -- use devicons for filenames
							mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
							fold_open = "", -- icon used for open folds
							fold_closed = "", -- icon used for closed folds
							group = true, -- group results by file
							padding = true, -- add an extra new line on top of the list
							action_keys = { -- key mappings for actions in the trouble list
								-- map to {} to remove a mapping, for example:
								-- close = {},
								close = "q", -- close the list
								cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
								refresh = "r", -- manually refresh
								jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
								open_split = { "<c-x>" }, -- open buffer in new split
								open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
								open_tab = { "<c-t>" }, -- open buffer in new tab
								jump_close = { "o" }, -- jump to the diagnostic and close the list
								toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
								toggle_preview = "P", -- toggle auto_preview
								hover = "K", -- opens a small popup with the full multiline message
								preview = "p", -- preview the diagnostic location
								close_folds = { "zM", "zm" }, -- close all folds
								open_folds = { "zR", "zr" }, -- open all folds
								toggle_fold = { "zA", "za" }, -- toggle fold of current file
								previous = "k", -- preview item
								next = "j", -- next item
							},
							indent_lines = true, -- add an indent guide below the fold icons
							auto_open = false, -- automatically open the list when you have diagnostics
							auto_close = false, -- automatically close the list when you have no diagnostics
							auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
							auto_fold = false, -- automatically fold a file trouble list at creation
							auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
							signs = {
								-- icons / text used for a diagnostic
								error = "",
								warning = "",
								hint = "",
								information = "",
								other = "﫠",
							},
							use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
						},
					})
				end,
			},
			{
				"folke/snacks.nvim",
				priority = 1000,
				lazy = false,
				--@type snacks.Config
				opts = {
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
					bigfile = { enabled = true },
					dashboard = { enabled = true },
					indent = { enabled = true },
					input = { enabled = true },
					notifier = { enabled = true },
					quickfile = { enabled = true },
					scroll = { enabled = true },
					statuscolumn = { enabled = true },
					words = { enabled = true },
				},
			},
			{
				"williamboman/mason.nvim",
				dependencies = {
					"williamboman/mason-lspconfig.nvim",
					"WhoIsSethDaniel/mason-tool-installer.nvim",
				},
				config = function()
					-- import mason
					local mason = require("mason")
					--local path = "$HOME/.config/nvim"
					--local path = require("mason-core.path")
					-- import mason-lspconfig
					local mason_lspconfig = require("mason-lspconfig")

					local mason_tool_installer = require("mason-tool-installer")

					-- enable mason and configure icons
					mason.setup({
						ui = {
							icons = {
								package_installed = "✓",
								package_pending = "➜",
								package_uninstalled = "✗",
							},
							-- border = { "rounded" },
						},
						--install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
						install_root_dir = vim.fn.stdpath("data") .. "/mason",
						---@since 1.0.0
						-- Where Mason should put its bin location in your PATH. Can be one of:
						-- - "prepend" (default, Mason's bin location is put first in PATH)
						-- - "append" (Mason's bin location is put at the end of PATH)
						-- - "skip" (doesn't modify PATH)
						---@type '"prepend"' | '"append"' | '"skip"'
						PATH = "prepend",

						---@since 1.0.0
						-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
						-- debugging issues with package installations.
						log_level = vim.log.levels.INFO,

						---@since 1.0.0
						-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
						-- packages that are requested to be installed will be put in a queue.
						max_concurrent_installers = 4,

						---@since 1.0.0
						-- [Advanced setting]
						-- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
						-- multiple registries, the registry listed first will be used.
						registries = {
							"github:mason-org/mason-registry",
						},

						---@since 1.0.0
						-- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
						-- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
						-- Builtin providers are:
						--   - mason.providers.registry-api  - uses the https://api.mason-registry.dev API
						--   - mason.providers.client        - uses only client-side tooling to resolve metadata
						providers = {
							"mason.providers.registry-api",
							"mason.providers.client",
						},

						github = {
							---@since 1.0.0
							-- The template URL to use when downloading assets from GitHub.
							-- The placeholders are the following (in order):
							-- 1. The repository (e.g. "rust-lang/rust-analyzer")
							-- 2. The release version (e.g. "v0.3.0")
							-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
							download_url_template = "https://github.com/%s/releases/download/%s/%s",
						},

						pip = {
							---@since 1.0.0
							-- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
							upgrade_pip = false,

							---@since 1.0.0
							-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
							-- and is not recommended.
							--
							-- Example: { "--proxy", "https://proxyserver" }
							install_args = {},
						},
					})

					mason_lspconfig.setup({
						-- list of servers for mason to install
						ensure_installed = {
							"lua_ls",
							"pyright",
							"ruff", -- "tsserver",
							"eslint",
							"tailwindcss",
							"emmet_language_server",
							"jsonls",
						},
						automatic_installation = true,
					})
					mason_lspconfig.setup_handlers({
						-- Will be called for each installed server that doesn't have
						-- a dedicated handler.
						--
						function(server_name) -- default handler (optional)
							-- https://github.com/neovim/nvim-lspconfig/pull/3232
							if server_name == "tsserver" then
								server_name = "ts_ls"
							end
							local capabilities = require("cmp_nvim_lsp").default_capabilities()
							require("lspconfig")[server_name].setup({

								capabilities = capabilities,
							})
						end,
					})
					mason_tool_installer.setup({
						ensure_installed = {
							"prettier", -- prettier formatter
							"stylua", -- lua formatter
							"isort", -- python formatter
							"black", -- python formatter
						},
					})
				end,
			},
			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
				dependencies = {
					"hrsh7th/cmp-buffer", -- source for text in buffer
					"hrsh7th/cmp-path", -- source for file system paths
					{
						"L3MON4D3/LuaSnip",
						-- follow latest release.
						version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
						-- install jsregexp (optional!).
						build = "make install_jsregexp",
					},
					"saadparwaiz1/cmp_luasnip", -- for autocompletion
					"rafamadriz/friendly-snippets", -- useful snippets
					"onsails/lspkind.nvim", -- vs-code like pictograms
				},
				config = function()
					local cmp = require("cmp")

					local luasnip = require("luasnip")

					local lspkind = require("lspkind")

					-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
					require("luasnip.loaders.from_vscode").lazy_load()

					cmp.setup({
						completion = {
							completeopt = "menu,menuone,preview,noselect",
						},
						snippet = { -- configure how nvim-cmp interacts with snippet engine
							expand = function(args)
								luasnip.lsp_expand(args.body)
							end,
						},
						mapping = cmp.mapping.preset.insert({
							["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
							["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
							["<C-b>"] = cmp.mapping.scroll_docs(-4),
							["<C-f>"] = cmp.mapping.scroll_docs(4),
							["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
							["<C-e>"] = cmp.mapping.abort(), -- close completion window
							["<CR>"] = cmp.mapping.confirm({ select = false }),
						}),
						-- sources for autocompletion
						sources = cmp.config.sources({
							{ name = "luasnip" }, -- snippets
							{ name = "buffer" }, -- text within current buffer
							{ name = "path" }, -- file system paths
						}),

						-- configure lspkind for vs-code like pictograms in completion menu
						formatting = {
							format = lspkind.cmp_format({
								maxwidth = 50,
								ellipsis_char = "…",
							}),
						},
					})
				end,
			},

			-- formatting
			{
				"stevearc/conform.nvim",
				event = { "BufReadPre", "BufNewFile" },
				config = function()
					local conform = require("conform")

					conform.setup({
						formatters_by_ft = {
							javascript = { "prettier" },
							typescript = { "prettier" },
							javascriptreact = { "prettier" },
							typescriptreact = { "prettier" },
							svelte = { "prettier" },
							css = { "prettier" },
							html = { "prettier" },
							json = { "prettier" },
							yaml = { "prettier" },
							markdown = { "prettier" },
							graphql = { "prettier" },
							liquid = { "prettier" },
							lua = { "stylua" },
							python = { "isort", "black" },
						},
						format_on_save = {
							lsp_fallback = true,
							async = false,
							timeout_ms = 1000,
						},
					})

					vim.keymap.set({ "n", "v" }, "<leader>mp", function()
						conform.format({
							lsp_fallback = true,
							async = false,
							timeout_ms = 1000,
						})
					end, { desc = "Format file or range (in visual mode)" })
				end,
			},
			{
				"kylechui/nvim-surround",
				config = function()
					require("nvim-surround").setup({
						-- Configuration here, or leave empty to use defaults
					})
				end,
			}, -- NerdCommenter replacement
			{
				"numToStr/Comment.nvim",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
				config = function()
					-- import comment plugin safely
					local comment = require("Comment")

					local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

					-- enable comment
					comment.setup({
						-- for commenting tsx, jsx, svelte, html files
						pre_hook = ts_context_commentstring.create_pre_hook(),
					})
				end,
			},
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup({})
				end,
			},
			{
				"neovim/nvim-lspconfig",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = {
					"hrsh7th/cmp-nvim-lsp",
					{ "antosha417/nvim-lsp-file-operations", config = true },
					--	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
					"williamboman/mason.nvim",
					{ "folke/neodev.nvim", opts = {} },
				},
				config = function()
					-- import lspconfig plugin
					local lspconfig = require("lspconfig")

					-- import mason_lspconfig plugin
					local mason_lspconfig = require("mason-lspconfig")

					-- import cmp-nvim-lsp plugin
					local cmp_nvim_lsp = require("cmp_nvim_lsp")

					local keymap = vim.keymap -- for conciseness

					vim.api.nvim_create_autocmd("LspAttach", {
						group = vim.api.nvim_create_augroup("UserLspConfig", {}),
						callback = function(ev)
							-- Buffer local mappings.
							-- See `:help vim.lsp.*` for documentation on any of the below functions
							local opts = { buffer = ev.buf, silent = true }

							-- set keybinds
							opts.desc = "Show LSP references"
							keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

							opts.desc = "Go to declaration"
							keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

							opts.desc = "Show LSP definitions"
							keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

							opts.desc = "Show LSP implementations"
							keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

							opts.desc = "Show LSP type definitions"
							keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

							opts.desc = "See available code actions"
							keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

							opts.desc = "Smart rename"
							keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

							opts.desc = "Show buffer diagnostics"
							keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

							opts.desc = "Show line diagnostics"
							keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

							opts.desc = "Go to previous diagnostic"
							keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

							opts.desc = "Go to next diagnostic"
							keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

							opts.desc = "Show documentation for what is under cursor"
							keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

							opts.desc = "Restart LSP"
							keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
						end,
					})

					-- used to enable autocompletion (assign to every lsp server config)
					local capabilities = cmp_nvim_lsp.default_capabilities()

					-- Change the Diagnostic symbols in the sign column (gutter)
					-- (not in youtube nvim video)
					local signs = {
						Error = " ",
						Warn = " ",
						Hint = "󰠠 ",
						Info = " ",
					}
					for type, icon in pairs(signs) do
						local hl = "DiagnosticSign" .. type
						vim.fn.sign_define(hl, {
							text = icon,
							texthl = hl,
							numhl = "",
						})
					end

					mason_lspconfig.setup_handlers({
						-- default handler for installed servers
						function(server_name)
							lspconfig[server_name].setup({
								capabilities = capabilities,
							})
						end,
						["svelte"] = function()
							-- configure svelte server
							lspconfig["svelte"].setup({
								capabilities = capabilities,
								on_attach = function(client)
									vim.api.nvim_create_autocmd("BufWritePost", {
										pattern = { "*.js", "*.ts" },
										callback = function(ctx)
											-- Here use ctx.match instead of ctx.file
											client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
										end,
									})
								end,
							})
						end,
						["graphql"] = function()
							-- configure graphql language server
							lspconfig["graphql"].setup({
								capabilities = capabilities,
								filetypes = {
									"graphql",
									"gql",
									"svelte",
									"typescriptreact",
									"javascriptreact",
								},
							})
						end,
						["emmet_ls"] = function()
							-- configure emmet language server
							lspconfig["emmet_ls"].setup({
								capabilities = capabilities,
								filetypes = {
									"html",
									"typescriptreact",
									"javascriptreact",
									"css",
									"sass",
									"scss",
									"less",
									"svelte",
								},
							})
						end,
						["lua_ls"] = function()
							-- configure lua server (with special settings)
							lspconfig["lua_ls"].setup({
								capabilities = capabilities,
								settings = {
									Lua = {
										-- make the language server recognize "vim" global
										diagnostics = { globals = { "vim" } },
										completion = { callSnippet = "Replace" },
									},
								},
							})
						end,
					})
				end,
			},
		},
		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		install = { colorscheme = { "habamax" } },
		-- automatically check for plugin updates
		checker = { enabled = true },
	})

	-- requires
	require("mason").setup()
	require("mason-lspconfig").setup()

	require("nvim-tree").setup({
		disable_netrw = false,
		hijack_netrw = true,
		-- open_on_setup = false,
		-- ignore_ft_on_setup = {},
		auto_reload_on_write = true,
		open_on_tab = false,
		hijack_cursor = false,
		update_cwd = false,
		hijack_unnamed_buffer_when_opening = false,
		hijack_directories = { enable = true, auto_open = true },
		diagnostics = {
			enable = false,
			icons = { hint = "", info = "", warning = "", error = "" },
		},
		update_focused_file = {
			enable = false,
			update_cwd = false,
			ignore_list = {},
		},
		system_open = { cmd = nil, args = {} },
		filters = { dotfiles = false, custom = {} },
		git = { enable = true, ignore = true, timeout = 500 },
		view = {
			width = 30,
			-- height = 30,
			-- hide_root_folder = false,
			side = "left",
			preserve_window_proportions = false,
			-- mappings = {custom_only = false, list = {}},
			number = false,
			relativenumber = false,
			signcolumn = "yes",
		},
		trash = { cmd = "trash", require_confirm = true },
		actions = {
			change_dir = { enable = true, global = false },
			open_file = {
				quit_on_open = false,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = { filetype = { "notify", "packer", "qf" } },
				},
			},
		},
	})

	require("nvim-treesitter.configs").setup({
		highlight = {
			-- ...
		},
		-- ...
		autotag = { enable = true },

		rainbow = {
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = 50000, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
		auto_install = true,
	})

	require("lualine").setup({
		options = {
			-- theme = theme,
			component_separators = "",
			section_separators = { left = "", right = "" },
			-- section_separators = {left = '', right = ''}
		},
	})

	require("bufferline").setup({
		options = {
			-- indicator = {
			-- 	icon = "|", -- this should be omitted if indicator style is not 'icon'
			-- 	style = "icon",
			-- },
			buffer_close_icon = "", -- '',
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			separator_style = "slant",
			themable = true,
			transparent_background = true,
		},
	})
	-- necessary to change the background color to match the icon background in bufferline
	require("tokyonight").setup({
		on_highlights = function(hl, c)
			hl.Normal = { bg = "#14161B" }
			hl.BufferlineFileIcon = {
				bg = c.bg_dark,
			}
		end,
	})

	-- neoscroll
	require("neoscroll").setup()

	-- identlines
	require("ibl").setup() -- {space_char_blankline = " "}
	require("mini.indentscope").setup()

	-- lastplace
	require("nvim-lastplace").setup({
		lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
		lastplace_ignore_filetype = {
			"gitcommit",
			"gitrebase",
			"svn",
			"hgcommit",
		},
		lastplace_open_folds = true,
	})

	require("lightspeed").setup({
		ignore_case = false,
		exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
		--- s/x ---
		jump_to_unique_chars = { safety_timeout = 400 },
		match_only_the_start_of_same_char_seqs = true,
		force_beacons_into_match_width = false,
		-- Display characters in a custom way in the highlighted matches.
		substitute_chars = { ["\r"] = "¬" },
		-- These keys are captured directly by the plugin at runtime.
		special_keys = {
			next_match_group = "<space>",
			prev_match_group = "<tab>",
		},
		--- f/t ---
		limit_ft_matches = 4,
		repeat_ft_with_target_char = false,
	})

	require("nightfox").setup({
		options = {
			-- Compiled file's destination location
			compile_path = vim.fn.stdpath("cache") .. "/nightfox",
			compile_file_suffix = "_compiled", -- Compiled file suffix
			transparent = false, -- Disable setting background
			terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
			dim_inactive = false, -- Non focused panes set to alternative background
			module_default = true, -- Default enable value for modules
			colorblind = {
				enable = false, -- Enable colorblind support
				simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
				severity = {
					protan = 0, -- Severity [0,1] for protan (red)
					deutan = 0, -- Severity [0,1] for deutan (green)
					tritan = 0, -- Severity [0,1] for tritan (blue)
				},
			},
			styles = { -- Style to be applied to different syntax groups
				comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
				conditionals = "NONE",
				constants = "NONE",
				functions = "NONE",
				keywords = "NONE",
				numbers = "NONE",
				operators = "NONE",
				strings = "NONE",
				types = "NONE",
				variables = "NONE",
			},
			inverse = { -- Inverse highlight for different types
				match_paren = false,
				visual = false,
				search = false,
			},
			modules = { -- List of various plugins and additional options
				-- ...
			},
		},
		palettes = {},
		specs = {},
		groups = {},
	})

	require("colorizer").setup()

	-- end requires
end

return M
