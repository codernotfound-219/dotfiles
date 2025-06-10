return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },

  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("eslint")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("rust_analyzer")

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = 'Lsp: ' .. desc })
        end
        local tele = require("telescope.builtin")

        map('gd', tele.lsp_definitions, 'Goto Definition')
        map('<leader>ts', tele.lsp_document_symbols, 'Doc Symbols')
        map('<leader>tS', tele.lsp_dynamic_workspace_symbols, 'Dynamic Symbols')

        map('K', vim.lsp.buf.hover, 'hover')
        map('<leader>E', vim.diagnostic.open_float, 'diagnostic')
        map('<leader>k', vim.lsp.buf.signature_help, 'sig help')
        map('<leader>rn', vim.lsp.buf.rename, 'rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'code action')
        map('<leader>wf', vim.lsp.buf.format, 'format')

        map('[d', vim.diagnostic.goto_prev, 'previous diagnostic')
        map(']d', vim.diagnostic.goto_next, 'next diagnostic')
      end,
    })
    require("lspconfig.ui.windows").default_options.border = "single"
  end
}
