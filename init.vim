runtime config.lua

set termguicolors
set ignorecase
set smartcase
set cursorline
set number
set colorcolumn=80

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
syntax enable
colorscheme OceanicNext
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
let g:airline_symbols.colnr = "\u33c7"

function FormatWithEslint()
	lua vim.lsp.buf.formatting_sync({insertSpaceBeforeFunctionParenthesis = true,insertSpaceAfterConstructor = true})
	" EslintFixAll
endfunction

autocmd BufWritePre *.go :lua vim.lsp.buf.formatting()
autocmd BufWritePre *.ts execute 'call FormatWithEslint()'
autocmd BufWritePre *.json :Format

nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>c :lua require'dap'.continue()<cr>
nnoremap <leader>t :lua require'dap'.terminate()<cr>
nnoremap <leader>r :lua require'dap'.repl.toggle()<cr>
nnoremap <leader>u :lua require'dapui'.toggle()<cr>

