require'gitsigns'.setup()

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'sql', 'proto' },
  callback = function() 
      vim.treesitter.start() 
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

local cmp = require'cmp'
cmp.setup{
    -- 必须指定 snippet 组件
    snippet = {
        expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
    },
    -- 配置补全内容来源
    sources = cmp.config.sources {
        -- 支持从打开的文件中补全内容
        { name = 'buffer', options= { get_bufnrs = vim.api.nvim_list_bufs } },
	-- 支持从 lsp 服务补全
        { name = 'nvim_lsp' },
	-- 支持补全文件路径，可以输入 / 或者 ~ 体验
        { name = 'path' },
    },
    mapping = cmp.mapping.preset.insert()
}

local on_attach = function(client, bufnr)
    -- 为方便使用，定义了两个工具函数
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- 配置标准补全快捷键
    -- 在插入模式可以按 <c-x><c-o> 触发补全
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

    -- 设置 normal 模式下的快捷键
    -- 第一个参数 n 表示 normal 模式
    -- 第二个参数表示按键
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    -- 跳转到定义或者声明的地方
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    -- 查看接口的所有实现
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    -- 查看所有引用当前对象的地方
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    -- 跳转到下一个/上一个语法错误
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.gotoprev()<cr>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.gotonext()<cr>', opts)
    buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signaturehelp()<cr>', opts)
    -- 手工触发格式化
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({scope="line"})<cr>', opts)
    -- 列出所有语法错误列表
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)
    -- 修改当前符号的名字
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("gopls", {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
})
vim.lsp.enable("gopls")

vim.lsp.config("jsonls", {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable("jsonls")

local utkl = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)
  local global_ts = '/home/[yourusernamehere]/.npm/lib/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

vim.lsp.config("volar", {
  on_attach = on_attach,capabilities = capabilities,
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
})
vim.lsp.enable("volar")
vim.lsp.config("cmake", {on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable("cmake")
vim.lsp.config("bashls", {on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable("bashls")
vim.lsp.config("eslint", {on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable("eslint")
vim.lsp.config("ts_ls", {on_attach = on_attach,capabilities = capabilities,})
vim.lsp.enable("ts_ls")
vim.lsp.config("sourcekit", {on_attach = on_attach,capabilities = capabilities,})
vim.lsp.enable("sourcekit")
vim.lsp.config("clangd", {on_attach = on_attach,capabilities = capabilities,})
vim.lsp.enable("clangd")
require'dap-go'.setup()
require'nvim-dap-virtual-text'.setup()

require'dap'.set_log_level('TRACE')

vim.lsp.config('jedi_language_server',{on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable('jedi_language_server')

vim.lsp.config('cssls',{on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable('cssls')

vim.lsp.config('html',{on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable('html')

vim.lsp.config('svelte',{on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable('svelte')

vim.lsp.config('tailwindcss',{on_attach = on_attach, capabilities = capabilities,})
vim.lsp.enable('tailwindcss')
