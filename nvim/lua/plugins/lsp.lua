return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "mfussenegger/nvim-jdtls", -- Added for Java Support
    { "j-hui/fidget.nvim", opts = {} },
  },

  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = { exclude = { "jdtls" } },
      exclude = { "jdtls" },
    })
    require('mason-tool-installer').setup({
      ensure_installed = {
        'jdtls', -- This ensures it gets downloaded to the mason directory
        'lua_ls',
        'clangd',
        'asm-lsp',
      },
      run_on_start = true,
    })

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
      "clangd", -- Important for your C++ algorithms
      "eslint",
      "ts_ls",
      "rust_analyzer",
      "asm_lsp" -- Explicitly enable asm_lsp after configuring it above
    }

    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end

    --Bug: very stupid solution, but it works. (Fix for double-client in jdtls)
    -- Stop the unwanted lspconfig-started jdtls client (cmd is a function in your :LspInfo).
    local kill_group = vim.api.nvim_create_augroup("KillLspconfigJdtls", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = kill_group,
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or client.name ~= "jdtls" then
          return
        end

        -- nvim-lspconfig's jdtls shows cmd as a function; nvim-jdtls uses an argv table.
        if type(client.config.cmd) == "function" then
          -- defer so we don't fight attach flow
          vim.schedule(function()
            pcall(vim.lsp.stop_client, client.id)
          end)
        end
      end,
    })

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

    -- Autocmd for Java
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

        -- CHANGE THIS LINE: From config_linux to config_mac
        local config_dir = mason_path .. "/config_mac"

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

        -- NEW: robust root_dir detection (drop-in replacement for your current root_dir line)
        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "settings.gradle" }
        local root = vim.fs.find(root_markers, { upward = true })[1]
        local root_dir = root and vim.fs.dirname(root) or vim.fn.getcwd()

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", launcher_jar,
            "-configuration", config_dir, -- Now points to macOS config
            "-data", workspace_dir,
          },
          root_dir = root_dir,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        }

        require('jdtls').start_or_attach(config)
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
