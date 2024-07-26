-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap=true, silent=true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
--  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<A-f>', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local nvim_lsp = require('lspconfig')

require('lspconfig')['tsserver'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = false
}

require('lspconfig')['denols'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['rust_analyzer'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}

require('lspconfig')['elmls'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['ocamllsp'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['nixd'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['astro'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['tailwindcss'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- root_dir = nvim_lsp.util.root_pattern("tailwind.config.js"),
}

require('lspconfig')['emmet_ls'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['svelte'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['rescriptls'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['cssls'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['typst_lsp'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['solargraph'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['elixirls'].setup {
  cmd = { "elixir-ls" },
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['unison'].setup {
  on_attach = on_attach,
  flags = lsp_flags
}
