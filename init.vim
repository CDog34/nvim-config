runtime config.lua

set termguicolors
set ignorecase
set smartcase
set cursorline

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 24

nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

nnoremap <c-p> :call fzf#Open()<cr>

let g:ag_cli = 'rg'

nnoremap <c-u> :Mru<cr>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=1
nnoremap <space> za
