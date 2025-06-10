return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {"j-hui/fidget.nvim",  opts = {} },
  },

  config = function()
    require("mason").setup()

    -- ADD LSP SERVERS AS REQUIRED
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              -- SET: vim as global, {annoyin af}
              globals = {
                "vim",
                "Snacks",
              },
            },
          },
        },
      },
      clangd = {},
      eslint = {},
      ts_ls = {},
    }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "eslint",
        "ts_ls",
        "lua_ls",
        "clangd",
        "rust_analyzer",
      },
      handlers = {
        function (server_name) --Default Handler
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end
      },
    })

    require("lspconfig.ui.windows").default_options.border = "single"
  end
}
