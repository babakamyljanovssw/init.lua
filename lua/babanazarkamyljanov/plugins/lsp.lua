return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
  },

  config = function()
    -- Reserve a space in the gutter
    -- This will avoid an annoying layout shift in the screen
    vim.opt.signcolumn = "yes"

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    local lspconfig_defaults = require("lspconfig").util.default_config
    lspconfig_defaults.capabilities =
      vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Shows lsp notifications and updates on the bottom
    require("fidget").setup({})

    -- This is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }
        --        local client = vim.lsp.get_client_by_id(event.data.client_id)

        --        if not client then return end
        --        client.server_capabilities.documentFormattingProvider = true

        --        if client.supports_method("textDocument/formatting") then
        --          vim.api.nvim_create_autocmd("BufWritePre", {
        --            buffer = event.buf,
        --            callback = function()
        --              vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
        --            end
        --          })
        --        end

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.goto_prev()
        end, opts)
      end,
    })

    local lspconfig = require("lspconfig")

    lspconfig["ts_ls"].setup({
      capabilities = lspconfig_defaults.capabilities,
    })

    lspconfig["html"].setup({
      --cmd = { "vscode-html-language-server", "--stdio" },
      capabilities = lspconfig_defaults.capabilities,
      --filetypes = { "html", "templ" },
      --init_options = {
      --configurationSection = { "html", "css", "javascript" },
      --embeddedLanguages = {
      --css = true,
      --javascript = true,
      --},
      --provideFormatter = true,
      --},
    })

    lspconfig["lua_ls"].setup({
      capabilities = lspconfig_defaults.capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = {
            globals = {
              "vim",
              "require",
            },
          },
        },
      },
    })

    lspconfig["csharp_ls"].setup({
      capabilities = lspconfig_defaults.capabilities,
    })

    lspconfig["angularls"].setup({
      capabilities = lspconfig_defaults.capabilities,
    })

    lspconfig["cssls"].setup({
      capabilities = lspconfig_defaults.capabilities,
    })

    -- Autocompletion
    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
    })

    -- Completions for command mode
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}
