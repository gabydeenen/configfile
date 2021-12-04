
set shell=powershell
syntax on

call plug#begin('~/AppData/Local/nvim/plugged')
" below are some vim plugins for demonstration purpose.
" add the plugin you want to use here.
" ripgrep
Plug 'duane9/nvim-rg'
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
"Completion framework
Plug 'hrsh7th/nvim-cmp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'joshdick/onedark.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'
 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

inoremap jj <Esc>

" set leader key to ,
let g:mapleader=","

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" do block comment
vmap \c :s!^!--!<CR>
vmap \u :s!^--!!<CR>


colorscheme gruvbox
set pastetoggle=<F2>
set autoindent
set number relativenumber
set timeoutlen=500
set textwidth=256

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
"
lua <<EOF
local nvim_lsp = require'lspconfig'
require'lspconfig'.rls.setup{}


--		local opts = {
--			tools = { -- rust-tools options
--				autoSetHints = true,
--				hover_with_actions = true,
--				inlay_hints = {
--					show_parameter_hints = false,
--					parameter_hints_prefix = "",
--					other_hints_prefix = "",
--				},
--			},
--
--			-- all the opts to send to nvim-lspconfig
--			-- these override the defaults set by rust-tools.nvim
--			-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
--			server = {
--				-- on_attach is a callback called when the language server attachs to the buffer
--				-- on_attach = on_attach,
--				settings = {
--					-- to enable rust-analyzer settings visit:
--					-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--					["rust-analyzer"] = {
--						-- enable clippy on save
--						checkOnSave = {
--							command = "clippy"
--						},
--					}
--				}
--			},
--		}
--
--		require('rust-tools').setup(opts)

EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF
