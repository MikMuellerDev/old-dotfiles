language en_US.utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set clipboard+=unnamedplus
set noswapfile
set number relativenumber
set linebreak
set showbreak=↪
" Minimum lines to keep above and below cursor when scrolling
set scrolloff=3
set noshowmode
set undofile
set nowrap
set spell
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Plugins
call plug#begin()

" Theme
Plug 'rakr/vim-one'

" VIM enhancements
Plug 'editorconfig/editorconfig-vim'
Plug 'max397574/better-escape.nvim'
Plug 'lewis6991/spellsitter.nvim'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'

" Fuzzy Finder
Plug 'airblade/vim-rooter'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Treesitter setup
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
"Plug 'p00f/nvim-ts-rainbow'

" LSP setup
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Completion
Plug 'tzachar/fuzzy.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'tzachar/cmp-fuzzy-buffer'
Plug 'tzachar/cmp-fuzzy-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Discord presence
Plug 'andweeb/presence.nvim'

" Homescript
Plug 'mikmuellerdev/vim-homescript'

call plug#end()

" Automatically install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Theming
syntax on
colorscheme one
set background=dark
let g:one_allow_italics = 1
let g:airline_theme='one'
let g:lightline = { 'colorscheme': 'one' }
au TextYankPost * silent! lua vim.highlight.on_yank()

" Enable true-color support
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces
set shiftround

" Completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

lua << END

-- Completion
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  })
})

-- TreeSitter
require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    highlight = {
        enable = true,
    },
--    rainbow = {
--        enable = true,
--        extended_mode = true,
--        max_file_lines = nil,
--    }
}

-- LSP setup
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('nvim-lsp-installer').setup { automatic_installation = true, capabilities = capabilities }
require('lspconfig').rust_analyzer.setup { capabilities = capabilities }
require('lspconfig').vimls.setup { capabilities = capabilities }
require('lspconfig').bashls.setup { capabilities = capabilities }
require('lspconfig').clangd.setup { capabilities = capabilities }
require('lspconfig').cssls.setup { capabilities = capabilities }
require('lspconfig').dockerls.setup { capabilities = capabilities }
require('lspconfig').emmet_ls.setup { capabilities = capabilities }
require('lspconfig').golangci_lint_ls.setup { capabilities = capabilities } -- or gopls
require('lspconfig').html.setup { capabilities = capabilities }
require('lspconfig').jsonls.setup { capabilities = capabilities }
require('lspconfig').jdtls.setup { capabilities = capabilities }
require('lspconfig').kotlin_language_server.setup { capabilities = capabilities }
require('lspconfig').ltex.setup { capabilities = capabilities } -- or texlab
require('lspconfig').sumneko_lua.setup { capabilities = capabilities }
require('lspconfig').svelte.setup { capabilities = capabilities }
require('lspconfig').taplo.setup { capabilities = capabilities }
require('lspconfig').tsserver.setup { capabilities = capabilities }
-- TODO: choose markdown LSP

-- Telescope (Fuzzy Finder)
require('telescope').setup {}
-- TODO: configure pickers
require('telescope').load_extension('fzf')

-- Indent
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
require('indent_blankline').setup {
    show_current_context = true,
    show_current_context_start = true,
}

-- Better escape
require("better_escape").setup {
    mapping = {"jk", "jj"},
    timeout = vim.o.timeoutlen,
    clear_empty_lines = true,
    keys = function()
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
    end,
}

-- Spell checker
require('spellsitter').setup()

END

