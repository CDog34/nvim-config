runtime config.lua

set termguicolors
set ignorecase
set smartcase
set cursorline
set number
set colorcolumn=80
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set mouse=

" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
syntax enable
colorscheme hatsunemiku
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE

let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 24

nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

nnoremap <c-p> :call fzf#Open()<cr>

let g:ag_cli = 'rg'

nnoremap <c-u> :Mru<cr>

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldlevel=1
nnoremap <space> za

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" let g:airline_symbols.colnr = "\u33c7"
let g:airline_theme = 'hatsunemiku'

autocmd BufWritePre *.go :lua vim.lsp.buf.format({ timeout_ms = 2000 })
autocmd BufWritePre *.cpp :lua vim.lsp.buf.format({ timeout_ms = 2000 })
autocmd BufWritePre *.ts :lua vim.lsp.buf.format({ insertSpaceBeforeFunctionParenthesis = true,insertSpaceAfterConstructor = true, timeout_ms = 2000 })
autocmd BufWritePre *.json :lua vim.lsp.buf.format({ timeout_ms = 2000 })
autocmd BufWritePre *.css :lua vim.lsp.buf.format({ timeout_ms = 2000 })
autocmd BufWritePre *.html :lua vim.lsp.buf.format({ timeout_ms = 2000 })
autocmd BufNewFile,BufRead *.pug set filetype=pug

nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>c :lua require'dap'.continue()<cr>
nnoremap <leader>t :lua require'dap'.terminate()<cr>
nnoremap <leader>r :lua require'dap'.repl.toggle()<cr>
nnoremap <leader>n :lua require'dap'.step_over()<cr>
nnoremap <leader>i :lua require'dap'.step_into()<cr>
nnoremap <leader>u :lua require'dapui'.toggle()<cr>

