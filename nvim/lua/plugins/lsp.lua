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

    -- 1. Define Common Capabilities (for nvim-cmp)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- 2. Apply capabilities to all servers by default (Native 0.11 feature)
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- 3. Configure asm_lsp (Replaces the deprecated require('lspconfig') setup)
    -- Since you work with 8086/Assembly, this ensures the correct filetypes and root detection.
    vim.lsp.config.asm_lsp = {
      cmd = { "asm-lsp" },
      filetypes = { "asm", "s" },
      -- In Nvim 0.11, use 'root_markers' instead of 'root_dir = util.root_pattern'
      root_markers = { ".asm-lsp.toml", ".git" }, 
    }

    -- 4. Enable Servers
    -- Using a list makes this easier to manage
    local servers = {
      "lua_ls",
      "verible",
      "clangd",     -- Important for your C++ algorithms
      "eslint",
      "ts_ls",
      "rust_analyzer",
      "asm_lsp"     -- Explicitly enable asm_lsp after configuring it above
    }

    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end

    -- 5. LspAttach Keymaps
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
    
    -- Optional: Configure border globally for floating windows
    -- (The old require("lspconfig.ui.windows") is also deprecated)
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "single"
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  end
}
