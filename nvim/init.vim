language en_US.utf-8
scriptencoding utf-8
set clipboard+=unnamedplus
set number relativenumber
set linebreak
set showbreak=↪
set scrolloff=3
set noshowmode
set undofile
filetype plugin indent on

call plug#begin()
 " Plugin Section
 Plug 'dracula/vim'
 Plug 'rakr/vim-one'
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'preservim/nerdcommenter'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-rhubarb'
 Plug 'cohama/lexima.vim'

 if has("nvim")
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-lua/completion-nvim'
    Plug 'onsails/lspkind-nvim'
    Plug 'folke/lsp-colors.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'itchyny/lightline.vim'
    Plug 'evanleck/vim-svelte'
    Plug 'pangloss/vim-javascript'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'codechips/coc-svelte', {'do': 'npm install'}
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'

    set timeoutlen=500


    Plug 'Shougo/context_filetype.vim'
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

    Plug 'prettier/vim-prettier', { 'do': 'npm install' }
    " Prettier Settings
    let g:prettier#quickfix_enabled = 0
    let g:prettier#autoformat_require_pragma = 0
    au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

    autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
    autocmd BufWritePre *.go lua goimports(100)
endif
call plug#end()

" Color schemes
if (has ("termguicolors"))
	set termguicolors
endif

if (has ("nvim")) 
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

syntax enable
colorscheme one
set background=dark
let g:one_allow_italics = 1
let g:airline_theme='one'
let g:lightline = { 'colorscheme': 'one' }
au TextYankPost * silent! lua vim.highlight.on_yank()

" General tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set completeopt=menuone,noinsert,noselect
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

