local vim = vim

local M = {}

function M.keys()
	local keymap = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }

	vim.g.mapleader = ","

	keymap("n", "<Leader>q", ":NvimTreeToggle<CR>", opts)
	keymap("n", "<Leader>\\", "<Leader>q", opts)
	keymap("n", "<Leader>r", ":so ~/.config/nvim/init.lua<CR>", { noremap = true, silent = false })
	keymap("n", "<Leader>w", ":w!<CR>", { noremap = true, silent = false })
	keymap("i", "<Leader>w", "<Esc>:w!<CR>", { noremap = false, silent = false })
	-- vim.api.nvim_set_keymap('n','<Leader>wq',':w!|bd!<CR>',{ noremap = true, silent = false })

	keymap("n", "<Leader>s", "<C-w>s<C-w>j:terminal<CR>", opts)
	keymap("n", "<Leader>h", ":RainbowParentheses!!<CR>", opts)
	-- keymap('n', '<Leader><CR><Leader>', ':noh<CR>', opts)
	keymap("n", "<Leader>.", ":bnext<CR>", opts)
	keymap("n", "<Leader><Leader>", ":bprevious<CR>", opts)
	keymap("n", "<Leader><Leader><Leader>", ":Telescope find_files<CR>", { noremap = true, silent = true })

	keymap("n", "<Leader>o", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = false })
	keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = false })
	keymap("n", "<Leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = false })
	keymap("n", "<Leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = false })

	keymap("", "<space>", "/", { noremap = false, silent = false })
	keymap("", "<C-space>", "?", { noremap = false, silent = false })

	keymap("", "<Leader><CR>", ":noh<CR>", { noremap = true, silent = true })
	keymap("", "<Leader>ba", ":bufdo bd<CR>", { noremap = true, silent = true })

	keymap("", "<Leader>te", ':tabedit <C-r>=expand("%:p:h")<cr>/', { noremap = true, silent = false })
	keymap("", "<Leader>cd", ":cd %:p:h<CR>:pwd<CR>", { noremap = true, silent = false })

	-- spellchecking
	keymap("", "<Leader>ss", ":setlocal spell!<CR>", { noremap = true, silent = false })
	-- next/previous
	keymap("", "<Leader>sn", "]s", { noremap = true, silent = false })
	keymap("", "<Leader>sp", "[s", { noremap = true, silent = false })
	-- add
	keymap("", "<Leader>sa", "zg", { noremap = true, silent = false })
	-- replace
	keymap("", "<Leader>sr", "z=", { noremap = true, silent = false })

	-- LSP diagnostics
	keymap("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
	keymap("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
	keymap("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
	-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
	keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
	-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
	-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

	-- Format
	keymap("n", "<Leader>f", ":Neoformat<CR>", { noremap = true, silent = true })

	-- Commenter
	keymap("", "<Leader>cc", "gcc", { noremap = false, silent = false })
	-- Trouble
	keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
	keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
	keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
	keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
	keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
	keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

	keymap("n", "<C-x>", ":bdelete<CR>", opts)
	keymap("n", "<C-t>", ":tabnew<CR>", opts)
	keymap("n", "<leader>a", "ggVG", opts)

	vim.cmd([[iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>]])

	if vim.g.neovide then
		vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
		vim.keymap.set("v", "<D-c>", '"+y') -- Copy
		vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
		vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
		vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
		vim.keymap.set("i", "<D-v>", "<C-R>+") -- Paste insert mode
		vim.keymap.set("n", "<D-a>", "ggVG", opts)
	end

	-- keybindings for luasnip
	local ls = require("luasnip")

	vim.keymap.set({ "i" }, "<C-K>", function()
		ls.expand()
	end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<Tab>", function()
		ls.jump(1)
	end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<C-J>", function()
		ls.jump(-1)
	end, { silent = true })

	vim.keymap.set({ "i", "s" }, "<C-E>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end, { silent = true })

	-- Move selected lines up
	vim.api.nvim_set_keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

	-- Move selected lines down
	vim.api.nvim_set_keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

	-- Not strictly keybinding, more of a setting... but I think it belongs here
	vim.opt.clipboard = "unnamed,unnamedplus"
end

return M
