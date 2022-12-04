:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set linebreak
:set so=10
:set clipboard=unnamed
set number relativenumber
" :set spell

call plug#begin()

Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/lambdalisue/suda.vim'
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'https://github.com/Shatur/neovim-ayu'

call plug#end()

set encoding=UTF-8

nnoremap <C-n> :tabnew<CR>
nnoremap <C-left> :tabprevious<CR>
nnoremap <C-right> :tabnext<CR>

nnoremap U <C-r>

noremap <C-c> "+y<CR>
noremap <C-x> "+d<CR>
" noremap <C-v> "+p<CR>
noremap <C-a> ggVG<CR>

inoremap <C-v> <C-r>*

:set completeopt-=preview " For No Previews

" :colorscheme ayu

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let NERDTreeShowHidden=1
" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins

" air-line
let g:airline_powerline_fonts = 1

" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif

" " airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

:hi Normal ctermbg=none
:highlight NonText ctermbg=none



