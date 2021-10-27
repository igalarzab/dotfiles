---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

local api, cmd, g, opt, o = vim.api, vim.cmd, vim.g, vim.opt, vim.o


---------------------------------------------------------------------------
-- Global Config
---------------------------------------------------------------------------

-- Disable python2 and perl support
g.loaded_python_provider = 0
g.loaded_perl_provider = 0

-- Use pyenv for python3 support
g.python3_host_prog = '~/.pyenv/versions/py3nvim/bin/python'


---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------

require('packer').startup(function()
    -- Self Update
    use('wbthomason/packer.nvim')

    -- NeoVim helpers
    use('neovim/nvim-lspconfig')
    use('glepnir/lspsaga.nvim')
    use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})

    -- Auto-Completion
    use('hrsh7th/nvim-compe')
    use({'nvim-telescope/telescope.nvim', requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'kyazdani42/nvim-web-devicons'},
    }})

    -- UI plugins
    use('navarasu/onedark.nvim')
    use({'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}})
    use({'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons', opt = true}})
    use({'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}})

    -- Editor plugins
    use('editorconfig/editorconfig-vim')
    use('windwp/nvim-autopairs')
    use('sbdchd/neoformat')
end)


---------------------------------------------------------------------------
--  Editor Config
---------------------------------------------------------------------------

-- Keys
g.mapleader = ','                       -- Lead with ,
opt.mouse = 'a'                         -- Activate mouse support
opt.clipboard = 'unnamed'               -- Use system clipboard

-- Visuals
opt.termguicolors = true                -- Color support
opt.number = true                       -- Show always line numbers
opt.relativenumber = true               -- But relatives to the current one
opt.scrolloff = 4                       -- Keep 4 lines off the edges of the screen

-- Indenting
opt.wrap = false                        -- No wrap lines
opt.tabstop = 4                         -- A tab is 4 spaces
opt.softtabstop = 4                     -- Also softabs
opt.expandtab = true                    -- Expand the tabs
opt.backspace = 'indent,eol,start'      -- Allow backspacing over everything
opt.autoindent = true                   -- Always indent
opt.smartindent = true                  -- Trying to be smart
opt.copyindent = true                   -- Copy the previous indentation
opt.shiftwidth = 4                      -- Four spaces on indenting
opt.shiftround = true                   -- Use multiples of swidth
opt.textwidth = 120                     -- Width of 120 chars per line

-- Search
opt.ignorecase = true                   -- Ignore case when searching
opt.smartcase = true                    -- Only if it's all lowercase
opt.hlsearch = true                     -- Highlight the terms
opt.incsearch = true                    -- Show as you type

-- Notifications
opt.visualbell = true                   -- Please don't beep
opt.errorbells = false                  -- Really, don't

-- History
opt.history = 1000                      -- A big history
opt.undolevels = 1000                   -- Same for undos

-- Autocomplete Menus
opt.wildmode = 'list:longest,full'      -- AutoComplete menus more useful
opt.wildchar = 9                        -- Iterate with the tab through them
o.completeopt = 'menuone,noselect'      -- Completion popups

-- Menus
opt.showmode = true                     -- Show status
opt.showcmd = true                      -- Show typing commands
opt.ruler = true                        -- Show position info
opt.laststatus = 2                      -- Show the status line always
opt.ch = 2                              -- Command line height
opt.backspace = '2'                     -- Backspacing over everything in insert mode
opt.whichwrap:append('<,>,h,l,[,]')     -- Move between lines with the arrows


---------------------------------------------------------------------------
-- Plugins Config
---------------------------------------------------------------------------

-- Auto Pairs
require('nvim-autopairs').setup()

require('nvim-autopairs.completion.compe').setup({
    map_cr = true,
    map_complete = true
})

-- Completion
require('compe').setup({
    enabled = true,
    source = {
        path = true,
        buffer = true,
        tags = true,
        spell = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        treesitter = true,
    },
})

-- Git Signs
require('gitsigns').setup()

-- LuaLine
require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'onedark',
    },
    sections = {
        lualine_b = {
            'branch',
        },
        lualine_x = {
            { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
            'filetype',
        },
    },
})

-- LSP
local nlsp = require('lspconfig')
nlsp.gopls.setup({})
nlsp.jsonls.setup({})
nlsp.pyright.setup({})
nlsp.stylelint_lsp.setup({})
nlsp.tsserver.setup({})
nlsp.yamlls.setup({})

-- LSP - Formatting and auto-save
api.nvim_set_keymap("n", "<Leader>ff", ":lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = true })
vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()]]

-- LSP Saga
require('lspsaga').init_lsp_saga({
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = 'round',
    finder_action_keys = {
        open = '<CR>', vsplit = '<C-v>', split = '<C-h>', quit = '<ESC>',
        scroll_down = '<C-f>', scroll_up = '<C-b>'
    },
    code_action_keys = {
        quit = '<ESC>', exec = '<CR>'
    },
    rename_action_keys = {
        quit = '<ESC>', exec = '<CR>'
    },
})

api.nvim_set_keymap('n', '<Leader>gr', ':Lspsaga lsp_finder<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>gs', ':Lspsaga signature_help<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>gd', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>ga', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>ge', ':Lspsaga diagnostic_jump_next<CR>', { noremap = true, silent = true })

-- OneDark
require('onedark').setup()

-- Telescope
api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-g>', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Tree Browser
g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
g.nvim_tree_gitignore = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_special_files = {}
g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1, folder_arrows = 1}
api.nvim_set_keymap('n', '<Leader>tr', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- TreeSitter config
require('nvim-treesitter.configs').setup({
    ensure_installed = 'maintained',
    highlight = {enable = true},
    incremental_selection = {enable = true},
    indent = {enable = true},
})


---------------------------------------------------------------------------
-- Shorcuts
---------------------------------------------------------------------------

-- ,ws -> Delete all whitespaces
api.nvim_set_keymap('n', '<Leader>ws', ':%s/ \\+$//gc<CR>', { noremap = true })

-- ,se -> Spellcheck in English
api.nvim_set_keymap('n', '<Leader>se', ':setlocal spell spelllang=en<CR>', { noremap = true })

-- ,ss -> Spellcheck in Spanish
api.nvim_set_keymap('n', '<Leader>ss', ':setlocal spell spelllang=es<CR>', { noremap = true })

