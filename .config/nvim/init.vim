language en_US.utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set clipboard+=unnamedplus " Use system clipboard
let mapleader = "\<Space>"
set number relativenumber
set linebreak
set showbreak=↪
set nowrap
set scrolloff=3 " Minimum lines to keep above and below cursor when scrolling
set noshowmode " Do not display current mode because we have lightline
set undofile " Preserve undo history when exiting vim
set spell " Enable spellcheck
set signcolumn=yes " Always draw sign column. Prevent buffer moving when adding/deleting sign.
set nocompatible " Required for polyglot
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
Plug 'andymass/vim-matchup'
Plug 'jiangmiao/auto-pairs'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'

" Fuzzy Finder
Plug 'airblade/vim-rooter'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'plasticboy/vim-markdown'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'sheerun/vim-polyglot'

" LSP setup
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'ray-x/lsp_signature.nvim'

" Completion
Plug 'tzachar/fuzzy.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'tzachar/cmp-fuzzy-buffer'
Plug 'tzachar/cmp-fuzzy-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Discord presence
Plug 'andweeb/presence.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

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

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Replace all with S
nnoremap S :%s//g<left><left>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Ctrl+k as Esc
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Jump to start and end of line using the home row keys
map H ^
map L $

" ; as : for commands
nnoremap ; :

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Open hotkeys
map <leader>o :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick save and quit
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

" Run Makefile
noremap <leader>m :!make<space>
noremap <leader>M :!make<CR>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_

" Git
nmap <leader>ga :Git add -p<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gP :Git push<CR>
nmap <leader>gp :Git pull<CR>

" Completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.

" ripgrep
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif
noremap <leader>s :Rg<space>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow -HE .git' : printf('fd --type file --follow -HE .git | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" Svelte js/ts and css detection
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]

let g:ft = ''

" Svelte ts and scss syntax highlighting
let g:vim_svelte_plugin_use_typescript=1
let g:vim_svelte_plugin_use_sass=1

" Enable type inlay hints in rust
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

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

-- LSP setup
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>Q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('nvim-lsp-installer').setup { on_attach = on_attach, automatic_installation = true, capabilities = capabilities }
require('lspconfig').rust_analyzer.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').vimls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').bashls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').clangd.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').cssls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').dockerls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').emmet_ls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').golangci_lint_ls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').gopls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').html.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').jsonls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').jdtls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').kotlin_language_server.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').ltex.setup { on_attach = on_attach, capabilities = capabilities } -- or texlab
require('lspconfig').sumneko_lua.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').svelte.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').taplo.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').tsserver.setup { on_attach = on_attach, capabilities = capabilities }
-- TODO: choose markdown LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- Indent
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
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

END

