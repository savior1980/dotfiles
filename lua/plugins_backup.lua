local vim = vim

local M = {}

function M.setup()

    local Plug = vim.fn['plug#']

    vim.call('plug#begin','~/.config/nvim/plugged')

    -- Aesthetics - Main
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'shaunsingh/nord.nvim'
    Plug 'maksimr/vim-jsbeautify'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'sbdchd/neoformat'
    Plug ('prettier/vim-prettier', {['do'] = function() vim.cmd('yarn install') end})

    --Functionalities
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua' -- Nerdtree replacement
    Plug 'scrooloose/nerdcommenter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'Yggdroot/indentLine'
    Plug 'sheerun/vim-polyglot'
    Plug 'chrisbra/Colorizer'
    Plug 'vim-scripts/loremipsum'

    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    Plug 'dkarter/bullets.vim'
    Plug ('godlygeek/tabular', {['for'] = 'markdown'})
    Plug ('plasticboy/vim-markdown', {['for'] = 'markdown'})
    --Plug ('iamcco/markdown-preview.nvim', {['do'] = function() vim.cmd('cd app & yarn install') end})

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug ('nvim-treesitter/nvim-treesitter', {['do'] = function() vim.cmd(':TSUpdate') end})
    Plug 'lukas-reineke/indent-blankline.nvim'

    -- From Vim
    --Plug 'mileszs/ack.vim'
    Plug 'hashrocket/vim-macdown'
    Plug 'Chiel92/vim-autoformat'
    Plug 'junegunn/vim-peekaboo'
    Plug 'yegappan/mru'
    Plug 'SidOfc/mkdx'
    Plug 'tpope/vim-unimpaired'

    --LSP Support
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'

    -- Autocompletion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'

    -- Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'VonHeikemen/lsp-zero.nvim'

    vim.call('plug#end')

    --LSP config
    require("mason").setup()
    require('mason.settings').set({
            ui = {
                border = 'rounded'
            }
        })
    local lsp = require('lsp-zero')
    lsp.preset('recommended')
    lsp.setup{ options = {call_servers = 'mason'  } }

    require('lualine').setup{
        options = {
            theme = theme,
            component_separators = '',
            section_separators = { left = '', right = '' },
        }
    }

    require("bufferline").setup{
        options = {
            separator_style = "thin",
            indicator_icon = ' ',
            highlights = highlights
        }
    }

    require('nvim-tree').setup {
        disable_netrw        = false,
        hijack_netrw         = true,
        open_on_setup        = false,
        ignore_ft_on_setup   = {},
        auto_reload_on_write = true,
        open_on_tab          = false,
        hijack_cursor        = false,
        update_cwd           = false,
        hijack_unnamed_buffer_when_opening = false,
        hijack_directories   = {
            enable = true,
            auto_open = true,
        },
        diagnostics = {
            enable = false,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            }
        },
        update_focused_file = {
            enable      = false,
            update_cwd  = false,
            ignore_list = {}
        },
        system_open = {
            cmd  = nil,
            args = {}
        },
        filters = {
            dotfiles = false,
            custom = {}
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 500,
        },
        view = {
            width = 30,
            height = 30,
            hide_root_folder = false,
            side = 'left',
            preserve_window_proportions = false,
            mappings = {
                custom_only = false,
                list = {}
            },
            number = false,
            relativenumber = false,
            signcolumn = "yes"
        },
        trash = {
            cmd = "trash",
            require_confirm = true
        },
        actions = {
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = {
                            "notify",
                            "packer",
                            "qf"
                        }
                    }
                }
            }
        }
    }

    require("nvim-treesitter.configs").setup {
        highlight = {
            -- ...
        },
        -- ...
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        }
    }

    --" Python3 VirtualEnv
    --let g:python3_host_prog =expand('/opt/homebrew/bin/python3')
    vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

    -- jsbeautify 
    vim.cmd[[
    """"""""""""""""""""""""""""""
    "=> JSBeautify
    """"""""""""""""""""""""""""""
    
    "map <c-f> :call JsBeautify()<cr>
    "for js
    autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
    "for json
    autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
    "for jsx
    autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
    "for html
    autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
    "for css or scss
    autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
    ]]

    --Nerdcommenter
    vim.cmd[[filetype plugin on]]
    vim.g.NERDCreateDefaultMappings = 1

end

return M

