
local M = {}

function M.setup()

local vim = vim
local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath "config" .. "/lua/packer_compiled.lua"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  require("packer").packadd = "packer.nvim"
end

local Packer = augroup("packer_user_config", { clear = true })

-- Automatically re-compile packer whenever you save packer.lua
autocmd("BufWritePost", {
  callback = function()
    vim.cmd [[ source <afile> | PackerCompile ]]
  end,
  group = Packer,
  pattern = "packer.lua",
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  compile_path = compile_path,
  git = {
    clone_timeout = 300,
  },
  working_sym = "", -- The symbol for a plugin being installed/updated
  error_sym = "✗", -- The symbol for a plugin with an error in installation/updating
  done_sym = "✓", -- The symbol for a plugin which has completed installation/updating
}

-- packer config
 require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- Aesthetics - Main
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'akinsho/bufferline.nvim'
    use 'ryanoasis/vim-devicons'
    use 'shaunsingh/nord.nvim'
    use 'maksimr/vim-jsbeautify'
    use 'ghifarit53/tokyonight-vim'
    use 'EdenEast/nightfox.nvim'
    use 'marko-cerovac/material.nvim'
    use 'sbdchd/neoformat'
    use ('prettier/vim-prettier', {['do'] = function() vim.cmd('yarn install') end})
    use {'stevearc/dressing.nvim'}

    --Functionalities
    -- use 'tpope/vim-fugitive'
    use 'kyazdani42/nvim-tree.lua' -- Nerdtree replacement
    use 'sheerun/vim-polyglot'
    use 'chrisbra/Colorizer'
    use 'vim-scripts/loremipsum'
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'
    use 'dkarter/bullets.vim'
    use ('godlygeek/tabular', {['for'] = 'markdown'})
    use ('plasticboy/vim-markdown', {['for'] = 'markdown'})
    use 'karb94/neoscroll.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use ('nvim-treesitter/nvim-treesitter', {['do'] = function() vim.cmd(':TSUpdate') end})
    use 'lukas-reineke/indent-blankline.nvim'
    use { 'p00f/nvim-ts-rainbow' }
    use { 'ggandor/lightspeed.nvim' }
    use { 'ethanholz/nvim-lastplace' }
    use { 'windwp/nvim-ts-autotag' }

    -- From Vim
    --use 'mileszs/ack.vim'
    use 'hashrocket/vim-macdown'
    use 'Chiel92/vim-autoformat'
    use 'junegunn/vim-peekaboo'
    --use 'gennaro-tedesco/nvim-peekup'
    use 'yegappan/mru'
    use 'SidOfc/mkdx'
    use 'tpope/vim-unimpaired'

    --LSP Support
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
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
                        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
                        open_split = { "<c-x>" }, -- open buffer in new split
                        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
                        open_tab = { "<c-t>" }, -- open buffer in new tab
                        jump_close = {"o"}, -- jump to the diagnostic and close the list
                        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
                        toggle_preview = "P", -- toggle auto_preview
                        hover = "K", -- opens a small popup with the full multiline message
                        preview = "p", -- preview the diagnostic location
                        close_folds = {"zM", "zm"}, -- close all folds
                        open_folds = {"zR", "zr"}, -- open all folds
                        toggle_fold = {"zA", "za"}, -- toggle fold of current file
                        previous = "k", -- preview item
                        next = "j" -- next item
                    },
                    indent_lines = true, -- add an indent guide below the fold icons
                    auto_open = false, -- automatically open the list when you have diagnostics
                    auto_close = false, -- automatically close the list when you have no diagnostics
                    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
                    auto_fold = false, -- automatically fold a file trouble list at creation
                    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
                    signs = {
                        -- icons / text used for a diagnostic
                        error = "",
                        warning = "",
                        hint = "",
                        information = "",
                        other = "﫠"
                    },
                use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
                }
            }
        end
    }
    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use 'VonHeikemen/lsp-zero.nvim'

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
        autotag = { enable = true },

        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = 50000, -- Do not enable for files with more than n lines, int
            --colors = {}, -- table of hex strings
            --termcolors = {} -- table of colour name strings
        }
    }


    require('lualine').setup{
        options = {
            --theme = theme,
            component_separators = '',
            section_separators = { left = '', right = '' },
            --section_separators = { left = '', right = '' },
        }
    }

    require('bufferline').setup{
        options = {
        indicator = {
                icon = '|', -- this should be omitted if indicator style is not 'icon'
                style = 'icon',
            },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        separator_style = "thin",
        }
    }

    -- vimsurround replacement 
    use({
    "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
    })

    -- NerdCommenter replacement
    use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
    }

    -- autopairs replacement
    use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
    }

    -- neoscroll
    require('neoscroll').setup()

    --identlines
    require("indent_blankline").setup {
    space_char_blankline = " ",
      char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
      },
    }

    --lastplace
    require('nvim-lastplace').setup {
        lastplace_ignore_buftype={"quickfix","nofile","help"},
        lastplace_ignore_filetype={"gitcommit","gitrebase","svn","hgcommit"},
        lastplace_open_folds= true
    }

    -- dashboard
    use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
    }

    require'lightspeed'.setup {
        ignore_case = false,
        exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
        --- s/x ---
        jump_to_unique_chars = { safety_timeout = 400 },
        match_only_the_start_of_same_char_seqs = true,
        force_beacons_into_match_width = false,
        -- Display characters in a custom way in the highlighted matches.
        substitute_chars = { ['\r'] = '¬', },
        -- These keys are captured directly by the plugin at runtime.
        special_keys = {
            next_match_group = '<space>',
            prev_match_group = '<tab>',
        },
        --- f/t ---
        limit_ft_matches = 4,
        repeat_ft_with_target_char = false,
    }
    -- automatically setup config on bootstrap
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

end

return M
