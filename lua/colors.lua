local vim = vim

local M = {}

function M.color()
	-- Nord colrscheme
	vim.g.nord_contrast = true
	vim.g.nord_borders = true
	vim.g.nord_disable_background = false
	vim.g.nord_italic = true
	vim.g.nord_uniform_diff_background = true
	-- vim.cmd [[
	-- syntax on
	-- filetype plugin indent on
	-- ]]

	-- Opaque Background (Comment out to use terminal's profile)
	vim.g.indentLine_color_gui = "#363949"
	vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

	vim.opt.termguicolors = true

	vim.cmd("colorscheme tokyonight")
end
return M
