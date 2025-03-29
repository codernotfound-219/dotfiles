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
      clangd = {},
      eslint = {},
      ts_ls = {},
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

      rust_analyzer = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
      },
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

    --[[
    local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({
      capabilities = capabilities,
    })
    lspconfig.pyright.setup({
      capabilities = capabilities,
    })
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
    })
    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
    })
    --]]

    require("lspconfig.ui.windows").default_options.border = "single"
    --[[ -- ON_ATTACH
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    vim.diagnostic.config({
      virtual_text = false,
      float = {
        -- header = false,
        border = "rounded",
      },
    })

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = "",
        },
      },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
    --]]

    -- BUG: (DOES not WORK) ADD DESIRED LSPS TO THIS LIST:
    --[[
    local servers = {
      clangd = {},

      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                "vim",
              },
            },
          },
        },
      },

      rust_analyzer = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
      },
    }


    -- CONFIGURE MASON FIRST

    local ensure_installed = vim.tbl_keys(servers or {})

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    -- CONFIGURE MASON-LSPCONFIG SECOND
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "rust_analyzer",
      },
    })

    require("lspconfig.ui.windows").default_options.border = "single"

    -]]
--[[
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
    })
--]]
  end
}
