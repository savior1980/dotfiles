local vim = vim

local M = {}

function M.keys()

vim.g.mapleader = ','

vim.api.nvim_set_keymap('n','<Leader>q',':NvimTreeToggle<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<Leader>\\','<Leader>q',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<Leader>r',':so ~/.config/nvim/init.lua<CR>',{ noremap = true, silent = false })

vim.api.nvim_set_keymap('n','<Leader>w',':w!<CR>',{ noremap = true, silent = false })
vim.api.nvim_set_keymap('i','<Leader>w','<Esc>:w!<CR>',{ noremap = false, silent = false })
--vim.api.nvim_set_keymap('n','<Leader>wq',':w!|bd!<CR>',{ noremap = true, silent = false })

vim.api.nvim_set_keymap('n','<Leader>s','<C-w>s<C-w>j:terminal<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<Leader>h',':RainbowParentheses!!<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<Leader><CR><Leader>',':noh<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<Leader>.',':bnext<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<Leader><Leader>',':bprevious<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<Leader><Leader><Leader>',':Telescope find_files<CR>',{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n','<Leader>f',':Telescope oldfiles<CR>',{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n','<Leader>ff',':Telescope find_files<CR>',{ noremap = true, silent = false })
vim.api.nvim_set_keymap('n','<Leader>fg',':Telescope live_grep<CR>',{ noremap = true, silent = false })
vim.api.nvim_set_keymap('n','<Leader>fb',':Telescope buffers<CR>',{ noremap = true, silent = false })
vim.api.nvim_set_keymap('n','<Leader>fh',':Telescope help_tags<CR>',{ noremap = true, silent = false })

vim.cmd[[iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>]]

vim.api.nvim_set_keymap('','<space>','/',{ noremap = false, silent = false })
vim.api.nvim_set_keymap('','<C-space>','?',{ noremap = false, silent = false })

vim.api.nvim_set_keymap('','<Leader><CR>',':noh<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('','<Leader>ba',':bufdo bd<CR>',{ noremap = true, silent = true })

vim.api.nvim_set_keymap('','<Leader>te',':tabedit <C-r>=expand("%:p:h")<cr>/',{ noremap = true, silent = false })
vim.api.nvim_set_keymap('','<Leader>cd',':cd %:p:h<CR>:pwd<CR>',{ noremap = true, silent = false})

--spellchecking
vim.api.nvim_set_keymap('','<Leader>ss',':setlocal spell!<CR>',{ noremap = true, silent = false})
--next/previous
vim.api.nvim_set_keymap('','<Leader>sn',']s',{ noremap = true, silent = false})
vim.api.nvim_set_keymap('','<Leader>sp','[s',{ noremap = true, silent = false})
--add 
vim.api.nvim_set_keymap('','<Leader>sa','zg',{ noremap = true, silent = false})
--replace
vim.api.nvim_set_keymap('','<Leader>sr','z=',{ noremap = true, silent = false})

-- LSP diagnostics
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

--Commenter
vim.api.nvim_set_keymap('','<Leader>cc','gcc',{noremap=false, silent=false})
-- Trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

end

return M

