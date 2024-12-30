local vim = vim

local M = {}

function M.config()

    local set = vim.opt
    set.tabstop = 4
    set.softtabstop = 4
    set.shiftwidth = 4
    set.expandtab = true
    set.smarttab = true
    set.autoindent = true
    set.incsearch = true
    set.ignorecase = true
    set.smartcase = true
    set.hlsearch = true
    set.ruler = true
    set.laststatus = 2
    set.showcmd = true
    set.showmode = true
    set.list = true
    set.listchars = {eol = '↴', tab = '▸ ', trail = '»', space = '⋅'}
    set.fillchars = {
        stl = ' ',
        stlnc = ' ',
        diff = '∙',
        eob = ' ',
        fold = '·',
        horiz = '━',
        horizup = '┻',
        horizdown = '┳',
        vert = '┃',
        vertleft = '┫',
        vertright = '┣',
        verthoriz = '╋'
    }
    set.wrap = true
    set.breakindent = true
    set.encoding = 'UTF-8'
    set.number = true
    set.title = true
    set.mouse = 'a'
    set.spelllang = 'es_es'
    set.wrap = true
    set.linebreak = true
    set.textwidth = 0
    set.wrapmargin = 0

    -- Do not display --INSERT/VISUAL-- modes below airline
    vim.cmd [[set noshowmode]]

    -- let g:python3_host_prog =expand('/opt/homebrew/bin/python3')
    vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

    -- Markdown
    -- disable header folding
    vim.g.vim_markdown_folding_disabled = 1
    -- do not use conceal feature, the implementation is not so good
    vim.g.vim_markdown_conceal = 0
    -- disable math tex conceal feature
    vim.g.tex_conceal = ""
    vim.g.vim_markdown_math = 1
    -- support front matter of various format
    vim.g.vim_markdown_frontmatter = 1 -- for YAML format
    vim.g.vim_markdown_toml_frontmatter = 1 -- for TOML format
    vim.g.vim_markdown_json_frontmatter = 1 -- for JSON format

    -- Neoformat
    vim.g.neoformat_run_all_formatters = 1
    vim.cmd [[augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END]]

    -- indentLine
    vim.g.indentLine_char = ' ▏'

    if vim.g.neovide then
        -- https://neovide.dev/configuration.html
        vim.g.neovide_scale_factor = 1.2
        vim.api.nvim_command "set autochdir"
        local default_path = vim.fn.expand("~/Downloads/")
        vim.api.nvim_set_current_dir(default_path)
        -- require("telescope.builtin").find_files(opts)
    end

end
return M
